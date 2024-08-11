USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/YearsSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/YearsSummary] as select * from openquery(garmin_summary,'select * from years_summary')
GO
