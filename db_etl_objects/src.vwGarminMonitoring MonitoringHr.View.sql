USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringHr]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringHr] as select * from openquery(garmin_monitoring,'select * from monitoring_hr')
GO
