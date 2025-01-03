USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_CreateSrcViews]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[p_CreateSrcViews]
AS
/*
EXEC [dbo].[p_CreateSrcViews]
*/

DECLARE @LinkedServer NVARCHAR(255)
DECLARE @cursor CURSOR;
DECLARE @TableName NVARCHAR(255);
DECLARE @Schemaname NVARCHAR(10);
DECLARE @ViewName NVARCHAR(255);

BEGIN
	SET NOCOUNT ON
	SET @cursor = CURSOR FOR

	SELECT Domain, TableName, SchemaName
	FROM acc.SrcTblConfig
	WHERE IsActive = 1

	OPEN @cursor

	FETCH NEXT FROM @cursor
	INTO @LinkedServer, @TableName, @Schemaname

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @ViewName = QUOTENAME(@Schemaname) + '.' + QUOTENAME('vw'+ [dbo].[fn_InitCap](@LinkedServer)+'/'+[dbo].[fn_InitCap](@TableName))
		
		IF OBJECT_ID(@ViewName, 'V') IS NOT NULL
		BEGIN
			EXEC ('DROP VIEW ' + @ViewName )
			EXEC ('CREATE VIEW ' + @ViewName + ' as select * from openquery(' + @LinkedServer + ',''select * from ' + @TableName + ''')')
		END

		IF OBJECT_ID(@ViewName, 'V') IS NULL
		BEGIN
			EXEC ('create or alter view ' + @ViewName + ' as select * from openquery(' + @LinkedServer + ',''select * from ' + @TableName + ''')')
		END


		FETCH NEXT FROM @cursor
		INTO @LinkedServer, @TableName, @Schemaname
	END

	CLOSE @cursor;
	DEALLOCATE @cursor
END



GO
