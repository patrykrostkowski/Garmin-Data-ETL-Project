USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/WeeksSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/WeeksSummary] as select * from openquery(garmin_summary,'select * from weeks_summary')
GO
