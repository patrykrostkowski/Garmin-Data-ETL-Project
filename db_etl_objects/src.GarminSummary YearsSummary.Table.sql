USE [garmin]
GO
DROP INDEX IF EXISTS [IX_GarminSummary/YearsSummary_first_day] ON [src].[GarminSummary/YearsSummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminSummary/YearsSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminSummary/YearsSummary](
	[first_day] [date] NULL,
	[hr_avg] [float] NULL,
	[hr_min] [float] NULL,
	[hr_max] [float] NULL,
	[rhr_avg] [float] NULL,
	[rhr_min] [float] NULL,
	[rhr_max] [float] NULL,
	[inactive_hr_avg] [float] NULL,
	[inactive_hr_min] [float] NULL,
	[inactive_hr_max] [float] NULL,
	[weight_avg] [float] NULL,
	[weight_min] [float] NULL,
	[weight_max] [float] NULL,
	[intensity_time] [time](0) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[steps] [int] NULL,
	[steps_goal] [int] NULL,
	[floors] [float] NULL,
	[floors_goal] [float] NULL,
	[sleep_avg] [time](0) NULL,
	[sleep_min] [time](0) NULL,
	[sleep_max] [time](0) NULL,
	[rem_sleep_avg] [time](0) NULL,
	[rem_sleep_min] [time](0) NULL,
	[rem_sleep_max] [time](0) NULL,
	[stress_avg] [int] NULL,
	[calories_avg] [int] NULL,
	[calories_bmr_avg] [int] NULL,
	[calories_active_avg] [int] NULL,
	[calories_goal] [int] NULL,
	[calories_consumed_avg] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_avg] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss_avg] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminSummary/YearsSummary_first_day] ON [src].[GarminSummary/YearsSummary]
(
	[first_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
