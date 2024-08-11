USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/Monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/Monitoring] as select * from openquery(garmin_monitoring,'select * from monitoring')
GO
