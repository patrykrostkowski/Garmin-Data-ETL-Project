USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_intensity](
	[timestamp] [datetime2](7) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL
) ON [PRIMARY]
GO
