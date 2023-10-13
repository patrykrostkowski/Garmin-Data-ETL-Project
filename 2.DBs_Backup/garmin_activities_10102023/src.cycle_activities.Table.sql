USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[cycle_activities](
	[strokes] [int] NULL,
	[vo2_max] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
