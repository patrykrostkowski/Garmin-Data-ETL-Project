USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MergeSrcTables]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[p_MergeSrcTables] @CutOffDate DATE AS
BEGIN

--DECLARE @CutOffDate DATE = '2024-05-01'
DECLARE @SchemaName NVARCHAR(100)
	, @ViewName NVARCHAR(100)
	, @TableName NVARCHAR(100)
	, @PrimaryColumnName NVARCHAR(100)
	, @MergeType NVARCHAR(100)
	, @ColumnList NVARCHAR(MAX)
	, @UpdateColumnList NVARCHAR(MAX)
	, @MergeSQL NVARCHAR(MAX)
	, @TableColumnList NVARCHAR(MAX)
	, @MatchedColumnList NVARCHAR(MAX)

DECLARE view_cursor CURSOR FOR
	SELECT SchemaName, ViewName, TableName, PrimaryColumnName, MergeType
	FROM [acc].[SrcViewsConfig]
	WHERE IsActiveInd = 1
OPEN view_cursor
FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @TableName, @PrimaryColumnName, @MergeType

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @ColumnList = (
		SELECT STRING_AGG(QUOTENAME(column_name), ', ' ) WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		)

	SET @TableColumnList = (
		SELECT STRING_AGG(CONCAT(QUOTENAME(column_name)
								,' '
								,DATA_TYPE
								,CASE WHEN DATA_TYPE = 'nvarchar' THEN '('+CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR)+')' END
			) , ', ' ) WITHIN GROUP (ORDER BY ORDINAL_POSITION ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		)

	SET @MatchedColumnList = (
		SELECT STRING_AGG(CONCAT('Target.', QUOTENAME(column_name),' = Source.',QUOTENAME(column_name)), ', ' ) WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		)

IF @MergeType = 'dynamic'
	BEGIN
		SET @MergeSQL = '
			DROP TABLE IF EXISTS #TempSrcData;

			CREATE TABLE #TempSrcData (' + @TableColumnList + ');
		
			INSERT INTO #TempSrcData 
			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+' 
			WHERE CAST('+ QUOTENAME(@PrimaryColumnName)+' AS DATE) >= @CutOffDate;

			MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
			USING #TempSrcData AS Source
				ON Target.' + QUOTENAME(@PrimaryColumnName) + ' = Source.' + QUOTENAME(@PrimaryColumnName) + '
			WHEN MATCHED THEN
			UPDATE 
			SET '+ @MatchedColumnList + '

			WHEN NOT MATCHED THEN
			INSERT (' + @ColumnList + ')
			VALUES (' + @ColumnList + ')
			;'
		print @MergeSQL
		EXEC sp_executesql @MergeSQL, N'@CutOffDate DATE', @CutOffDate
	END

/*
Manual merge for tables that dont have date columns. 
It's based on set substraction and inserting the difference
*/
IF @MergeType = 'manual'
	BEGIN

		SET @MergeSQL = '
			DROP TABLE IF EXISTS #TempSrcData;

			CREATE TABLE #TempSrcData (' + @TableColumnList + ');
		
			INSERT INTO #TempSrcData 

			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+' 
			EXCEPT
			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@TableName)+' 

			MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
			USING #TempSrcData AS Source
				ON Target.' + QUOTENAME(@PrimaryColumnName) + ' = Source.' + QUOTENAME(@PrimaryColumnName) + '
			WHEN MATCHED THEN
			UPDATE 
			SET '+ @MatchedColumnList + '

			WHEN NOT MATCHED THEN
			INSERT (' + @ColumnList + ')
			VALUES (' + @ColumnList + ')
			;'
		print @MergeSQL
		EXEC sp_executesql @MergeSQL

	END
/*
Exception. For this table primary key is a combination of 2 columns. Ugly solution but works.
*/
IF @MergeType = 'exception'
	BEGIN
		SET @MergeSQL = '
			DROP TABLE IF EXISTS #TempSrcData;

			CREATE TABLE #TempSrcData (' + @TableColumnList + ');
		
			INSERT INTO #TempSrcData 
			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+' 
			WHERE CAST('+ QUOTENAME(@PrimaryColumnName)+' AS DATE) >= @CutOffDate;

			MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
			USING #TempSrcData AS Source
				ON Target.' + QUOTENAME(@PrimaryColumnName) + ' = Source.' + QUOTENAME(@PrimaryColumnName) + 'AND Target.activity_type = Source.activity_type'
					+ '
			WHEN MATCHED THEN
			UPDATE 
			SET '+ @MatchedColumnList + '

			WHEN NOT MATCHED THEN
			INSERT (' + @ColumnList + ')
			VALUES (' + @ColumnList + ')
			;'
		print @MergeSQL
		EXEC sp_executesql @MergeSQL, N'@CutOffDate DATE', @CutOffDate
	END


	FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @TableName, @PrimaryColumnName, @MergeType
END

CLOSE view_cursor
DEALLOCATE view_cursor

END

GO
