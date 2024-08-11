USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/DailySummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/DailySummary] as select * from openquery(garmin,'select * from daily_summary')
GO
