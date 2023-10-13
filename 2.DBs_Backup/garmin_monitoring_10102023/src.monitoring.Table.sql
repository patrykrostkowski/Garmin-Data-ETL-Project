USE [garmin_monitoring]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring](
	[timestamp] [datetime2](7) NULL,
	[activity_type] [nvarchar](17) NULL,
	[intensity] [int] NULL,
	[duration] [time](0) NULL,
	[distance] [float] NULL,
	[cum_active_time] [time](0) NULL,
	[active_calories] [int] NULL,
	[steps] [int] NULL,
	[strokes] [int] NULL,
	[cycles] [float] NULL
) ON [PRIMARY]
GO
