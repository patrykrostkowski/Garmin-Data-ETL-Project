USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_daily_summary]        as select * from openquery(garmin,'select * from daily_summary       ')
GO
