USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/ActivityRecords]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/ActivityRecords] as select * from openquery(garmin_activities,'select * from activity_records')
GO
