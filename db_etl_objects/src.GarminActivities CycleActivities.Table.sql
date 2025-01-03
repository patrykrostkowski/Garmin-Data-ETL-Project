USE [garmin]
GO
DROP TABLE IF EXISTS [src].[GarminActivities/CycleActivities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/CycleActivities](
	[strokes] [int] NULL,
	[vo2_max] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
