USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activity_laps](
	[activity_id] [nvarchar](255) NULL,
	[lap] [int] NULL,
	[start_time] [datetime2](7) NULL,
	[stop_time] [datetime2](7) NULL,
	[elapsed_time] [time](0) NULL,
	[moving_time] [time](0) NULL,
	[distance] [float] NULL,
	[cycles] [float] NULL,
	[avg_hr] [int] NULL,
	[max_hr] [int] NULL,
	[avg_rr] [float] NULL,
	[max_rr] [float] NULL,
	[calories] [int] NULL,
	[avg_cadence] [int] NULL,
	[max_cadence] [int] NULL,
	[avg_speed] [float] NULL,
	[max_speed] [float] NULL,
	[ascent] [float] NULL,
	[descent] [float] NULL,
	[max_temperature] [float] NULL,
	[min_temperature] [float] NULL,
	[avg_temperature] [float] NULL,
	[start_lat] [float] NULL,
	[start_long] [float] NULL,
	[stop_lat] [float] NULL,
	[stop_long] [float] NULL,
	[hr_zones_method] [nvarchar](18) NULL,
	[hrz_1_hr] [int] NULL,
	[hrz_2_hr] [int] NULL,
	[hrz_3_hr] [int] NULL,
	[hrz_4_hr] [int] NULL,
	[hrz_5_hr] [int] NULL,
	[hrz_1_time] [time](0) NULL,
	[hrz_2_time] [time](0) NULL,
	[hrz_3_time] [time](0) NULL,
	[hrz_4_time] [time](0) NULL,
	[hrz_5_time] [time](0) NULL
) ON [PRIMARY]
GO
