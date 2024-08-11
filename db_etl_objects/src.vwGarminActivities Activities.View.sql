USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/Activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/Activities] as select * from openquery(garmin_activities,'select * from activities')
GO
