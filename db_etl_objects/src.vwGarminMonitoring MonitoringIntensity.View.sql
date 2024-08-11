USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringIntensity]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringIntensity] as select * from openquery(garmin_monitoring,'select * from monitoring_intensity')
GO
