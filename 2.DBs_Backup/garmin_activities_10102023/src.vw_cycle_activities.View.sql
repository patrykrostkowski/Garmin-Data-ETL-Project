USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_cycle_activities]     as select * from openquery(GARMIN_ACTIVITIES,'select * from cycle_activities    ')
GO
