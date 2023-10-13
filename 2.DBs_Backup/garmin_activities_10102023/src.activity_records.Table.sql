USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activity_records](
	[activity_id] [nvarchar](255) NULL,
	[record] [int] NULL,
	[timestamp] [datetime2](7) NULL,
	[position_lat] [float] NULL,
	[position_long] [float] NULL,
	[distance] [float] NULL,
	[cadence] [int] NULL,
	[altitude] [float] NULL,
	[hr] [int] NULL,
	[rr] [float] NULL,
	[speed] [float] NULL,
	[temperature] [float] NULL
) ON [PRIMARY]
GO
