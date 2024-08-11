USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringRr]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringRr] as select * from openquery(garmin_monitoring,'select * from monitoring_rr')
GO
