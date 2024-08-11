USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/PaddleActivities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/PaddleActivities] as select * from openquery(garmin_activities,'select * from paddle_activities')
GO
