USE [garmin_summary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_intensity_hr]         as select * from openquery(garmin_summary,'select * from intensity_hr        ')
GO
