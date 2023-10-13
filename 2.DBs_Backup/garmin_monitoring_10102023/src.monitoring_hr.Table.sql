USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_hr](
	[timestamp] [datetime2](7) NULL,
	[heart_rate] [int] NULL
) ON [PRIMARY]
GO
