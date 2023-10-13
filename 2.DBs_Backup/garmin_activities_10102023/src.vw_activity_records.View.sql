USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_activity_records]     as select * from openquery(GARMIN_ACTIVITIES,'select * from activity_records    ')
GO
