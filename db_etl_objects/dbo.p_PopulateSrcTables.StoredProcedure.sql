USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateSrcTables]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_PopulateSrcTables] AS
/*
EXEC [dbo].[p_PopulateSrcTables]
*/

DECLARE @cursor CURSOR;
DECLARE @viewname NVARCHAR(100);
DECLARE @tablename NVARCHAR(100);
DECLARE @schemaname NVARCHAR(3);
BEGIN
	SET NOCOUNT ON
	SET @cursor = CURSOR FOR

	SELECT table_name AS viewname
		,SUBSTRING(table_name, 3, len(table_name)) AS tablename
		,TABLE_SCHEMA AS schemaname
	FROM INFORMATION_SCHEMA.VIEWS
	WHERE TABLE_SCHEMA IN ('src')

	OPEN @cursor

	FETCH NEXT
	FROM @cursor
	INTO @viewname, @tablename, @schemaname

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--select @viewname;
		--select @tablename;
		EXEC ('drop table if exists [' + @schemaname + '].[' + @tablename + ']');

		EXEC ('select * into [' + @schemaname + '].[' + @tablename + '] from [' + @schemaname + '].[' + @viewname + ']');

		FETCH NEXT
		FROM @cursor
		INTO @viewname
			,@tablename
			,@schemaname
	END;

	CLOSE @cursor;

	DEALLOCATE @cursor;
END
GO
