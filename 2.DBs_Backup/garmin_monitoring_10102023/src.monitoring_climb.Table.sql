USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_climb](
	[timestamp] [datetime2](7) NULL,
	[ascent] [float] NULL,
	[descent] [float] NULL,
	[cum_ascent] [float] NULL,
	[cum_descent] [float] NULL
) ON [PRIMARY]
GO
