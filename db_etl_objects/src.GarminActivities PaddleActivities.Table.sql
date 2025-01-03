USE [garmin]
GO
DROP TABLE IF EXISTS [src].[GarminActivities/PaddleActivities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/PaddleActivities](
	[strokes] [int] NULL,
	[avg_stroke_distance] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
