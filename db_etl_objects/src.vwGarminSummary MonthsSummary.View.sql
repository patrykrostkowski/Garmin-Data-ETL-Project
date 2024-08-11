USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/MonthsSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/MonthsSummary] as select * from openquery(garmin_summary,'select * from months_summary')
GO
