USE [garmin]
GO
DROP INDEX IF EXISTS [IX_DailySummary_day] ON [dbo].[DailySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [dbo].[DailySummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DailySummary](
	[day] [date] NULL,
	[date_name] [nvarchar](30) NULL,
	[isweekend_ind] [int] NOT NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[hr_avg] [int] NULL,
	[rhr] [int] NULL,
	[rhr_min] [int] NULL,
	[rhr_max] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [int] NULL,
	[vigorous_activity_time] [int] NULL,
	[intensity_time_goal] [decimal](14, 6) NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [float] NULL,
	[total_sleep] [int] NULL,
	[sleep_min] [int] NULL,
	[sleep_max] [int] NULL,
	[deep_sleep] [int] NULL,
	[light_sleep] [int] NULL,
	[rem_sleep] [int] NULL,
	[awake] [int] NULL,
	[sleep_score] [int] NULL,
	[qualifier] [nvarchar](255) NULL,
	[next_day_total_sleep] [int] NULL,
	[next_day_deep_sleep] [int] NULL,
	[next_day_light_sleep] [int] NULL,
	[next_day_rem_sleep] [int] NULL,
	[next_day_awake] [int] NULL,
	[next_day_sleep_score] [int] NULL,
	[next_day_qualifier] [nvarchar](255) NULL,
	[stress_avg] [int] NULL,
	[distance] [float] NULL,
	[calories_goal] [int] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[calories_consumed] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance_km] [float] NULL,
	[daily_distance_km] [float] NULL,
	[hydration_goal] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_avg_waking] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL,
	[description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_DailySummary_day] ON [dbo].[DailySummary]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
