USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/SleepEvents]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/SleepEvents] as select * from openquery(garmin,'select * from sleep_events')
GO
