USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[steps_activities](
	[steps] [int] NULL,
	[avg_pace] [time](0) NULL,
	[avg_moving_pace] [time](0) NULL,
	[max_pace] [time](0) NULL,
	[avg_steps_per_min] [int] NULL,
	[max_steps_per_min] [int] NULL,
	[avg_step_length] [float] NULL,
	[avg_vertical_ratio] [float] NULL,
	[avg_vertical_oscillation] [float] NULL,
	[avg_gct_balance] [float] NULL,
	[avg_ground_contact_time] [time](0) NULL,
	[avg_stance_time_percent] [float] NULL,
	[vo2_max] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
