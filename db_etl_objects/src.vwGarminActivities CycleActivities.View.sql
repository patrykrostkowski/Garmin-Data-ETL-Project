USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/CycleActivities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/CycleActivities] as select * from openquery(garmin_activities,'select * from cycle_activities')
GO
