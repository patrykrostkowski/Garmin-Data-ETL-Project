USE [garmin_summary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_years_summary]        as select * from openquery(garmin_summary,'select * from years_summary       ')
GO
