USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_CreateIndexesOnSourceTbls]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_CreateIndexesOnSourceTbls] AS 

/* 
Procudure that creates indexes on all source tables (except summary tables) for date/time columns with ordinal position = 1 

exec [dbo].[p_CreateIndexesOnSourceTbls]
*/


DECLARE @SchemaName NVARCHAR(255)
DECLARE @TableName NVARCHAR(255)
DECLARE @ColumnName NVARCHAR(255)

DECLARE IndexCuror CURSOR FOR
	SELECT TRIM(TABLE_SCHEMA), TRIM(TABLE_NAME), TRIM(COLUMN_NAME)
	FROM (
		SELECT t.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.ORDINAL_POSITION, ROW_NUMBER() over (partition by c.TABLE_NAME order by c.ORDINAL_POSITION) as rn
		FROM INFORMATION_SCHEMA.COLUMNS c
		JOIN INFORMATION_SCHEMA.TABLES t on c.TABLE_NAME = t.TABLE_NAME and c.TABLE_SCHEMA = t.TABLE_SCHEMA
		WHERE t.TABLE_SCHEMA = 'src' 
			AND t.TABLE_TYPE = 'BASE TABLE'
			--AND t.TABLE_NAME NOT LIKE '%SUMMARY%' 
			AND t.TABLE_NAME NOT IN ( 'GarminActivities/StepsActivities  ', 'GarminMonitoring/MonitoringInfo  ', 'GarminMonitoring/Monitoring  ')
			AND (c.DATA_TYPE LIKE '%date%' OR c.DATA_TYPE LIKE '%time%')
	) tmp WHERE tmp.rn = 1

OPEN IndexCuror
FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Add indexes for datetime columns
    DECLARE @IndexName NVARCHAR(255)
    SET @IndexName = 'IX_' + @TableName + '_' + @ColumnName

    DECLARE @SQL NVARCHAR(MAX)
	SET @SQL = 'DROP INDEX IF EXISTS [' + @IndexName + '] ON ['+ @SchemaName+'].[' + @TableName + ']' 
    EXEC sp_executesql @SQL

	SET @SQL = 'CREATE UNIQUE CLUSTERED INDEX [' + @IndexName + '] ON ['+ @SchemaName+'].[' + @TableName + '](['+@ColumnName+']);'
	EXEC sp_executesql @SQL

    FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

END

CLOSE IndexCuror
DEALLOCATE IndexCuror

/*
script to drop indexes

DECLARE @SchemaName NVARCHAR(255)
DECLARE @TableName NVARCHAR(255)
DECLARE @ColumnName NVARCHAR(255)

DECLARE IndexCuror CURSOR FOR

SELECT TRIM(TABLE_SCHEMA), TRIM(TABLE_NAME), TRIM(COLUMN_NAME)
FROM (
	SELECT t.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.ORDINAL_POSITION, ROW_NUMBER() over (partition by c.TABLE_NAME order by c.ORDINAL_POSITION) as rn
	FROM INFORMATION_SCHEMA.COLUMNS c
	JOIN INFORMATION_SCHEMA.TABLES t on c.TABLE_NAME = t.TABLE_NAME and c.TABLE_SCHEMA = t.TABLE_SCHEMA
	WHERE t.TABLE_SCHEMA = 'src' 
		AND t.TABLE_TYPE = 'BASE TABLE'
		AND t.TABLE_NAME NOT LIKE '%SUMMARY%' 
		AND t.TABLE_NAME NOT LIKE 'GarminActivities/StepsActivities  '
		AND (c.DATA_TYPE LIKE '%date%' OR c.DATA_TYPE LIKE '%time%')
) tmp WHERE tmp.rn = 1

OPEN IndexCuror
FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- dropping indexes for datetime columns
    DECLARE @IndexName NVARCHAR(255)
    SET @IndexName = 'IX_' + @TableName + '_' + @ColumnName

    DECLARE @SQL NVARCHAR(MAX)
    SET @SQL = 'DROP INDEX [' + @IndexName + '] ON ['+ @SchemaName+'].[' + @TableName + '](['+@ColumnName+']);'
	EXEC sp_executesql @SQL

    FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

END

CLOSE IndexCuror
DEALLOCATE IndexCuror

*/
GO
