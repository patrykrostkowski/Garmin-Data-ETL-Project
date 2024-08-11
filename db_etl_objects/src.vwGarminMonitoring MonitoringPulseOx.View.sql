USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringPulseOx]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringPulseOx] as select * from openquery(garmin_monitoring,'select * from monitoring_pulse_ox')
GO
