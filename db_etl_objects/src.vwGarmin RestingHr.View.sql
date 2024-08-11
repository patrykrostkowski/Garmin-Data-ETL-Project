USE [garmin]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/RestingHr]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/RestingHr] as select * from openquery(garmin,'select * from resting_hr')
GO
