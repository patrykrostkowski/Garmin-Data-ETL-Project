USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[daily_summary](
	[day] [date] NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[rhr] [int] NULL,
	[stress_avg] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [float] NULL,
	[distance] [float] NULL,
	[calories_goal] [int] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[calories_consumed] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL,
	[description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
