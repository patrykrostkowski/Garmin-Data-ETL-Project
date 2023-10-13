USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_steps_activities]     as select * from openquery(GARMIN_ACTIVITIES,'select * from steps_activities    ')
GO
