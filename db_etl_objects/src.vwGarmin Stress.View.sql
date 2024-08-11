USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/Stress]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/Stress] as select * from openquery(garmin,'select * from stress')
GO
