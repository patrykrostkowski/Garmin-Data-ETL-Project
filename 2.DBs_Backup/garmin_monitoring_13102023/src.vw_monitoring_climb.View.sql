USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring_climb]     as select * from openquery(garmin_monitoring,'select * from monitoring_climb    ')
GO
