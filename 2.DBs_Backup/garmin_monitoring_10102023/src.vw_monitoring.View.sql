﻿USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring]           as select * from openquery(garmin_monitoring,'select * from monitoring          ')
GO
