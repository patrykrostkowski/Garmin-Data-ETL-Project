USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MergeSrcTables_v2]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[p_MergeSrcTables_v2] @CutOffDate DATE AS
BEGIN

--DECLARE @CutOffDate DATE = '2024-05-01'
DECLARE @SchemaName NVARCHAR(100)
	, @ViewName NVARCHAR(100)
	, @TableName NVARCHAR(100)
	, @PrimaryColumnName NVARCHAR(100)
	, @ColumnList NVARCHAR(MAX)
	, @UpdateColumnList NVARCHAR(MAX)
	, @MergeSQL NVARCHAR(MAX)
	, @TableColumnList NVARCHAR(MAX)
	, @MatchedColumnList NVARCHAR(MAX)

DECLARE view_cursor CURSOR FOR
	SELECT SchemaName, ViewName, TableName, PrimaryColumnName
	FROM [acc].[SrcViewsConfig]
	WHERE IsActiveInd = 1 AND MergeType = 'dynamic'
OPEN view_cursor
FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @TableName, @PrimaryColumnName

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @ColumnList = (
		SELECT STRING_AGG(QUOTENAME(column_name), ', ' ) WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
	)
	--select @ColumnList

	SET @TableColumnList = (
		SELECT STRING_AGG(CONCAT(QUOTENAME(column_name),' ',DATA_TYPE) , ', ' ) WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
	)
	--select @TableColumnList
	SET @MatchedColumnList = (
		SELECT STRING_AGG(
			CONCAT('Target.', QUOTENAME(column_name),' = Source.',QUOTENAME(column_name)), ', ' )
		
		WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
	)
	--select @MatchedColumnList

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
	--print @MergeSQL
    EXEC sp_executesql @MergeSQL, N'@CutOffDate DATE', @CutOffDate

	FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @TableName, @PrimaryColumnName
END

CLOSE view_cursor
DEALLOCATE view_cursor


-- Manual merge for tables wchich dont have unique columns



END
GO
