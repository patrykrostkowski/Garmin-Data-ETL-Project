USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/StepsActivities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/StepsActivities] as select * from openquery(garmin_activities,'select * from steps_activities')
GO
