USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/Weight]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/Weight] as select * from openquery(garmin,'select * from weight')
GO
