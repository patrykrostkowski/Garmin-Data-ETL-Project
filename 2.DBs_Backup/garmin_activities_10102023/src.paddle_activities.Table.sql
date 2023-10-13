USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[paddle_activities](
	[strokes] [int] NULL,
	[avg_stroke_distance] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
