USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringInfo] as select * from openquery(garmin_monitoring,'select * from monitoring_info')
GO
