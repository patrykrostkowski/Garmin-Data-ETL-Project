USE [garmin]
GO
DROP INDEX IF EXISTS [IX_YearlySummary_year] ON [dbo].[YearlySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [dbo].[YearlySummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YearlySummary](
	[year] [int] NULL,
	[first_day] [date] NULL,
	[date_name] [nvarchar](30) NULL,
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
	[intensity_time_goal] [decimal](38, 6) NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [float] NULL,
	[total_sleep_avg] [int] NULL,
	[sleep_min] [int] NULL,
	[sleep_max] [int] NULL,
	[deep_sleep_avg] [int] NULL,
	[light_sleep_avg] [int] NULL,
	[rem_sleep_avg] [int] NULL,
	[awake_avg] [int] NULL,
	[stress_avg] [int] NULL,
	[distance] [float] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance_km] [float] NULL,
	[monthly_distance_km] [float] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_avg_waking] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [IX_YearlySummary_year] ON [dbo].[YearlySummary]
(
	[year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
