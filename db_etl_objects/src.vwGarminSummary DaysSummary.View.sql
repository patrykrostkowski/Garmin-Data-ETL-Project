USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/DaysSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/DaysSummary] as select * from openquery(garmin_summary,'select * from days_summary')
GO
