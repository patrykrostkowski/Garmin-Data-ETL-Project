USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/Sleep]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/Sleep] as select * from openquery(garmin,'select * from sleep')
GO
