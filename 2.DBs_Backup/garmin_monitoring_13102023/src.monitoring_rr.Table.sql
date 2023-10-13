USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_rr](
	[timestamp] [datetime2](7) NULL,
	[rr] [float] NULL
) ON [PRIMARY]
GO
