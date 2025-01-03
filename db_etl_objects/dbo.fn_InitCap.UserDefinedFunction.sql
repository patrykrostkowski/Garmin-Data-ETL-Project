USE [garmin]
GO
DROP FUNCTION IF EXISTS [dbo].[fn_InitCap]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_InitCap] (@InputString nvarchar(1000)) 
RETURNS NVARCHAR(1000)
AS
BEGIN

	DECLARE @Index          INT
	DECLARE @Char           CHAR(1)
	DECLARE @PrevChar       CHAR(1)
	DECLARE @OutputString   NVARCHAR(255)
	--DECLARE @InputString	VARCHAR(255) = 'garmin_activities'

	SET @OutputString = LOWER(@InputString)
	SET @Index = 1

	WHILE @Index <= LEN(@InputString)
	BEGIN
		SET @Char     = SUBSTRING(@InputString, @Index, 1)
		SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
							 ELSE SUBSTRING(@InputString, @Index - 1, 1)
						END

		IF @PrevChar IN (' ', ';', ':', '!', '?', ',', '.', '_', '-', '/', '&', '''', '(')
		BEGIN
			IF @PrevChar != '''' OR UPPER(@Char) != 'S'
				SET @OutputString = STUFF(@OutputString, @Index, 1, UPPER(@Char))
				--SET @OutputString = REPLACE(@OutputString,'_','')
		END

		SET @Index = @Index + 1
	END

RETURN REPLACE(@OutputString,'_','')
END
GO
