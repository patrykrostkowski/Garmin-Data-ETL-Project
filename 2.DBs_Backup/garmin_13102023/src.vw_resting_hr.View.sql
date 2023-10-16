USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_resting_hr]           as select * from openquery(garmin,'select * from resting_hr          ')
GO
