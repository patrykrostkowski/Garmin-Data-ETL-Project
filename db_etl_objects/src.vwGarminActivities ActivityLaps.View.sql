USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/ActivityLaps]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/ActivityLaps] as select * from openquery(garmin_activities,'select * from activity_laps')
GO
