USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/IntensityHr]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/IntensityHr] as select * from openquery(garmin_summary,'select * from intensity_hr')
GO
