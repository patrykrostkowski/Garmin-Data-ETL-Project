USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateYearlySummaryTbl]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateWeeklySummaryTbl]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateSrcTables]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateMonthlySummaryTbl]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateDailySummaryTbl]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MergeSrcTables]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MasterDataLoad]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMergeYearlyData]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMergeWeeklyData]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMergeMonthlyData]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMergeDailyData]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_CreateSrcViews]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_CreateIndexesOnSourceTbls]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[acc].[LogTable]') AND type in (N'U'))
ALTER TABLE [acc].[LogTable] DROP CONSTRAINT IF EXISTS [DF__LogTable__LoadSt__3793653F]
GO
DROP INDEX IF EXISTS [IX_GarminSummary/YearsSummary_first_day] ON [src].[GarminSummary/YearsSummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminSummary/YearsSummary]
GO
DROP INDEX IF EXISTS [IX_GarminSummary/WeeksSummary_first_day] ON [src].[GarminSummary/WeeksSummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminSummary/WeeksSummary]
GO
DROP INDEX IF EXISTS [IX_GarminSummary/IntensityHr_timestamp] ON [src].[GarminSummary/IntensityHr] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminSummary/IntensityHr]
GO
DROP INDEX IF EXISTS [IX_GarminSummary/DaysSummary_day] ON [src].[GarminSummary/DaysSummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminSummary/DaysSummary]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringPulseOx_timestamp] ON [src].[GarminMonitoring/MonitoringPulseOx] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringPulseOx]
GO
DROP TABLE IF EXISTS [src].[GarminActivities/StepsActivities]
GO
DROP TABLE IF EXISTS [src].[GarminActivities/PaddleActivities]
GO
DROP TABLE IF EXISTS [src].[GarminActivities/CycleActivities]
GO
DROP INDEX IF EXISTS [IX_Garmin/Weight_day] ON [src].[Garmin/Weight] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/Weight]
GO
DROP INDEX IF EXISTS [IX_Garmin/RestingHr_day] ON [src].[Garmin/RestingHr] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/RestingHr]
GO
DROP INDEX IF EXISTS [IX_YearlySummary_year] ON [dbo].[YearlySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [dbo].[YearlySummary]
GO
DROP INDEX IF EXISTS [IX_WeeklySummary_first_day] ON [dbo].[WeeklySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [dbo].[WeeklySummary]
GO
DROP INDEX IF EXISTS [IX_MonthlySummary_month_num] ON [dbo].[MonthlySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [dbo].[MonthlySummary]
GO
DROP TABLE IF EXISTS [acc].[SrcViewsConfig]
GO
DROP TABLE IF EXISTS [acc].[SrcTblConfig]
GO
DROP TABLE IF EXISTS [acc].[LogTable]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/YearsSummary]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/WeeksSummary]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/MonthsSummary]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/IntensityHr]
GO
DROP VIEW IF EXISTS [src].[vwGarminSummary/DaysSummary]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringRr]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringPulseOx]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringIntensity]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringInfo]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringHr]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/MonitoringClimb]
GO
DROP VIEW IF EXISTS [src].[vwGarminMonitoring/Monitoring]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/StepsActivities]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/PaddleActivities]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/CycleActivities]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/ActivityRecords]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/ActivityLaps]
GO
DROP VIEW IF EXISTS [src].[vwGarminActivities/Activities]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/Weight]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/Stress]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/SleepEvents]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/Sleep]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/RestingHr]
GO
DROP VIEW IF EXISTS [src].[vwGarmin/DailySummary]
GO
DROP VIEW IF EXISTS [dbo].[vwTblYearlySummary]
GO
DROP VIEW IF EXISTS [dbo].[vwTblWeeklySummary]
GO
DROP VIEW IF EXISTS [dbo].[vwTblMonthlySummary]
GO
DROP INDEX IF EXISTS [IX_DailySummary_day] ON [dbo].[DailySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [dbo].[DailySummary]
GO
DROP VIEW IF EXISTS [dbo].[vwSleepPhasesBbStress]
GO
DROP VIEW IF EXISTS [dbo].[vwExercisesSleepPhases]
GO
DROP INDEX IF EXISTS [IX_Garmin/SleepEvents_timestamp] ON [src].[Garmin/SleepEvents] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/SleepEvents]
GO
DROP VIEW IF EXISTS [dbo].[vwStressDayActiveMinutes]
GO
DROP VIEW IF EXISTS [dbo].[vwSleepStress]
GO
DROP VIEW IF EXISTS [dbo].[vwActivitiesOverMonth]
GO
DROP INDEX IF EXISTS [IX_GarminSummary/MonthsSummary_first_day] ON [src].[GarminSummary/MonthsSummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminSummary/MonthsSummary]
GO
DROP VIEW IF EXISTS [dbo].[vwActivityLocMap]
GO
DROP INDEX IF EXISTS [IX_GarminActivities/ActivityRecords_timestamp] ON [src].[GarminActivities/ActivityRecords] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminActivities/ActivityRecords]
GO
DROP INDEX IF EXISTS [IX_GarminActivities/ActivityLaps_start_time] ON [src].[GarminActivities/ActivityLaps] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminActivities/ActivityLaps]
GO
DROP VIEW IF EXISTS [dbo].[vwCycling]
GO
DROP VIEW IF EXISTS [dbo].[vwStepsOverHour]
GO
DROP VIEW IF EXISTS [dbo].[vwTblDailySummary]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringRr_timestamp] ON [src].[GarminMonitoring/MonitoringRr] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringRr]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringIntensity_timestamp] ON [src].[GarminMonitoring/MonitoringIntensity] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringIntensity]
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringInfo]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringHr_timestamp] ON [src].[GarminMonitoring/MonitoringHr] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringHr]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringClimb_timestamp] ON [src].[GarminMonitoring/MonitoringClimb] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringClimb]
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/Monitoring]
GO
DROP INDEX IF EXISTS [IX_GarminActivities/Activities_start_time] ON [src].[GarminActivities/Activities] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminActivities/Activities]
GO
DROP INDEX IF EXISTS [IX_Garmin/Stress_timestamp] ON [src].[Garmin/Stress] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/Stress]
GO
DROP INDEX IF EXISTS [IX_Garmin/Sleep_day] ON [src].[Garmin/Sleep] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/Sleep]
GO
DROP INDEX IF EXISTS [IX_Garmin/DailySummary_day] ON [src].[Garmin/DailySummary] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/DailySummary]
GO
DROP FUNCTION IF EXISTS [dbo].[fn_InitCap]
GO
DROP SCHEMA IF EXISTS [src]
GO
DROP SCHEMA IF EXISTS [acc]
GO
CREATE SCHEMA [acc]
GO
CREATE SCHEMA [src]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_InitCap] (@InputString nvarchar(1000)) 
RETURNS NVARCHAR(1000)
AS
BEGIN

	DECLARE @Index          INT
	DECLARE @Char           CHAR(1)
	DECLARE @PrevChar       CHAR(1)
	DECLARE @OutputString   NVARCHAR(255)
	--DECLARE @InputString	VARCHAR(255) = 'garmin_activities'

	SET @OutputString = LOWER(@InputString)
	SET @Index = 1

	WHILE @Index <= LEN(@InputString)
	BEGIN
		SET @Char     = SUBSTRING(@InputString, @Index, 1)
		SET @PrevChar = CASE WHEN @Index = 1 THEN ' '
							 ELSE SUBSTRING(@InputString, @Index - 1, 1)
						END

		IF @PrevChar IN (' ', ';', ':', '!', '?', ',', '.', '_', '-', '/', '&', '''', '(')
		BEGIN
			IF @PrevChar != '''' OR UPPER(@Char) != 'S'
				SET @OutputString = STUFF(@OutputString, @Index, 1, UPPER(@Char))
				--SET @OutputString = REPLACE(@OutputString,'_','')
		END

		SET @Index = @Index + 1
	END

RETURN REPLACE(@OutputString,'_','')
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/DailySummary](
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
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/DailySummary_day] ON [src].[Garmin/DailySummary]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/Sleep](
	[day] [date] NULL,
	[start] [datetime2](7) NULL,
	[end] [datetime2](7) NULL,
	[total_sleep] [time](0) NULL,
	[deep_sleep] [time](0) NULL,
	[light_sleep] [time](0) NULL,
	[rem_sleep] [time](0) NULL,
	[awake] [time](0) NULL,
	[avg_spo2] [float] NULL,
	[avg_rr] [float] NULL,
	[avg_stress] [float] NULL,
	[score] [int] NULL,
	[qualifier] [nvarchar](255) NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/Sleep_day] ON [src].[Garmin/Sleep]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/Stress](
	[timestamp] [datetime2](7) NULL,
	[stress] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/Stress_timestamp] ON [src].[Garmin/Stress]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/Activities](
	[activity_id] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[type] [nvarchar](255) NULL,
	[course_id] [int] NULL,
	[laps] [int] NULL,
	[sport] [nvarchar](255) NULL,
	[sub_sport] [nvarchar](255) NULL,
	[device_serial_number] [int] NULL,
	[self_eval_feel] [nvarchar](255) NULL,
	[self_eval_effort] [nvarchar](255) NULL,
	[training_load] [float] NULL,
	[training_effect] [float] NULL,
	[anaerobic_training_effect] [float] NULL,
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
CREATE UNIQUE CLUSTERED INDEX [IX_GarminActivities/Activities_start_time] ON [src].[GarminActivities/Activities]
(
	[start_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/Monitoring](
	[timestamp] [datetime2](7) NULL,
	[activity_type] [nvarchar](17) NULL,
	[intensity] [int] NULL,
	[duration] [time](0) NULL,
	[distance] [float] NULL,
	[cum_active_time] [time](0) NULL,
	[active_calories] [int] NULL,
	[steps] [int] NULL,
	[strokes] [int] NULL,
	[cycles] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringClimb](
	[timestamp] [datetime2](7) NULL,
	[ascent] [float] NULL,
	[descent] [float] NULL,
	[cum_ascent] [float] NULL,
	[cum_descent] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringClimb_timestamp] ON [src].[GarminMonitoring/MonitoringClimb]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringHr](
	[timestamp] [datetime2](7) NULL,
	[heart_rate] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringHr_timestamp] ON [src].[GarminMonitoring/MonitoringHr]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringInfo](
	[timestamp] [datetime2](7) NULL,
	[file_id] [int] NULL,
	[activity_type] [nvarchar](17) NULL,
	[resting_metabolic_rate] [int] NULL,
	[cycles_to_distance] [float] NULL,
	[cycles_to_calories] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringIntensity](
	[timestamp] [datetime2](7) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringIntensity_timestamp] ON [src].[GarminMonitoring/MonitoringIntensity]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringRr](
	[timestamp] [datetime2](7) NULL,
	[rr] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringRr_timestamp] ON [src].[GarminMonitoring/MonitoringRr]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwTblDailySummary] as 

/*
	This summary is created for training purpose. It contains the same details as in already existed table but calculated manually.
	I'm gonna use it further as a base table.
*/

with cte_rhr as (
	SELECT [day]
		,min(moving_avg) AS resting_heart_rate
	FROM (
		SELECT cast(TIMESTAMP AS DATE) AS [day]
			,avg(heart_rate) OVER (ORDER BY TIMESTAMP rows BETWEEN 30 PRECEDING	AND CURRENT ROW) AS moving_avg
		FROM [src].[GarminMonitoring/MonitoringHr]
		WHERE cast(TIMESTAMP AS DATE) >= '2023-02-11'
		GROUP BY 
			cast(TIMESTAMP AS DATE)
			,TIMESTAMP
			,heart_rate
		) AS tmp
	GROUP BY [day]
	--ORDER BY [day]
	)

,cte_hr as (
	SELECT cast(TIMESTAMP AS DATE) AS [day]
		,min(heart_rate) AS min_heart_rate
		,max(heart_rate) AS max_heart_rate
		,avg(heart_rate) AS avg_heart_rate
	FROM [src].[GarminMonitoring/MonitoringHr]
	WHERE cast(TIMESTAMP AS DATE) >= '2023-02-11'
	GROUP BY cast(TIMESTAMP AS DATE)
	--ORDER BY day
)

,cte_stress as (
	SELECT cast(s.TIMESTAMP AS DATE) AS day
		,avg(s.stress) AS avg_stress
	FROM [src].[Garmin/Stress] s
	WHERE s.stress > 0
	GROUP BY cast(TIMESTAMP AS DATE)
	--ORDER BY day
	)

,cte_activity_time as (
	SELECT cast(TIMESTAMP AS DATE) AS day
		,sum(datediff(minute, '00:00:00:00', moderate_activity_time)) AS moderate_activity_time
		,sum(datediff(minute, '00:00:00:00', vigorous_activity_time)) AS vigorous_activity_time
	FROM [src].[GarminMonitoring/MonitoringIntensity] 
	GROUP BY cast(TIMESTAMP AS DATE)
	)

,cte_steps as (
	SELECT cast(mt.TIMESTAMP AS DATE) AS day
		,round(sum(mt.distance) / 1000, 2) AS distance_km
		,sum(mt.steps) AS steps
	FROM [src].[GarminMonitoring/Monitoring] mt
	WHERE 1 = 1
		AND cast(mt.TIMESTAMP AS TIME) = '23:59:59' -- because values sums cummulative
		AND mt.activity_type NOT IN ('generic','stop_disable')
	GROUP BY cast(mt.TIMESTAMP AS DATE), mt.TIMESTAMP
	)

,cte_floors as (
	SELECT cast(TIMESTAMP AS DATE) AS day
		,round(sum(ascent)/3, 2) AS floors_up
		,round(sum(descent)/3, 2) AS floors_down
	FROM [src].[GarminMonitoring/MonitoringClimb]
	GROUP BY cast(TIMESTAMP AS DATE)
	--ORDER BY cast(TIMESTAMP AS DATE)
	)

,cte_calories as (
	SELECT cast(mt.TIMESTAMP AS DATE) AS day
		,sum(mt.active_calories) AS calories_active
		,(SELECT TOP 1 mm.resting_metabolic_rate
			FROM [src].[GarminMonitoring/MonitoringInfo] mm
			WHERE cast(mt.TIMESTAMP AS DATE) = cast(mm.TIMESTAMP AS DATE)
			) AS calories_bmr
		,sum(mt.active_calories) + (
			SELECT TOP 1 mm.resting_metabolic_rate
			FROM [src].[GarminMonitoring/MonitoringInfo] mm
			WHERE cast(mt.TIMESTAMP AS DATE) = cast(mm.TIMESTAMP AS DATE)
			) AS calories_total
	FROM [src].[GarminMonitoring/Monitoring] mt
	WHERE 1 = 1
		AND cast(mt.TIMESTAMP AS TIME) = '23:59:59' -- because values sums cummulative
		AND mt.activity_type NOT IN ('stop_disable')
	GROUP BY cast(mt.TIMESTAMP AS DATE), mt.TIMESTAMP
	)

,cte_respiratory_rate as (
	select 
		cast(rr.timestamp as date) as day
		,max(rr.rr) as rr_max
		,min(rr.rr) as rr_min
		,(
			SELECT ROUND(avg(rr2.rr),2) 
			FROM [src].[GarminMonitoring/MonitoringRr] rr2
			--JOIN [src].[GarminMonitoring/Monitoring] mt2 on mt2.timestamp = rr2.timestamp 
			--		and mt2.activity_type = 'walking'
			WHERE cast(rr2.timestamp as TIME) between '06:30:00.0000000' and '23:00:00.0000000'
				AND CAST(rr2.timestamp as date) = CAST(rr.timestamp as date) 
			GROUP BY cast(rr2.timestamp as date)
		) as rr_avg_waking
		
	FROM [src].[GarminMonitoring/MonitoringRr] rr
	GROUP BY cast(rr.timestamp AS DATE)
	--order by 1
	)

,cte_sleep as (
	select 
		*
		,lead(total_sleep		,1)	over (order by day) as next_day_total_sleep
		,lead(deep_sleep		,1)	over (order by day) as next_day_deep_sleep 
		,lead(light_sleep		,1)	over (order by day) as next_day_light_sleep
		,lead(rem_sleep			,1)	over (order by day) as next_day_rem_sleep	 
		,lead(awake				,1)	over (order by day) as next_day_awake
		,lead(sleep_score		,1)	over (order by day) as next_day_sleep_score
		,lead(qualifier			,1)	over (order by day) as next_day_qualifier
	from (
		select 
			day
			,datediff(minute, '00:00:00',total_sleep	) as total_sleep
			,datediff(minute, '00:00:00',deep_sleep		) as deep_sleep	
			,datediff(minute, '00:00:00',light_sleep	) as light_sleep
			,datediff(minute, '00:00:00',rem_sleep		) as rem_sleep	
			,datediff(minute, '00:00:00',awake			) as awake		
			,score as sleep_score
			,qualifier 
		from [src].[Garmin/Sleep]
		where [end] is not null
		) tbl
	)

,cte_activity_count as (
	select 
		cast(mtr.timestamp as date) as day
		,COALESCE(sum(act.activity_count),0) as activity_count
		,COALESCE(sum(act.activity_calories),0) as activity_calories
		,COALESCE(sum(act.activity_distance),0) as activity_distance
		,sum(mtr.distance)/1000 + COALESCE(sum(act.activity_distance),0) as daily_distance
		,sum(mtr.steps) as steps
	from [src].[GarminMonitoring/Monitoring] mtr
	LEFT JOIN 
		(select 
			cast(act.start_time as date) as day
			,count(act.sport) as activity_count
			,sum(act.calories) as activity_calories
			,sum(act.distance) as activity_distance
			--,sum(mtr.daily_distance) as daily_distance --including steps
		from [src].[GarminActivities/Activities] act
		group by cast(act.start_time as date)
		) act ON act.day = cast(mtr.timestamp as date)

	WHERE cast(mtr.timestamp as time) = '23:59:59.0000000' and mtr.activity_type = 'walking'
	group by cast(timestamp as date)
)

-- ########################### MAIN QUERY ####################################

SELECT 
	rhr.[day]
	,datename(weekday,rhr.[day]) as date_name
	,case when datename(weekday,rhr.[day]) in('Saturday','Sunday') then 1 else 0 end as isweekend_ind
	,cte_hr.min_heart_rate as hr_min
	,cte_hr.max_heart_rate as hr_max
	,cte_hr.avg_heart_rate as hr_avg
	,rhr.resting_heart_rate as rhr --Daily RHR is calculated using the lowest 30 minute average in a 24 hour period.
	,rhr.resting_heart_rate as rhr_min
	,rhr.resting_heart_rate as rhr_max
	,dsm.step_goal
	,cte_steps.steps
	,COALESCE(cte_activity_time.moderate_activity_time,0) AS moderate_activity_time
	,COALESCE(cte_activity_time.vigorous_activity_time,0) AS vigorous_activity_time
	,ROUND(CAST(DATEDIFF(MINUTE, '00:00:00:00', dsm.intensity_time_goal) AS DECIMAL(10,2))/7,2) as intensity_time_goal
	,cte_floors.floors_up --based on internal barometer to measure elevation changes as you climb floors. A floor climbed is equal to 3m 
	,cte_floors.floors_down
	,dsm.floors_goal as floors_goal --set as constant value 
	,cte_sleep.total_sleep
	,cte_sleep.total_sleep as sleep_min
	,cte_sleep.total_sleep as sleep_max
	,cte_sleep.deep_sleep	
	,cte_sleep.light_sleep
	,cte_sleep.rem_sleep
	,cte_sleep.awake	
	,cte_sleep.sleep_score
	,cte_sleep.qualifier
	,cte_sleep.next_day_total_sleep
	,cte_sleep.next_day_deep_sleep 
	,cte_sleep.next_day_light_sleep
	,cte_sleep.next_day_rem_sleep	
	,cte_sleep.next_day_awake	
	,cte_sleep.next_day_sleep_score
	,cte_sleep.next_day_qualifier
	,cte_stress.avg_stress as stress_avg --Using heart rate variability (HRV)
 	,cte_steps.distance_km as distance
	,NULL AS calories_goal
	,cal.calories_total
	,cal.calories_bmr
	,cal.calories_active
	,NULL AS calories_consumed
	,act.activity_count as activities
	,act.activity_calories as activities_calories
	,act.activity_distance as activities_distance_km
	,act.daily_distance as daily_distance_km
	,dsm.hydration_goal AS [hydration_goal]
	,dsm.hydration_intake AS [hydration_intake]
	,COALESCE(dsm.sweat_loss,0) AS [sweat_loss]
	,dsm.spo2_avg AS [spo2_avg]
	,dsm.spo2_min AS [spo2_min]
	,cte_respiratory_rate.rr_avg_waking
	,cte_respiratory_rate.rr_max
	,cte_respiratory_rate.rr_min 
	,dsm.bb_charged
	,dsm.bb_max
	,dsm.bb_min
	,dsm.description as [description]
FROM cte_rhr rhr
LEFT JOIN cte_hr ON cte_hr.day									= rhr.day
LEFT JOIN cte_stress ON cte_stress.day						= rhr.day
LEFT JOIN cte_activity_time on cte_activity_time.day		= rhr.day
LEFT JOIN cte_steps ON cte_steps.day						= rhr.day
LEFT JOIN cte_floors ON cte_floors.day						= rhr.day
LEFT JOIN cte_sleep ON cte_sleep.day						= rhr.day
LEFT JOIN cte_calories cal on cal.day						= rhr.day
LEFT JOIN cte_respiratory_rate ON cte_respiratory_rate.day	= rhr.day
LEFT JOIN [src].[Garmin/DailySummary] dsm ON dsm.day		= rhr.day
LEFT JOIN cte_activity_count act ON act.day					= rhr.day
--order by rhr.[day]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vwStepsOverHour] as

/*
	Step values are sums cumulative but in order to activity type, so I need to take the maximum value from each hour and subtract one from the previous hour.
*/


SELECT date, hour, week_day, SUM(steps) AS steps 
FROM (
	/* steps in walking activity */
	SELECT 
		cast(timestamp as date) as date
		,MAX(activity_type) AS activity_type
		,DATEPART(hour,timestamp) as hour
		,datename(weekday,cast(timestamp as date)) as week_day
		,case when cast(timestamp as date) = lag(max(cast(timestamp as date))) over (order by cast(timestamp as date), DATEPART(hour,timestamp))
			then (max([steps]) - lag(max(steps)) over (order by cast(timestamp as date), DATEPART(hour,timestamp)))
			else max([steps])
		end as steps

		-- helpful columns
		,max([steps]) as cum_steps
		,lag(max(steps)) over (order by cast(timestamp as date), DATEPART(hour,timestamp)) as prev_step_row
		,lag(max(cast(timestamp as date))) over (order by cast(timestamp as date), DATEPART(hour,timestamp)) as prev_date_row
	FROM [src].[GarminMonitoring/Monitoring] 
	WHERE activity_type in ('walking')
	GROUP BY 	
		cast(timestamp as date) 
		,DATEPART(hour,timestamp) 
		,activity_type
		,datename(weekday,cast(timestamp as date)) 

	UNION ALL
	/* steps in running activity */
	SELECT 
		cast(timestamp as date) as date
		,MAX(activity_type) AS activity_type
		,DATEPART(hour,timestamp) as hour
		,datename(weekday,cast(timestamp as date)) as week_day
		,case when cast(timestamp as date) = lag(max(cast(timestamp as date))) over (order by cast(timestamp as date), DATEPART(hour,timestamp))
			then (max([steps]) - lag(max(steps)) over (order by cast(timestamp as date), DATEPART(hour,timestamp)))
			else max([steps])
		end as steps

		-- helpful columns
		,max([steps]) as cum_steps
		,lag(max(steps)) over (order by cast(timestamp as date), DATEPART(hour,timestamp)) as prev_step_row
		,lag(max(cast(timestamp as date))) over (order by cast(timestamp as date), DATEPART(hour,timestamp)) as prev_date_row
	FROM [src].[GarminMonitoring/Monitoring] 
	WHERE activity_type in ('running')
	GROUP BY 	
		cast(timestamp as date) 
		,DATEPART(hour,timestamp) 
		,activity_type
		,datename(weekday,cast(timestamp as date)) 
) unn

GROUP BY date, hour, week_day
--ORDER BY 1,2




GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[vwCycling] as 

SELECT 
	activities.activity_id AS activity_id,
	COALESCE(activities.name,'Kardio') AS name,
	--activity_laps.lap,
	activities.start_time AS start_time,
	activities.stop_time AS stop_time,
	activities.elapsed_time AS elapsed_time,
	ROUND(activities.distance, 1) AS distance,
	activities.avg_hr AS avg_hr,
	activities.max_hr AS max_hr,
	activities.calories AS calories,
	ROUND(activities.avg_temperature, 1) AS avg_temperature,
	activities.avg_cadence AS avg_rpms,
	activities.max_cadence AS max_rpms,
	ROUND(activities.avg_speed, 1) AS avg_speed,
	ROUND(activities.max_speed, 1) AS max_speed,
	activities.hrz_1_time AS heart_rate_zone_one_time,
	activities.hrz_2_time AS heart_rate_zone_two_time,
	activities.hrz_3_time AS heart_rate_zone_three_time,
	activities.hrz_4_time AS heart_rate_zone_four_time,
	activities.hrz_5_time AS heart_rate_zone_five_time
	--CASE WHEN activities.start_lat IS NULL 
	--	THEN 'N/A'
	--	ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', activities.start_lat, ',', activities.start_long, '&z=13') 
	--	END AS start_loc,
	--CASE WHEN activities.stop_lat IS NULL 
	--	THEN 'N/A'
	--	ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', activities.stop_lat, ',', activities.stop_long, '&z=13') 
	--	END AS stop_loc
FROM [src].[GarminActivities/Activities] activities
--JOIN activities.activity_records ON activities.activity_id = activity_records.activity_id
--JOIN activities.activity_laps ON activities.activity_id = activity_laps.activity_id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/ActivityLaps](
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
CREATE UNIQUE CLUSTERED INDEX [IX_GarminActivities/ActivityLaps_start_time] ON [src].[GarminActivities/ActivityLaps]
(
	[start_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/ActivityRecords](
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
CREATE UNIQUE CLUSTERED INDEX [IX_GarminActivities/ActivityRecords_timestamp] ON [src].[GarminActivities/ActivityRecords]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[vwActivityLocMap] as 

SELECT 
	act.activity_id AS activity_id,
	COALESCE(act.name,'Kardio') AS name,
	acl.lap,
	act.start_time AS start_time,
	act.stop_time AS stop_time,
	act.elapsed_time AS elapsed_time,
	ROUND(act.distance, 1) AS distance,
	--activities.avg_hr AS avg_hr,
	--activities.max_hr AS max_hr,
	--activities.calories AS calories,
	--ROUND(activities.avg_temperature, 1) AS avg_temperature,
	--activities.avg_cadence AS avg_rpms,
	--activities.max_cadence AS max_rpms,
	--ROUND(activities.avg_speed, 1) AS avg_speed,
	--ROUND(activities.max_speed, 1) AS max_speed,
	--activities.hrz_1_time AS heart_rate_zone_one_time,
	--activities.hrz_2_time AS heart_rate_zone_two_time,
	--activities.hrz_3_time AS heart_rate_zone_three_time,
	--activities.hrz_4_time AS heart_rate_zone_four_time,
	--activities.hrz_5_time AS heart_rate_zone_five_time,
	CASE WHEN act.start_lat IS NULL 
		THEN 'N/A'
		ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', act.start_lat, ',', act.start_long, '&z=13') 
		END AS start_loc,
	CASE WHEN act.stop_lat IS NULL 
		THEN 'N/A'
		ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', act.stop_lat, ',', act.stop_long, '&z=13') 
		END AS stop_loc
FROM [src].[GarminActivities/Activities] act
JOIN [src].[GarminActivities/ActivityRecords] acr ON act.activity_id = acr.activity_id
JOIN [src].[GarminActivities/ActivityLaps] acl ON act.activity_id = acl.activity_id
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminSummary/MonthsSummary](
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
CREATE UNIQUE CLUSTERED INDEX [IX_GarminSummary/MonthsSummary_first_day] ON [src].[GarminSummary/MonthsSummary]
(
	[first_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vwActivitiesOverMonth] as 

SELECT 
	tbl.*
	,tbl.sum_moving_time - (tbl.sum_hrz_1_time + tbl.sum_hrz_2_time + tbl.sum_hrz_3_time + tbl.sum_hrz_4_time + tbl.sum_hrz_5_time) as sum_inactive_time
	,gsm.steps as month_steps
FROM (
	SELECT 
		cast(DATEADD(month, datediff(month,0,act.start_time),0) as date) as first_day
		,case 
			when act.sub_sport = 'generic' then act.sport 
			else act.sub_sport end as sport_name
		,count(act.sub_sport) as activity_count 
		,avg(act.avg_hr) as avg_hr
		,max(act.max_hr) as max_hr
		,sum(datediff(minute, 0, act.elapsed_time)) as sum_elapsed_time
		,sum(datediff(minute, 0, act.moving_time)) as sum_moving_time
		,sum(act.distance) as sum_distance
		,sum(act.calories) as sum_calories
		,sum(datediff(minute, 0, act.hrz_1_time)) as sum_hrz_1_time
		,sum(datediff(minute, 0, act.hrz_2_time)) as sum_hrz_2_time
		,sum(datediff(minute, 0, act.hrz_3_time)) as sum_hrz_3_time
		,sum(datediff(minute, 0, act.hrz_4_time)) as sum_hrz_4_time
		,sum(datediff(minute, 0, act.hrz_5_time)) as sum_hrz_5_time
	FROM [src].[GarminActivities/Activities] act
	WHERE act.sport not like 'unknown%' 
	GROUP BY 
		cast(DATEADD(month, datediff(month,0,act.start_time),0) as date)
		,act.sport
		,act.sub_sport
	) tbl
JOIN [src].[GarminSummary/MonthsSummary] gsm ON gsm.first_day = tbl.first_day
WHERE sum_elapsed_time <> 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwSleepStress] AS

/*
This view selects health and sleep daily data to analyse correlation and impact exercises 
to sleep and stress
*/


SELECT ds.[day] AS [Date]
	,ds.[hr_min]
	,ds.[hr_max]
	,ds.[rhr] AS hr_rest
	,ds.[stress_avg]
	,ds.[steps]
	,ds.[step_goal]
	,datediff(minute, '00:00:00', ds.moderate_activity_time) AS moderate_activity_time
	,datediff(minute, '00:00:00', ds.vigorous_activity_time) AS vigorous_activity_time
	--,datediff(minute,'00:00:00',ds.[intensity_time_goal]) -- this is for week summary, not days
	,ds.[rr_max] AS respiratory_rate_max
	,ds.[rr_waking_avg] AS respiratory_rate_min
	,datediff(minute, '00:00:00', sp.[total_sleep]) AS total_sleep
	,datediff(minute, '00:00:00', sp.[deep_sleep]) AS deep_sleep
	,datediff(minute, '00:00:00', sp.[light_sleep]) AS light_sleep
	,datediff(minute, '00:00:00', sp.[rem_sleep]) AS rem_sleep
	,datediff(minute, '00:00:00', sp.[awake]) AS awake
	,sp.[avg_rr]
	,sp.[avg_stress]
	,sp.[score]
	,sp.[qualifier]
--,pt.[deep_sleep] AS [pt_deep_sleep]
FROM [src].[Garmin/DailySummary] ds
JOIN [src].[Garmin/Sleep] sp ON sp.day = ds.day
/* JOIN sleep_events table to check if sleep phases duration matches the daily summary.
LEFT JOIN (
	SELECT *
	FROM (
		SELECT CASE 
				WHEN DATEPART(hour, TIMESTAMP) >= 20
					THEN cast(dateadd(day, 1, TIMESTAMP) AS DATE)
				ELSE cast(TIMESTAMP AS DATE)
				END AS DATE
			,event
			,datediff(minute, '0:00:00', duration) AS phase_duration
		FROM [src].[sleep_events]
		) AS tmp
	PIVOT(sum(phase_duration) FOR [event] IN (
				[awake]
				,[deep_sleep]
				,[light_sleep]
				,[rem_sleep]
				)) AS pivot_table
	) AS pt ON pt.DATE = ds.day
*/
WHERE 1 = 1
	AND ds.[day] >= '2023-02-11' -- watch bought date
	AND sp.qualifier IS NOT NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[vwStressDayActiveMinutes] as

/*
Data to analyse correlation between stress level and active minutes across days
*/


SELECT ds.day
	,datename(weekday,ds.day) as week_day
	,ds.stress_avg
	,ds.calories_active
	,ds.distance
	,datediff(minute, '00:00:00', ds.moderate_activity_time) AS moderate_activity_time
	,datediff(minute, '00:00:00', ds.vigorous_activity_time) AS vigorous_activity_time
	,ds.bb_charged
	,ds.bb_max
	,LEAD(ds.stress_avg,1) OVER (ORDER BY ds.[day] asc) as stress_next_day
	
FROM src.[Garmin/DailySummary] ds
WHERE ds.day >= '2023-02-11'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/SleepEvents](
	[timestamp] [datetime2](7) NULL,
	[event] [nvarchar](255) NULL,
	[duration] [time](0) NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/SleepEvents_timestamp] ON [src].[Garmin/SleepEvents]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[vwExercisesSleepPhases] as 

/*
This view is summary of sleep data, avg stress during sleep with exercises from previous day.
Further, to analyse how training, and on wchich time of the day, impacts sleep phases and sleep stability.
Activity data taken from [garmin_activities] server.

NEED TO PIVOT ACTIVITY TABLE TO GET MORNING, AFTERNOON AND EVENING ACTIVITY !!!
*/

select 
	sp.[day]
	,sp.[start] as sleep_start
	,sp.[end] as sleep_end
	,datediff(minute, '00:00:00', sp.[total_sleep]) AS total_sleep
	,datediff(minute, '00:00:00', sp.[deep_sleep]) AS deep_sleep
	,datediff(minute, '00:00:00', sp.[light_sleep]) AS light_sleep
	,datediff(minute, '00:00:00', sp.[rem_sleep]) AS rem_sleep
	,datediff(minute, '00:00:00', sp.[awake]) AS awake
	,se.awake as awake_count
	,sp.avg_rr
	,sp.avg_stress
	,sp.score
	,sp.qualifier
    ,a.name as activity_name
    ,a.laps
    ,a.sport
    ,a.sub_sport
    ,a.start_time
    ,a.stop_time
    ,datediff(minute,'00:00:00',a.elapsed_time) as elapsed_time
    ,a.distance as distance_km
    ,a.cycles
    ,a.avg_hr
    ,a.max_hr
    ,a.calories
    ,a.avg_cadence
    ,a.max_cadence
    ,a.hrz_1_hr
    ,a.hrz_2_hr
    ,a.hrz_3_hr
    ,a.hrz_4_hr
    ,a.hrz_5_hr
    ,datediff(minute, '00:00:00', a.hrz_1_time) as hrz_1_time
    ,datediff(minute, '00:00:00', a.hrz_2_time) as hrz_2_time
    ,datediff(minute, '00:00:00', a.hrz_3_time) as hrz_3_time
    ,datediff(minute, '00:00:00', a.hrz_4_time) as hrz_4_time
    ,datediff(minute, '00:00:00', a.hrz_5_time) as hrz_5_time
	,case when cast(a.start_time as time) between '18:00:00' and '22:00:00' then 1 end as evening_activity_ind
from [src].[Garmin/Sleep] sp

/*join [garmin].[src].[sleep_events] to get how many times I was awake*/
LEFT JOIN (
	SELECT * FROM (
		SELECT CASE 
				WHEN DATEPART(hour, TIMESTAMP) >= 20	/* to distinct for wchich day the sleep_phase should be assigned for */
					THEN cast(dateadd(day, 1, TIMESTAMP) AS DATE)
				ELSE cast(TIMESTAMP AS DATE)
				END AS DATE
			,event
			,datediff(minute, '0:00:00', duration) AS phase_duration
		FROM [src].[Garmin/SleepEvents]
		) AS tmp
	PIVOT(COUNT(phase_duration) FOR [event] IN (
				[awake]
				,[deep_sleep]
				,[light_sleep]
				,[rem_sleep]
				)) AS pivot_table
	) AS se ON se.DATE = sp.day

/* join to get activities details from previous day */
LEFT JOIN [src].[GarminActivities/Activities] a ON cast([start_time] as date) = dateadd(day,-1,sp.day)

where 1=1
	and sp.start is not null	/*only records with sleep data*/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[vwSleepPhasesBbStress] as 

/*
Data to analyse how sleep phases impacts body battery and stress during the day
*/


SELECT 
	ds.day
	--,sp.day as previous_day
	,ds.bb_charged	--body battery charged by this day sleep
	,ds.bb_max		--bb max after sleep
	,ds.bb_min		--bb before next sleep or rest during the day
	,ds.stress_avg as daily_avg_stress	--daily average stress
	,stt.morning_avg_stress
	,stt.afternoon_avg_stress
	,stt.evening_avg_stress
	,datediff(minute, '00:00:00', sp.[total_sleep]) AS total_sleep
	,datediff(minute, '00:00:00', sp.[deep_sleep]) AS deep_sleep
	,datediff(minute, '00:00:00', sp.[light_sleep]) AS light_sleep
	,datediff(minute, '00:00:00', sp.[rem_sleep]) AS rem_sleep
	,datediff(minute, '00:00:00', sp.[awake]) AS awake

FROM [src].[Garmin/DailySummary] ds
left JOIN [src].[Garmin/Sleep] sp ON sp.day = ds.day
--query to get avg stress during the day
join (
	select 
		st.day
		,avg(st.morning_avg_stress) as morning_avg_stress
		,avg(st.afternoon_avg_stress) as afternoon_avg_stress
		,avg(st.evening_avg_stress) as evening_avg_stress
	from (
			select 
				CAST(timestamp as date) as day 
				,case when cast(timestamp as time) between '06:00:00' and '12:00:00' then avg(stress) end as morning_avg_stress
				,case when cast(timestamp as time) between '12:00:00' and '18:00:00' then avg(stress) end as afternoon_avg_stress
				,case when cast(timestamp as time) between '18:00:00' and '22:00:00' then avg(stress) end as evening_avg_stress
			from [src].[Garmin/Stress]
			where stress > 0 and cast(timestamp as time) between '06:00:00' and '22:00:00'
			group by timestamp--,CAST(timestamp as date)
			) st
	group by st.day
) stt ON stt.day = ds.day

WHERE 1 = 1
	AND ds.[day] >= '2023-02-11' -- watch bought date
	AND sp.qualifier IS NOT NULL

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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwTblMonthlySummary] as 

	SELECT 
		convert(varchar(7), [DAY], 126)  as [month_num]
		,min(format([day], 'MMMM')) AS [month_name]
		,min([day]) AS [first_day]
		,datename(weekday, min([day])) AS [date_name]
		,min([hr_min]) AS [hr_min]
		,max([hr_max]) AS [hr_max]
		,avg([hr_avg]) AS [hr_avg]
		,avg([rhr]) AS [rhr]
		,min([rhr_min]) AS [rhr_min]
		,max([rhr_max]) AS [rhr_max]
		,sum([step_goal]) AS [step_goal]
		,sum([steps]) AS [steps]
		,sum([moderate_activity_time]) AS [moderate_activity_time]
		,sum([vigorous_activity_time]) AS [vigorous_activity_time]
		,sum([intensity_time_goal]) AS [intensity_time_goal]
		,sum([floors_up]) AS [floors_up]
		,sum([floors_down]) AS [floors_down]
		,sum([floors_goal]) AS [floors_goal]
		,avg([total_sleep]) AS [total_sleep_avg]
		,min([sleep_min]) AS [sleep_min]
		,max([sleep_max]) AS [sleep_max]
		,avg([deep_sleep]) AS [deep_sleep_avg]
		,avg([light_sleep]) AS [light_sleep_avg]
		,avg([rem_sleep]) AS [rem_sleep_avg]
		,avg([awake]) AS [awake_avg]
		,avg([stress_avg]) AS [stress_avg]
		,sum([distance]) AS [distance]
		,sum([calories_total]) AS [calories_total]
		,sum([calories_bmr]) AS [calories_bmr]
		,sum([calories_active]) AS [calories_active]
		,count([activities]) AS [activities]
		,sum([activities_calories]) AS [activities_calories]
		,sum([activities_distance_km]) AS [activities_distance_km]
		,sum([daily_distance_km]) AS [monthly_distance_km]
		,sum([sweat_loss]) AS [sweat_loss]
		,avg([spo2_avg]) AS [spo2_avg]
		,min([spo2_min]) AS [spo2_min]
		,avg([rr_avg_waking]) AS [rr_avg_waking]
		,max([rr_max]) AS [rr_max]
		,min([rr_min]) AS [rr_min]
		,avg([bb_charged]) AS [bb_charged]
		,max([bb_max]) AS [bb_max]
		,min([bb_min]) AS [bb_min]
		--,as [description]
	FROM [dbo].[DailySummary]
	GROUP BY convert(varchar(7), [DAY], 126) --month_num

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwTblWeeklySummary] as 

	SELECT 
		concat((year([day])),'-',format(datepart(ISO_WEEK, DATEADD(DAY, 0, ([DAY]))),'00')) AS [week_num]
		,min([day]) AS [first_day]
		,datename(weekday, min([day])) AS [date_name]
		,min([hr_min]) AS [hr_min]
		,max([hr_max]) AS [hr_max]
		,avg([hr_avg]) AS [hr_avg]
		,avg([rhr]) AS [rhr]
		,min([rhr_min]) AS [rhr_min]
		,max([rhr_max]) AS [rhr_max]
		,sum([step_goal]) AS [step_goal]
		,sum([steps]) AS [steps]
		,sum([moderate_activity_time]) AS [moderate_activity_time]
		,sum([vigorous_activity_time]) AS [vigorous_activity_time]
		,sum([intensity_time_goal]) AS [intensity_time_goal]
		,sum([floors_up]) AS [floors_up]
		,sum([floors_down]) AS [floors_down]
		,sum([floors_goal]) AS [floors_goal]
		,avg([total_sleep]) AS [total_sleep_avg]
		,min([sleep_min]) AS [sleep_min]
		,max([sleep_max]) AS [sleep_max]
		,avg([deep_sleep]) AS [deep_sleep_avg]
		,avg([light_sleep]) AS [light_sleep_avg]
		,avg([rem_sleep]) AS [rem_sleep_avg]
		,avg([awake]) AS [awake_avg]
		,avg([stress_avg]) AS [stress_avg]
		,sum([distance]) AS [distance]
		,sum([calories_total]) AS [calories_total]
		,sum([calories_bmr]) AS [calories_bmr]
		,sum([calories_active]) AS [calories_active]
		,count([activities]) AS [activities]
		,sum([activities_calories]) AS [activities_calories]
		,sum([activities_distance_km]) AS [activities_distance_km]
		,sum([daily_distance_km]) AS [monthly_distance_km]
		,sum([sweat_loss]) AS [sweat_loss]
		,avg([spo2_avg]) AS [spo2_avg]
		,min([spo2_min]) AS [spo2_min]
		,avg([rr_avg_waking]) AS [rr_avg_waking]
		,max([rr_max]) AS [rr_max]
		,min([rr_min]) AS [rr_min]
		,avg([bb_charged]) AS [bb_charged]
		,max([bb_max]) AS [bb_max]
		,min([bb_min]) AS [bb_min]
		--,as [description]
	FROM [dbo].[DailySummary] 
	GROUP BY concat((year([day])),'-',format(datepart(ISO_WEEK, DATEADD(DAY, 0, ([DAY]))),'00')) --week_num

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwTblYearlySummary] as 

	SELECT 
		datepart(year, [DAY]) AS [year]
		,min([day]) AS [first_day]
		,datename(weekday, min([day])) AS [date_name]
		,min([hr_min]) AS [hr_min]
		,max([hr_max]) AS [hr_max]
		,avg([hr_avg]) AS [hr_avg]
		,avg([rhr]) AS [rhr]
		,min([rhr_min]) AS [rhr_min]
		,max([rhr_max]) AS [rhr_max]
		,sum([step_goal]) AS [step_goal]
		,sum([steps]) AS [steps]
		,sum([moderate_activity_time]) AS [moderate_activity_time]
		,sum([vigorous_activity_time]) AS [vigorous_activity_time]
		,sum([intensity_time_goal]) AS [intensity_time_goal]
		,sum([floors_up]) AS [floors_up]
		,sum([floors_down]) AS [floors_down]
		,sum([floors_goal]) AS [floors_goal]
		,avg([total_sleep]) AS [total_sleep_avg]
		,min([sleep_min]) AS [sleep_min]
		,max([sleep_max]) AS [sleep_max]
		,avg([deep_sleep]) AS [deep_sleep_avg]
		,avg([light_sleep]) AS [light_sleep_avg]
		,avg([rem_sleep]) AS [rem_sleep_avg]
		,avg([awake]) AS [awake_avg]
		,avg([stress_avg]) AS [stress_avg]
		,sum([distance]) AS [distance]
		,sum([calories_total]) AS [calories_total]
		,sum([calories_bmr]) AS [calories_bmr]
		,sum([calories_active]) AS [calories_active]
		,count([activities]) AS [activities]
		,sum([activities_calories]) AS [activities_calories]
		,sum([activities_distance_km]) AS [activities_distance_km]
		,sum([daily_distance_km]) AS [monthly_distance_km]
		,sum([sweat_loss]) AS [sweat_loss]
		,avg([spo2_avg]) AS [spo2_avg]
		,min([spo2_min]) AS [spo2_min]
		,avg([rr_avg_waking]) AS [rr_avg_waking]
		,max([rr_max]) AS [rr_max]
		,min([rr_min]) AS [rr_min]
		,avg([bb_charged]) AS [bb_charged]
		,max([bb_max]) AS [bb_max]
		,min([bb_min]) AS [bb_min]
		--,as [description]
	FROM [dbo].[DailySummary]
	GROUP BY datepart(year, [DAY])
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/DailySummary] as select * from openquery(garmin,'select * from daily_summary')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/RestingHr] as select * from openquery(garmin,'select * from resting_hr')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/Sleep] as select * from openquery(garmin,'select * from sleep')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/SleepEvents] as select * from openquery(garmin,'select * from sleep_events')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/Stress] as select * from openquery(garmin,'select * from stress')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarmin/Weight] as select * from openquery(garmin,'select * from weight')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/Activities] as select * from openquery(garmin_activities,'select * from activities')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/ActivityLaps] as select * from openquery(garmin_activities,'select * from activity_laps')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/ActivityRecords] as select * from openquery(garmin_activities,'select * from activity_records')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/CycleActivities] as select * from openquery(garmin_activities,'select * from cycle_activities')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/PaddleActivities] as select * from openquery(garmin_activities,'select * from paddle_activities')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminActivities/StepsActivities] as select * from openquery(garmin_activities,'select * from steps_activities')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/Monitoring] as select * from openquery(garmin_monitoring,'select * from monitoring')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringClimb] as select * from openquery(garmin_monitoring,'select * from monitoring_climb')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringHr] as select * from openquery(garmin_monitoring,'select * from monitoring_hr')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringInfo] as select * from openquery(garmin_monitoring,'select * from monitoring_info')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringIntensity] as select * from openquery(garmin_monitoring,'select * from monitoring_intensity')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringPulseOx] as select * from openquery(garmin_monitoring,'select * from monitoring_pulse_ox')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminMonitoring/MonitoringRr] as select * from openquery(garmin_monitoring,'select * from monitoring_rr')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/DaysSummary] as select * from openquery(garmin_summary,'select * from days_summary')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/IntensityHr] as select * from openquery(garmin_summary,'select * from intensity_hr')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/MonthsSummary] as select * from openquery(garmin_summary,'select * from months_summary')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/WeeksSummary] as select * from openquery(garmin_summary,'select * from weeks_summary')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [src].[vwGarminSummary/YearsSummary] as select * from openquery(garmin_summary,'select * from years_summary')
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [acc].[LogTable](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessType] [nvarchar](100) NULL,
	[LoadStart] [datetime] NULL,
	[LoadEnd] [datetime] NULL,
	[PriorCutOffDate] [date] NULL,
	[CutOffDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [acc].[SrcTblConfig](
	[Domain] [nvarchar](50) NOT NULL,
	[TableName] [nvarchar](50) NOT NULL,
	[SchemaName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [acc].[SrcViewsConfig](
	[SchemaName] [nvarchar](100) NOT NULL,
	[ViewName] [nvarchar](100) NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[PrimaryColumnName] [nvarchar](100) NOT NULL,
	[IsActiveInd] [int] NULL,
	[MergeType] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonthlySummary](
	[month_num] [varchar](7) NULL,
	[month_name] [nvarchar](4000) NULL,
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
CREATE CLUSTERED INDEX [IX_MonthlySummary_month_num] ON [dbo].[MonthlySummary]
(
	[first_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeeklySummary](
	[week_num] [nvarchar](4000) NOT NULL,
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
CREATE CLUSTERED INDEX [IX_WeeklySummary_first_day] ON [dbo].[WeeklySummary]
(
	[first_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/RestingHr](
	[day] [date] NULL,
	[resting_heart_rate] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/RestingHr_day] ON [src].[Garmin/RestingHr]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/Weight](
	[day] [date] NULL,
	[weight] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/Weight_day] ON [src].[Garmin/Weight]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/CycleActivities](
	[strokes] [int] NULL,
	[vo2_max] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/StepsActivities](
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringPulseOx](
	[timestamp] [datetime2](7) NULL,
	[pulse_ox] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringPulseOx_timestamp] ON [src].[GarminMonitoring/MonitoringPulseOx]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminSummary/DaysSummary](
	[day] [date] NULL,
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
CREATE UNIQUE CLUSTERED INDEX [IX_GarminSummary/DaysSummary_day] ON [src].[GarminSummary/DaysSummary]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminSummary/IntensityHr](
	[timestamp] [datetime2](7) NULL,
	[intensity] [int] NULL,
	[heart_rate] [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminSummary/IntensityHr_timestamp] ON [src].[GarminSummary/IntensityHr]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminSummary/WeeksSummary](
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
CREATE UNIQUE CLUSTERED INDEX [IX_GarminSummary/WeeksSummary_first_day] ON [src].[GarminSummary/WeeksSummary]
(
	[first_day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [acc].[LogTable] ADD  DEFAULT (getdate()) FOR [LoadStart]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_CreateIndexesOnSourceTbls] AS 

/* 
Procudure that creates indexes on all source tables (except summary tables) for date/time columns with ordinal position = 1 

exec [dbo].[p_CreateIndexesOnSourceTbls]
*/


DECLARE @SchemaName NVARCHAR(255)
DECLARE @TableName NVARCHAR(255)
DECLARE @ColumnName NVARCHAR(255)

DECLARE IndexCuror CURSOR FOR
	SELECT TRIM(TABLE_SCHEMA), TRIM(TABLE_NAME), TRIM(COLUMN_NAME)
	FROM (
		SELECT t.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.ORDINAL_POSITION, ROW_NUMBER() over (partition by c.TABLE_NAME order by c.ORDINAL_POSITION) as rn
		FROM INFORMATION_SCHEMA.COLUMNS c
		JOIN INFORMATION_SCHEMA.TABLES t on c.TABLE_NAME = t.TABLE_NAME and c.TABLE_SCHEMA = t.TABLE_SCHEMA
		WHERE t.TABLE_SCHEMA = 'src' 
			AND t.TABLE_TYPE = 'BASE TABLE'
			--AND t.TABLE_NAME NOT LIKE '%SUMMARY%' 
			AND t.TABLE_NAME NOT IN ( 'GarminActivities/StepsActivities  ', 'GarminMonitoring/MonitoringInfo  ', 'GarminMonitoring/Monitoring  ')
			AND (c.DATA_TYPE LIKE '%date%' OR c.DATA_TYPE LIKE '%time%')
	) tmp WHERE tmp.rn = 1

OPEN IndexCuror
FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Add indexes for datetime columns
    DECLARE @IndexName NVARCHAR(255)
    SET @IndexName = 'IX_' + @TableName + '_' + @ColumnName

    DECLARE @SQL NVARCHAR(MAX)
	SET @SQL = 'DROP INDEX IF EXISTS [' + @IndexName + '] ON ['+ @SchemaName+'].[' + @TableName + ']' 
    EXEC sp_executesql @SQL

	SET @SQL = 'CREATE UNIQUE CLUSTERED INDEX [' + @IndexName + '] ON ['+ @SchemaName+'].[' + @TableName + '](['+@ColumnName+']);'
	EXEC sp_executesql @SQL

    FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

END

CLOSE IndexCuror
DEALLOCATE IndexCuror

/*
script to drop indexes

DECLARE @SchemaName NVARCHAR(255)
DECLARE @TableName NVARCHAR(255)
DECLARE @ColumnName NVARCHAR(255)

DECLARE IndexCuror CURSOR FOR

SELECT TRIM(TABLE_SCHEMA), TRIM(TABLE_NAME), TRIM(COLUMN_NAME)
FROM (
	SELECT t.TABLE_SCHEMA, c.TABLE_NAME, c.COLUMN_NAME, c.ORDINAL_POSITION, ROW_NUMBER() over (partition by c.TABLE_NAME order by c.ORDINAL_POSITION) as rn
	FROM INFORMATION_SCHEMA.COLUMNS c
	JOIN INFORMATION_SCHEMA.TABLES t on c.TABLE_NAME = t.TABLE_NAME and c.TABLE_SCHEMA = t.TABLE_SCHEMA
	WHERE t.TABLE_SCHEMA = 'src' 
		AND t.TABLE_TYPE = 'BASE TABLE'
		AND t.TABLE_NAME NOT LIKE '%SUMMARY%' 
		AND t.TABLE_NAME NOT LIKE 'GarminActivities/StepsActivities  '
		AND (c.DATA_TYPE LIKE '%date%' OR c.DATA_TYPE LIKE '%time%')
) tmp WHERE tmp.rn = 1

OPEN IndexCuror
FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- dropping indexes for datetime columns
    DECLARE @IndexName NVARCHAR(255)
    SET @IndexName = 'IX_' + @TableName + '_' + @ColumnName

    DECLARE @SQL NVARCHAR(MAX)
    SET @SQL = 'DROP INDEX [' + @IndexName + '] ON ['+ @SchemaName+'].[' + @TableName + '](['+@ColumnName+']);'
	EXEC sp_executesql @SQL

    FETCH NEXT FROM IndexCuror INTO @SchemaName, @TableName, @ColumnName

END

CLOSE IndexCuror
DEALLOCATE IndexCuror

*/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[p_CreateSrcViews]
AS
/*
EXEC [dbo].[p_CreateSrcViews]
*/

DECLARE @LinkedServer NVARCHAR(255)
DECLARE @cursor CURSOR;
DECLARE @TableName NVARCHAR(255);
DECLARE @Schemaname NVARCHAR(10);
DECLARE @ViewName NVARCHAR(255);

BEGIN
	SET NOCOUNT ON
	SET @cursor = CURSOR FOR

	SELECT Domain, TableName, SchemaName
	FROM acc.SrcTblConfig
	WHERE IsActive = 1

	OPEN @cursor

	FETCH NEXT FROM @cursor
	INTO @LinkedServer, @TableName, @Schemaname

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SET @ViewName = QUOTENAME(@Schemaname) + '.' + QUOTENAME('vw'+ [dbo].[fn_InitCap](@LinkedServer)+'/'+[dbo].[fn_InitCap](@TableName))
		
		IF OBJECT_ID(@ViewName, 'V') IS NOT NULL
		BEGIN
			EXEC ('DROP VIEW ' + @ViewName )
			EXEC ('CREATE VIEW ' + @ViewName + ' as select * from openquery(' + @LinkedServer + ',''select * from ' + @TableName + ''')')
		END

		IF OBJECT_ID(@ViewName, 'V') IS NULL
		BEGIN
			EXEC ('create or alter view ' + @ViewName + ' as select * from openquery(' + @LinkedServer + ',''select * from ' + @TableName + ''')')
		END


		FETCH NEXT FROM @cursor
		INTO @LinkedServer, @TableName, @Schemaname
	END

	CLOSE @cursor;
	DEALLOCATE @cursor
END



GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_IncrementalMergeDailyData] @CutOffDate DATE AS 

;WITH cte_rhr as (
	SELECT cast([day] as date) as [day]
		,min(moving_avg) AS resting_heart_rate
	FROM (
		SELECT TIMESTAMP AS [day]
			,avg(heart_rate) OVER (ORDER BY TIMESTAMP rows BETWEEN 30 preceding	AND CURRENT row) AS moving_avg
		FROM [src].[GarminMonitoring/MonitoringHr]
		GROUP BY TIMESTAMP, heart_rate
		HAVING cast(TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
		) AS tmp
	GROUP BY cast([day] as date)
	--ORDER BY [day]
	)

,cte_hr as (
	SELECT cast(TIMESTAMP AS DATE) AS [day]
		,min(heart_rate) AS min_heart_rate
		,max(heart_rate) AS max_heart_rate
		,avg(heart_rate) AS avg_heart_rate
	FROM [src].[GarminMonitoring/MonitoringHr] hrt
	GROUP BY cast(TIMESTAMP AS DATE)
	HAVING cast(TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
	--ORDER BY day
)

,cte_stress as (
	SELECT cast(s.TIMESTAMP AS DATE) AS day
		,avg(s.stress) AS avg_stress
	FROM [src].[Garmin/Stress] s
	WHERE s.stress > 0  
	GROUP BY cast(TIMESTAMP AS DATE)
	HAVING cast(TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate)
	--ORDER BY day
	)

,cte_activity_time as (
	SELECT cast(TIMESTAMP AS DATE) AS day
		,sum(datediff(minute, '00:00:00:00', moderate_activity_time)) AS moderate_activity_time
		,sum(datediff(minute, '00:00:00:00', vigorous_activity_time)) AS vigorous_activity_time
	FROM [src].[GarminMonitoring/MonitoringIntensity] 
	GROUP BY cast(TIMESTAMP AS DATE)
	HAVING cast(TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate)  
	)

,cte_steps as (
	SELECT cast(mt.TIMESTAMP AS DATE) AS day
		,round(sum(mt.distance) / 1000, 2) AS distance_km
		,sum(mt.steps) AS steps
	FROM [src].[GarminMonitoring/Monitoring] mt
	WHERE cast(mt.TIMESTAMP AS TIME) = '23:59:59' -- because values sums cummulative
		AND mt.activity_type NOT IN ('generic','stop_disable')
	GROUP BY cast(mt.TIMESTAMP AS DATE), mt.TIMESTAMP
	HAVING cast(mt.TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
	)

,cte_floors as (
	SELECT cast(TIMESTAMP AS DATE) AS day
		,round(sum(ascent)/3, 2) AS floors_up
		,round(sum(descent)/3, 2) AS floors_down
	FROM [src].[GarminMonitoring/MonitoringClimb]
	GROUP BY cast(TIMESTAMP AS DATE)
	HAVING cast(TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 

	--ORDER BY cast(TIMESTAMP AS DATE)
	)

,cte_calories as (
	SELECT cast(mt.TIMESTAMP AS DATE) AS day
		,sum(mt.active_calories) AS calories_active
		,(SELECT TOP 1 mm.resting_metabolic_rate
			FROM [src].[GarminMonitoring/MonitoringInfo] mm
			WHERE cast(mm.TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
				AND cast(mt.TIMESTAMP AS DATE) = cast(mm.TIMESTAMP AS DATE)
			) AS calories_bmr
		,sum(mt.active_calories) + (
			SELECT TOP 1 mm.resting_metabolic_rate
			FROM [src].[GarminMonitoring/MonitoringInfo] mm
			WHERE cast(mm.TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
				AND cast(mt.TIMESTAMP AS DATE) = cast(mm.TIMESTAMP AS DATE)
			) AS calories_total
	FROM [src].[GarminMonitoring/Monitoring] mt
	WHERE cast(mt.TIMESTAMP AS TIME) = '23:59:59' -- because values sums cummulative
		AND mt.activity_type NOT IN ('stop_disable')
	GROUP BY cast(mt.TIMESTAMP AS DATE), mt.TIMESTAMP
	HAVING cast(mt.TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
	)

,cte_respiratory_rate as (
	select 
		cast(rr.timestamp as date) as day
		,max(rr.rr) as rr_max
		,min(rr.rr) as rr_min
		,(
			SELECT ROUND(avg(rr2.rr),2) 
			FROM [src].[GarminMonitoring/MonitoringRr] rr2
			LEFT JOIN [src].[Garmin/Sleep] slp on cast(rr2.timestamp as date) = slp.[day]
			WHERE rr2.timestamp BETWEEN slp.[start] AND slp.[end] --between '06:30:00.0000000' and '23:00:00.0000000'
				AND CAST(rr2.timestamp as date) = CAST(rr.timestamp as date) 
			GROUP BY cast(rr2.timestamp as date)
			HAVING cast(rr2.TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
		) as rr_avg_waking
	FROM [src].[GarminMonitoring/MonitoringRr] rr
	GROUP BY cast(rr.timestamp AS DATE)
	HAVING cast(rr.TIMESTAMP AS DATE) >= DATEADD(day,-1,@CutOffDate) 
	--order by 1
	)

,cte_sleep as (
	select 
		*
		,lead(total_sleep		,1)	over (order by day) as next_day_total_sleep
		,lead(deep_sleep		,1)	over (order by day) as next_day_deep_sleep 
		,lead(light_sleep		,1)	over (order by day) as next_day_light_sleep
		,lead(rem_sleep			,1)	over (order by day) as next_day_rem_sleep	 
		,lead(awake				,1)	over (order by day) as next_day_awake
		,lead(sleep_score		,1)	over (order by day) as next_day_sleep_score
		,lead(qualifier			,1)	over (order by day) as next_day_qualifier
	from (
		select 
			[day]
			,datediff(minute, '00:00:00',total_sleep	) as total_sleep
			,datediff(minute, '00:00:00',deep_sleep		) as deep_sleep	
			,datediff(minute, '00:00:00',light_sleep	) as light_sleep
			,datediff(minute, '00:00:00',rem_sleep		) as rem_sleep	
			,datediff(minute, '00:00:00',awake			) as awake		
			,score as sleep_score
			,qualifier 
		from [src].[Garmin/Sleep]
		where [day] >= DATEADD(day,-1,@CutOffDate) 
		) tbl
	)

,cte_activity_count as (
	select 
		cast(mtr.timestamp as date) as day
		,COALESCE(sum(act.activity_count),0) as activity_count
		,COALESCE(sum(act.activity_calories),0) as activity_calories
		,COALESCE(sum(act.activity_distance),0) as activity_distance
		,sum(mtr.distance)/1000 + COALESCE(sum(act.activity_distance),0) as daily_distance
		,sum(mtr.steps) as steps
	from [src].[GarminMonitoring/Monitoring] mtr
	LEFT JOIN 
		(select 
			cast(act.start_time as date) as day
			,count(act.sport) as activity_count
			,sum(act.calories) as activity_calories
			,sum(act.distance) as activity_distance
			--,sum(mtr.daily_distance) as daily_distance --including steps
		from [src].[GarminActivities/Activities] act
		group by cast(act.start_time AS DATE)
		HAVING  cast(act.start_time AS DATE) >= DATEADD(day,-1,@CutOffDate) 
		) act ON act.day = cast(mtr.timestamp AS DATE)

	WHERE cast(mtr.timestamp as time) = '23:59:59.0000000' 
		AND mtr.activity_type = 'walking'
	group by cast(mtr.timestamp as date)
	HAVING cast(mtr.timestamp AS DATE) >= DATEADD(day,-1,@CutOffDate) 
)

-- ########################### MAIN QUERY ####################################

SELECT 
	rhr.[day]
	,datename(weekday,rhr.[day]) as date_name
	,case when datename(weekday,rhr.[day]) in ('Saturday','Sunday') then 1 else 0 end as isweekend_ind
	,htr.min_heart_rate as hr_min
	,htr.max_heart_rate as hr_max
	,htr.avg_heart_rate as hr_avg
	,rhr.resting_heart_rate as rhr --Daily RHR is calculated using the lowest 30 minute average in a 24 hour period.
	,rhr.resting_heart_rate as rhr_min
	,rhr.resting_heart_rate as rhr_max
	,dsm.step_goal
	,stp.steps
	,COALESCE(act.moderate_activity_time,0) AS moderate_activity_time
	,COALESCE(act.vigorous_activity_time,0) AS vigorous_activity_time
	,ROUND(DATEDIFF(MINUTE, 0, dsm.intensity_time_goal) / cast(7 as decimal(3,2)), 2) as intensity_time_goal --set as constant value 
	,flr.floors_up --based on internal barometer to measure elevation changes as you climb floors. A floor climbed is equal to 3m 
	,flr.floors_down
	,dsm.floors_goal as floors_goal --set as constant value 
	,slp.total_sleep
	,slp.total_sleep as sleep_min
	,slp.total_sleep as sleep_max
	,slp.deep_sleep	
	,slp.light_sleep
	,slp.rem_sleep
	,slp.awake	
	,slp.sleep_score
	,slp.qualifier
	,slp.next_day_total_sleep
	,slp.next_day_deep_sleep 
	,slp.next_day_light_sleep
	,slp.next_day_rem_sleep	
	,slp.next_day_awake	
	,slp.next_day_sleep_score
	,slp.next_day_qualifier
	,sts.avg_stress as stress_avg --Using heart rate variability (HRV)
 	,stp.distance_km as distance
	,NULL AS calories_goal
	,cal.calories_total
	,cal.calories_bmr
	,cal.calories_active
	,NULL AS calories_consumed
	,acc.activity_count as activities
	,acc.activity_calories as activities_calories
	,acc.activity_distance as activities_distance_km
	,acc.daily_distance as daily_distance_km
	,dsm.hydration_goal AS [hydration_goal]
	,dsm.hydration_intake AS [hydration_intake]
	,COALESCE(dsm.sweat_loss,0) AS [sweat_loss]
	,dsm.spo2_avg AS [spo2_avg]
	,dsm.spo2_min AS [spo2_min]
	,rsr.rr_avg_waking
	,rsr.rr_max
	,rsr.rr_min 
	,dsm.bb_charged
	,dsm.bb_max
	,dsm.bb_min
	,dsm.description as [description]
INTO #dailysummary
FROM cte_rhr rhr
LEFT JOIN cte_hr htr ON htr.day								= rhr.day
LEFT JOIN cte_stress sts ON sts.day							= rhr.day
LEFT JOIN cte_activity_time act on act.day					= rhr.day
LEFT JOIN cte_steps stp ON stp.day							= rhr.day
LEFT JOIN cte_floors flr ON flr.day							= rhr.day
LEFT JOIN cte_sleep slp ON slp.day							= rhr.day
LEFT JOIN cte_calories cal on cal.day						= rhr.day
LEFT JOIN cte_respiratory_rate rsr ON rsr.day				= rhr.day
LEFT JOIN [src].[Garmin/DailySummary] dsm ON dsm.day		= rhr.day
LEFT JOIN cte_activity_count acc ON acc.day					= rhr.day
order by rhr.[day]



-- MERGE LATEST DATA WITH DAILY SUMMARY TABLE

MERGE INTO [dbo].[DailySummary] AS target
USING ( 
	SELECT 
		[day],[date_name],[isweekend_ind],[hr_min],[hr_max],[hr_avg],[rhr],[rhr_min],[rhr_max],[step_goal],[steps],[moderate_activity_time],[vigorous_activity_time],[intensity_time_goal]
		,[floors_up],[floors_down],[floors_goal],[total_sleep],[sleep_min],[sleep_max],[deep_sleep],[light_sleep],[rem_sleep],[awake],[sleep_score],[qualifier],[next_day_total_sleep]
		,[next_day_deep_sleep],[next_day_light_sleep],[next_day_rem_sleep],[next_day_awake],[next_day_sleep_score],[next_day_qualifier],[stress_avg],[distance],[calories_total]
		,[calories_bmr],[calories_active],[activities],[activities_calories],[activities_distance_km],[daily_distance_km],[hydration_goal],[hydration_intake],[sweat_loss]
		,[spo2_avg],[spo2_min],[rr_avg_waking],[rr_max],[rr_min],[bb_charged],[bb_max],[bb_min],[description]	
	FROM #dailysummary
	) AS source
ON target.day = source.[day]
WHEN MATCHED THEN
    UPDATE SET
		target.[date_name]=source.[date_name]
		,target.[isweekend_ind]=source.[isweekend_ind]
		,target.[hr_min]=source.[hr_min]
		,target.[hr_max]=source.[hr_max]
		,target.[hr_avg]=source.[hr_avg]
		,target.[rhr]=source.[rhr]
		,target.[rhr_min]=source.[rhr_min]
		,target.[rhr_max]=source.[rhr_max]
		,target.[step_goal]=source.[step_goal]
		,target.[steps]=source.[steps]
		,target.[moderate_activity_time]=source.[moderate_activity_time]
		,target.[vigorous_activity_time]=source.[vigorous_activity_time]
		,target.[intensity_time_goal]=source.[intensity_time_goal]
		,target.[floors_up]=source.[floors_up]
		,target.[floors_down]=source.[floors_down]
		,target.[floors_goal]=source.[floors_goal]
		,target.[total_sleep]=source.[total_sleep]
		,target.[sleep_min]=source.[sleep_min]
		,target.[sleep_max]=source.[sleep_max]
		,target.[deep_sleep]=source.[deep_sleep]
		,target.[light_sleep]=source.[light_sleep]
		,target.[rem_sleep]=source.[rem_sleep]
		,target.[awake]=source.[awake]
		,target.[sleep_score]=source.[sleep_score]
		,target.[qualifier]=source.[qualifier]
		,target.[next_day_total_sleep]=source.[next_day_total_sleep]
		,target.[next_day_deep_sleep]=source.[next_day_deep_sleep]
		,target.[next_day_light_sleep]=source.[next_day_light_sleep]
		,target.[next_day_rem_sleep]=source.[next_day_rem_sleep]
		,target.[next_day_awake]=source.[next_day_awake]
		,target.[next_day_sleep_score]=source.[next_day_sleep_score]
		,target.[next_day_qualifier]=source.[next_day_qualifier]
		,target.[stress_avg]=source.[stress_avg]
		,target.[distance]=source.[distance]
		,target.[calories_total]=source.[calories_total]
		,target.[calories_bmr]=source.[calories_bmr]
		,target.[calories_active]=source.[calories_active]
		,target.[activities]=source.[activities]
		,target.[activities_calories]=source.[activities_calories]
		,target.[activities_distance_km]=source.[activities_distance_km]
		,target.[daily_distance_km]=source.[daily_distance_km]
		,target.[hydration_goal]=source.[hydration_goal]
		,target.[hydration_intake]=source.[hydration_intake]
		,target.[sweat_loss]=source.[sweat_loss]
		,target.[spo2_avg]=source.[spo2_avg]
		,target.[spo2_min]=source.[spo2_min]
		,target.[rr_avg_waking]=source.[rr_avg_waking]
		,target.[rr_max]=source.[rr_max]
		,target.[rr_min]=source.[rr_min]
		,target.[bb_charged]=source.[bb_charged]
		,target.[bb_max]=source.[bb_max]
		,target.[bb_min]=source.[bb_min]
		,target.[description]=source.[description]

WHEN NOT MATCHED THEN
    INSERT (
		[day],[date_name],[isweekend_ind],[hr_min],[hr_max],[hr_avg],[rhr],[rhr_min],[rhr_max],[step_goal],[steps],[moderate_activity_time],[vigorous_activity_time],[intensity_time_goal]
		,[floors_up],[floors_down],[floors_goal],[total_sleep],[sleep_min],[sleep_max],[deep_sleep],[light_sleep],[rem_sleep],[awake],[sleep_score],[qualifier],[next_day_total_sleep]
		,[next_day_deep_sleep],[next_day_light_sleep],[next_day_rem_sleep],[next_day_awake],[next_day_sleep_score],[next_day_qualifier],[stress_avg],[distance],[calories_total]
		,[calories_bmr],[calories_active],[activities],[activities_calories],[activities_distance_km],[daily_distance_km],[hydration_goal],[hydration_intake],[sweat_loss]
		,[spo2_avg],[spo2_min],[rr_avg_waking],[rr_max],[rr_min],[bb_charged],[bb_max],[bb_min],[description]	
	)
    VALUES (
		source.[day], source.[date_name], source.[isweekend_ind], source.[hr_min], source.[hr_max], source.[rhr], source.[rhr_min], source.[rhr_max], source.[hr_avg], source.[step_goal], source.[steps]
		, source.[moderate_activity_time], source.[vigorous_activity_time], source.[intensity_time_goal], source.[floors_up], source.[floors_down],[floors_goal], source.[total_sleep], source.[sleep_min]
		, source.[sleep_max], source.[deep_sleep], source.[light_sleep], source.[rem_sleep], source.[awake], source.[sleep_score], source.[qualifier], source.[next_day_total_sleep]
		, source.[next_day_deep_sleep], source.[next_day_light_sleep], source.[next_day_rem_sleep], source.[next_day_awake], source.[next_day_sleep_score], source.[next_day_qualifier]
		, source.[stress_avg], source.[distance], source.[calories_total], source.[calories_bmr], source.[calories_active], source.[activities], source.[activities_calories]
		, source.[activities_distance_km], source.[daily_distance_km], source.[hydration_goal], source.[hydration_intake], source.[sweat_loss], source.[spo2_avg], source.[spo2_min]
		, source.[rr_avg_waking], source.[rr_max], source.[rr_min], source.[bb_charged], source.[bb_max], source.[bb_min], source.[description]	
	);

DROP TABLE #dailysummary;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_IncrementalMergeMonthlyData] @CutOffDate DATE AS  

BEGIN

	SELECT 
		convert(varchar(7), [DAY], 126)  as [month_num]
		,min(format([day], 'MMMM')) AS [month_name]
		,min([day]) AS [first_day]
		,datename(weekday, min([day])) AS [date_name]
		,min([hr_min]) AS [hr_min]
		,max([hr_max]) AS [hr_max]
		,avg([hr_avg]) AS [hr_avg]
		,avg([rhr]) AS [rhr]
		,min([rhr_min]) AS [rhr_min]
		,max([rhr_max]) AS [rhr_max]
		,sum([step_goal]) AS [step_goal]
		,sum([steps]) AS [steps]
		,sum([moderate_activity_time]) AS [moderate_activity_time]
		,sum([vigorous_activity_time]) AS [vigorous_activity_time]
		,sum([intensity_time_goal]) AS [intensity_time_goal]
		,sum([floors_up]) AS [floors_up]
		,sum([floors_down]) AS [floors_down]
		,sum([floors_goal]) AS [floors_goal]
		,avg([total_sleep]) AS [total_sleep_avg]
		,min([sleep_min]) AS [sleep_min]
		,max([sleep_max]) AS [sleep_max]
		,avg([deep_sleep]) AS [deep_sleep_avg]
		,avg([light_sleep]) AS [light_sleep_avg]
		,avg([rem_sleep]) AS [rem_sleep_avg]
		,avg([awake]) AS [awake_avg]
		,avg([stress_avg]) AS [stress_avg]
		,sum([distance]) AS [distance]
		,sum([calories_total]) AS [calories_total]
		,sum([calories_bmr]) AS [calories_bmr]
		,sum([calories_active]) AS [calories_active]
		,count([activities]) AS [activities]
		,sum([activities_calories]) AS [activities_calories]
		,sum([activities_distance_km]) AS [activities_distance_km]
		,sum([daily_distance_km]) AS [monthly_distance_km]
		,sum([sweat_loss]) AS [sweat_loss]
		,avg([spo2_avg]) AS [spo2_avg]
		,min([spo2_min]) AS [spo2_min]
		,avg([rr_avg_waking]) AS [rr_avg_waking]
		,max([rr_max]) AS [rr_max]
		,min([rr_min]) AS [rr_min]
		,avg([bb_charged]) AS [bb_charged]
		,max([bb_max]) AS [bb_max]
		,min([bb_min]) AS [bb_min]
		--,as [description]
	INTO #monthlysummary
	FROM [dbo].[DailySummary]
	GROUP BY convert(varchar(7), [DAY], 126) --month_num
	HAVING convert(varchar(7), [DAY], 126) >= convert(varchar(7), @CutOffDate, 126) --month_num >= month_num from CutOfDate

-- MERGE LATEST DATA WITH DAILY SUMMARY TABLE

MERGE INTO [dbo].[MonthlySummary] AS Target
USING #monthlysummary AS Source
ON Target.month_num = Source.month_num  

WHEN MATCHED THEN
    UPDATE SET
        Target.month_name = Source.month_name,
        Target.first_day = Source.first_day,
        Target.date_name = Source.date_name,
        Target.hr_min = Source.hr_min,
        Target.hr_max = Source.hr_max,
        Target.hr_avg = Source.hr_avg,
        Target.rhr = Source.rhr,
        Target.rhr_min = Source.rhr_min,
        Target.rhr_max = Source.rhr_max,
        Target.step_goal = Source.step_goal,
        Target.steps = Source.steps,
        Target.moderate_activity_time = Source.moderate_activity_time,
        Target.vigorous_activity_time = Source.vigorous_activity_time,
        Target.intensity_time_goal = Source.intensity_time_goal,
        Target.floors_up = Source.floors_up,
        Target.floors_down = Source.floors_down,
        Target.floors_goal = Source.floors_goal,
        Target.total_sleep_avg = Source.total_sleep_avg,
        Target.sleep_min = Source.sleep_min,
        Target.sleep_max = Source.sleep_max,
        Target.deep_sleep_avg = Source.deep_sleep_avg,
        Target.light_sleep_avg = Source.light_sleep_avg,
        Target.rem_sleep_avg = Source.rem_sleep_avg,
        Target.awake_avg = Source.awake_avg,
        Target.stress_avg = Source.stress_avg,
        Target.distance = Source.distance,
        Target.calories_total = Source.calories_total,
        Target.calories_bmr = Source.calories_bmr,
        Target.calories_active = Source.calories_active,
        Target.activities = Source.activities,
        Target.activities_calories = Source.activities_calories,
        Target.activities_distance_km = Source.activities_distance_km,
        Target.monthly_distance_km = Source.monthly_distance_km,
        Target.sweat_loss = Source.sweat_loss,
        Target.spo2_avg = Source.spo2_avg,
        Target.spo2_min = Source.spo2_min,
        Target.rr_avg_waking = Source.rr_avg_waking,
        Target.rr_max = Source.rr_max,
        Target.rr_min = Source.rr_min,
        Target.bb_charged = Source.bb_charged,
        Target.bb_max = Source.bb_max,
        Target.bb_min = Source.bb_min

WHEN NOT MATCHED THEN
    INSERT (month_num, month_name, first_day, date_name, hr_min, hr_max, hr_avg, rhr, rhr_min, rhr_max, step_goal, steps,
            moderate_activity_time, vigorous_activity_time, intensity_time_goal, floors_up, floors_down, floors_goal,
            total_sleep_avg, sleep_min, sleep_max, deep_sleep_avg, light_sleep_avg, rem_sleep_avg, awake_avg,
            stress_avg, distance, calories_total, calories_bmr, calories_active, activities, activities_calories,
            activities_distance_km, monthly_distance_km, sweat_loss, spo2_avg, spo2_min, rr_avg_waking, rr_max,
            rr_min, bb_charged, bb_max, bb_min)
    VALUES (Source.month_num, Source.month_name, Source.first_day, Source.date_name, Source.hr_min, Source.hr_max, Source.hr_avg,
            Source.rhr, Source.rhr_min, Source.rhr_max, Source.step_goal, Source.steps, Source.moderate_activity_time,
            Source.vigorous_activity_time, Source.intensity_time_goal, Source.floors_up, Source.floors_down,
            Source.floors_goal, Source.total_sleep_avg, Source.sleep_min, Source.sleep_max, Source.deep_sleep_avg,
            Source.light_sleep_avg, Source.rem_sleep_avg, Source.awake_avg, Source.stress_avg, Source.distance,
            Source.calories_total, Source.calories_bmr, Source.calories_active, Source.activities,
            Source.activities_calories, Source.activities_distance_km, Source.monthly_distance_km, Source.sweat_loss,
            Source.spo2_avg, Source.spo2_min, Source.rr_avg_waking, Source.rr_max, Source.rr_min, Source.bb_charged,
            Source.bb_max, Source.bb_min);


DROP TABLE #monthlysummary;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_IncrementalMergeWeeklyData] @CutOffDate DATE AS  

/*
exec [dbo].[p_IncrementalMergeWeeklyData] '2024-04-27'
*/


BEGIN
SET NOCOUNT ON

	SELECT 
		concat((year([day])),'-',format(datepart(ISO_WEEK, DATEADD(DAY, 0, ([DAY]))),'00')) AS [week_num]
		,min([day]) AS [first_day]
		,datename(weekday, min([day])) AS [date_name]
		,min([hr_min]) AS [hr_min]
		,max([hr_max]) AS [hr_max]
		,avg([hr_avg]) AS [hr_avg]
		,avg([rhr]) AS [rhr]
		,min([rhr_min]) AS [rhr_min]
		,max([rhr_max]) AS [rhr_max]
		,sum([step_goal]) AS [step_goal]
		,sum([steps]) AS [steps]
		,sum([moderate_activity_time]) AS [moderate_activity_time]
		,sum([vigorous_activity_time]) AS [vigorous_activity_time]
		,sum([intensity_time_goal]) AS [intensity_time_goal]
		,sum([floors_up]) AS [floors_up]
		,sum([floors_down]) AS [floors_down]
		,sum([floors_goal]) AS [floors_goal]
		,avg([total_sleep]) AS [total_sleep_avg]
		,min([sleep_min]) AS [sleep_min]
		,max([sleep_max]) AS [sleep_max]
		,avg([deep_sleep]) AS [deep_sleep_avg]
		,avg([light_sleep]) AS [light_sleep_avg]
		,avg([rem_sleep]) AS [rem_sleep_avg]
		,avg([awake]) AS [awake_avg]
		,avg([stress_avg]) AS [stress_avg]
		,sum([distance]) AS [distance]
		,sum([calories_total]) AS [calories_total]
		,sum([calories_bmr]) AS [calories_bmr]
		,sum([calories_active]) AS [calories_active]
		,count([activities]) AS [activities]
		,sum([activities_calories]) AS [activities_calories]
		,sum([activities_distance_km]) AS [activities_distance_km]
		,sum([daily_distance_km]) AS [monthly_distance_km]
		,sum([sweat_loss]) AS [sweat_loss]
		,avg([spo2_avg]) AS [spo2_avg]
		,min([spo2_min]) AS [spo2_min]
		,avg([rr_avg_waking]) AS [rr_avg_waking]
		,max([rr_max]) AS [rr_max]
		,min([rr_min]) AS [rr_min]
		,avg([bb_charged]) AS [bb_charged]
		,max([bb_max]) AS [bb_max]
		,min([bb_min]) AS [bb_min]
		--,as [description]
	INTO #weeklysummary
	FROM [dbo].[DailySummary] 
	GROUP BY concat((year([day])),'-',format(datepart(ISO_WEEK, DATEADD(DAY, 0, ([DAY]))),'00')) --week_num
	HAVING concat((year([day])),'-',format(datepart(ISO_WEEK, DATEADD(DAY, 0, ([DAY]))),'00')) 
		>= concat((year(@CutOffDate)),'-',format(datepart(ISO_WEEK, DATEADD(DAY, 0, (@CutOffDate))),'00')) --week_num >= week from CutOFDate


-- MERGE LATEST DATA WITH DAILY SUMMARY TABLE

MERGE INTO [dbo].[WeeklySummary] AS Target
USING #weeklysummary AS Source
ON Target.[week_num] = Source.[week_num]  

WHEN MATCHED THEN
    UPDATE SET
        Target.first_day = Source.first_day,
        Target.date_name = Source.date_name,
        Target.hr_min = Source.hr_min,
        Target.hr_max = Source.hr_max,
        Target.hr_avg = Source.hr_avg,
        Target.rhr = Source.rhr,
        Target.rhr_min = Source.rhr_min,
        Target.rhr_max = Source.rhr_max,
        Target.step_goal = Source.step_goal,
        Target.steps = Source.steps,
        Target.moderate_activity_time = Source.moderate_activity_time,
        Target.vigorous_activity_time = Source.vigorous_activity_time,
        Target.intensity_time_goal = Source.intensity_time_goal,
        Target.floors_up = Source.floors_up,
        Target.floors_down = Source.floors_down,
        Target.floors_goal = Source.floors_goal,
        Target.total_sleep_avg = Source.total_sleep_avg,
        Target.sleep_min = Source.sleep_min,
        Target.sleep_max = Source.sleep_max,
        Target.deep_sleep_avg = Source.deep_sleep_avg,
        Target.light_sleep_avg = Source.light_sleep_avg,
        Target.rem_sleep_avg = Source.rem_sleep_avg,
        Target.awake_avg = Source.awake_avg,
        Target.stress_avg = Source.stress_avg,
        Target.distance = Source.distance,
        Target.calories_total = Source.calories_total,
        Target.calories_bmr = Source.calories_bmr,
        Target.calories_active = Source.calories_active,
        Target.activities = Source.activities,
        Target.activities_calories = Source.activities_calories,
        Target.activities_distance_km = Source.activities_distance_km,
        Target.monthly_distance_km = Source.monthly_distance_km,
        Target.sweat_loss = Source.sweat_loss,
        Target.spo2_avg = Source.spo2_avg,
        Target.spo2_min = Source.spo2_min,
        Target.rr_avg_waking = Source.rr_avg_waking,
        Target.rr_max = Source.rr_max,
        Target.rr_min = Source.rr_min,
        Target.bb_charged = Source.bb_charged,
        Target.bb_max = Source.bb_max,
        Target.bb_min = Source.bb_min

WHEN NOT MATCHED THEN
    INSERT (week_num, first_day, date_name, hr_min, hr_max, hr_avg, rhr, rhr_min, rhr_max, step_goal, steps,
            moderate_activity_time, vigorous_activity_time, intensity_time_goal, floors_up, floors_down, floors_goal,
            total_sleep_avg, sleep_min, sleep_max, deep_sleep_avg, light_sleep_avg, rem_sleep_avg, awake_avg,
            stress_avg, distance, calories_total, calories_bmr, calories_active, activities, activities_calories,
            activities_distance_km, monthly_distance_km, sweat_loss, spo2_avg, spo2_min, rr_avg_waking, rr_max,
            rr_min, bb_charged, bb_max, bb_min)
    VALUES (Source.week_num, Source.first_day, Source.date_name, Source.hr_min, Source.hr_max, Source.hr_avg,
            Source.rhr, Source.rhr_min, Source.rhr_max, Source.step_goal, Source.steps, Source.moderate_activity_time,
            Source.vigorous_activity_time, Source.intensity_time_goal, Source.floors_up, Source.floors_down,
            Source.floors_goal, Source.total_sleep_avg, Source.sleep_min, Source.sleep_max, Source.deep_sleep_avg,
            Source.light_sleep_avg, Source.rem_sleep_avg, Source.awake_avg, Source.stress_avg, Source.distance,
            Source.calories_total, Source.calories_bmr, Source.calories_active, Source.activities,
            Source.activities_calories, Source.activities_distance_km, Source.monthly_distance_km, Source.sweat_loss,
            Source.spo2_avg, Source.spo2_min, Source.rr_avg_waking, Source.rr_max, Source.rr_min, Source.bb_charged,
            Source.bb_max, Source.bb_min);

DROP TABLE #weeklysummary;


END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_IncrementalMergeYearlyData] @CutOffDate DATE AS 

/*
EXEC [dbo].[p_IncrementalMergeYearlyData] '2024-04-27'
*/

BEGIN

	SELECT 
		datepart(year, [DAY]) AS [year]
		,min([day]) AS [first_day]
		,datename(weekday, min([day])) AS [date_name]
		,min([hr_min]) AS [hr_min]
		,max([hr_max]) AS [hr_max]
		,avg([hr_avg]) AS [hr_avg]
		,avg([rhr]) AS [rhr]
		,min([rhr_min]) AS [rhr_min]
		,max([rhr_max]) AS [rhr_max]
		,sum([step_goal]) AS [step_goal]
		,sum([steps]) AS [steps]
		,sum([moderate_activity_time]) AS [moderate_activity_time]
		,sum([vigorous_activity_time]) AS [vigorous_activity_time]
		,sum([intensity_time_goal]) AS [intensity_time_goal]
		,sum([floors_up]) AS [floors_up]
		,sum([floors_down]) AS [floors_down]
		,sum([floors_goal]) AS [floors_goal]
		,avg([total_sleep]) AS [total_sleep_avg]
		,min([sleep_min]) AS [sleep_min]
		,max([sleep_max]) AS [sleep_max]
		,avg([deep_sleep]) AS [deep_sleep_avg]
		,avg([light_sleep]) AS [light_sleep_avg]
		,avg([rem_sleep]) AS [rem_sleep_avg]
		,avg([awake]) AS [awake_avg]
		,avg([stress_avg]) AS [stress_avg]
		,sum([distance]) AS [distance]
		,sum([calories_total]) AS [calories_total]
		,sum([calories_bmr]) AS [calories_bmr]
		,sum([calories_active]) AS [calories_active]
		,count([activities]) AS [activities]
		,sum([activities_calories]) AS [activities_calories]
		,sum([activities_distance_km]) AS [activities_distance_km]
		,sum([daily_distance_km]) AS [monthly_distance_km]
		,sum([sweat_loss]) AS [sweat_loss]
		,avg([spo2_avg]) AS [spo2_avg]
		,min([spo2_min]) AS [spo2_min]
		,avg([rr_avg_waking]) AS [rr_avg_waking]
		,max([rr_max]) AS [rr_max]
		,min([rr_min]) AS [rr_min]
		,avg([bb_charged]) AS [bb_charged]
		,max([bb_max]) AS [bb_max]
		,min([bb_min]) AS [bb_min]
		--,as [description]
	INTO #yearlysummary
	FROM [dbo].[DailySummary]
	GROUP BY datepart(year, [DAY])
	HAVING datepart(year, [DAY]) >= datepart(year, @CutOffDate)

-- MERGE LATEST DATA WITH DAILY SUMMARY TABLE

MERGE INTO YearlySummary AS Target
USING #yearlysummary AS Source
ON Target.year = Source.year 

WHEN MATCHED THEN
    UPDATE SET
        Target.first_day = Source.first_day,
        Target.date_name = Source.date_name,
        Target.hr_min = Source.hr_min,
        Target.hr_max = Source.hr_max,
        Target.hr_avg = Source.hr_avg,
        Target.rhr = Source.rhr,
        Target.rhr_min = Source.rhr_min,
        Target.rhr_max = Source.rhr_max,
        Target.step_goal = Source.step_goal,
        Target.steps = Source.steps,
        Target.moderate_activity_time = Source.moderate_activity_time,
        Target.vigorous_activity_time = Source.vigorous_activity_time,
        Target.intensity_time_goal = Source.intensity_time_goal,
        Target.floors_up = Source.floors_up,
        Target.floors_down = Source.floors_down,
        Target.floors_goal = Source.floors_goal,
        Target.total_sleep_avg = Source.total_sleep_avg,
        Target.sleep_min = Source.sleep_min,
        Target.sleep_max = Source.sleep_max,
        Target.deep_sleep_avg = Source.deep_sleep_avg,
        Target.light_sleep_avg = Source.light_sleep_avg,
        Target.rem_sleep_avg = Source.rem_sleep_avg,
        Target.awake_avg = Source.awake_avg,
        Target.stress_avg = Source.stress_avg,
        Target.distance = Source.distance,
        Target.calories_total = Source.calories_total,
        Target.calories_bmr = Source.calories_bmr,
        Target.calories_active = Source.calories_active,
        Target.activities = Source.activities,
        Target.activities_calories = Source.activities_calories,
        Target.activities_distance_km = Source.activities_distance_km,
        Target.monthly_distance_km = Source.monthly_distance_km,
        Target.sweat_loss = Source.sweat_loss,
        Target.spo2_avg = Source.spo2_avg,
        Target.spo2_min = Source.spo2_min,
        Target.rr_avg_waking = Source.rr_avg_waking,
        Target.rr_max = Source.rr_max,
        Target.rr_min = Source.rr_min,
        Target.bb_charged = Source.bb_charged,
        Target.bb_max = Source.bb_max,
        Target.bb_min = Source.bb_min

WHEN NOT MATCHED THEN
    INSERT (year, first_day, date_name, hr_min, hr_max, hr_avg, rhr, rhr_min, rhr_max, step_goal, steps,
            moderate_activity_time, vigorous_activity_time, intensity_time_goal, floors_up, floors_down, floors_goal,
            total_sleep_avg, sleep_min, sleep_max, deep_sleep_avg, light_sleep_avg, rem_sleep_avg, awake_avg,
            stress_avg, distance, calories_total, calories_bmr, calories_active, activities, activities_calories,
            activities_distance_km, monthly_distance_km, sweat_loss, spo2_avg, spo2_min, rr_avg_waking, rr_max,
            rr_min, bb_charged, bb_max, bb_min)
    VALUES (Source.year, Source.first_day, Source.date_name, Source.hr_min, Source.hr_max, Source.hr_avg,
            Source.rhr, Source.rhr_min, Source.rhr_max, Source.step_goal, Source.steps, Source.moderate_activity_time,
            Source.vigorous_activity_time, Source.intensity_time_goal, Source.floors_up, Source.floors_down,
            Source.floors_goal, Source.total_sleep_avg, Source.sleep_min, Source.sleep_max, Source.deep_sleep_avg,
            Source.light_sleep_avg, Source.rem_sleep_avg, Source.awake_avg, Source.stress_avg, Source.distance,
            Source.calories_total, Source.calories_bmr, Source.calories_active, Source.activities,
            Source.activities_calories, Source.activities_distance_km, Source.monthly_distance_km, Source.sweat_loss,
            Source.spo2_avg, Source.spo2_min, Source.rr_avg_waking, Source.rr_max, Source.rr_min, Source.bb_charged,
            Source.bb_max, Source.bb_min);

DROP TABLE #yearlysummary

END


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[p_MasterDataLoad]	@FullLoad BIT
AS 

/*
exec [dbo].[p_MasterDataLoad] 0
	select top 100 * from [acc].[LogTable]
	select top 100 * from [dbo].[DailySummary]	 order by 1 desc
	select top 100 * from [dbo].[WeeklySummary]	 order by 1 desc
	select top 100 * from [dbo].[MonthlySummary] order by 1 desc
	select top 100 * from [dbo].[YearlySummary]	 order by 1 desc

Log file
11-08-2024 
	-- fixed:
		incremental merge, tested full load as well. Log table looks good.
		WEEKLY SUMMARY - first week of 2024 show as the last of 2023
		there was no 02-2023 weeks summary

24-07-2024
	- added incremental 100 year ago but month, weekly and yearly merge dont work

15-06-2024
	- It would be good to catch potential errors in e.x LogTable, instead of checking Load returned message

21-05-2024:
	- Full Load works fine
	- Added CutOffDate to Log Table
	- finished [dbo].[p_MergeSrcTables] 
	- Added indexes to src tables to improve loading, test load before and after indexes
*/

DECLARE @ProcessType NVARCHAR(100)


IF @FullLoad = 1 
BEGIN TRY

	/* ####### LOGGING PROCESS ####### */
	SET @ProcessType = 'Full Load'
	INSERT INTO [acc].[LogTable] (ProcessType, LoadStart, PriorCutOffDate, CutOffDate, Status)
    VALUES (@ProcessType, GETDATE(), (SELECT MIN([day]) FROM dbo.DailySummary), NULL, 'Started');

		/* ####### CREATE SOURCE VIEWS AND POPULATE SOURCE TABLES ####### */
			EXEC [dbo].[p_CreateSrcViews]
			EXEC [dbo].[p_PopulateSrcTables]
			EXEC [dbo].[p_CreateIndexesOnSourceTbls]

		/* ####### POPULATING SUMMARY TABLES ####### */
			EXEC [dbo].[p_PopulateDailySummaryTbl];
				DROP INDEX IF EXISTS IX_DailySummary_day ON [dbo].[DailySummary];
				CREATE CLUSTERED INDEX IX_DailySummary_day ON [dbo].[DailySummary] ([day]);

			EXEC [dbo].[p_PopulateWeeklySummaryTbl];
				DROP INDEX IF EXISTS IX_WeeklySummary_first_day ON [dbo].[WeeklySummary];
				CREATE CLUSTERED INDEX IX_WeeklySummary_first_day ON [dbo].[WeeklySummary] ([first_day]);

			EXEC [dbo].[p_PopulateMonthlySummaryTbl];
				DROP INDEX IF EXISTS IX_MonthlySummary_month_num ON [dbo].[MonthlySummary];
				CREATE CLUSTERED INDEX IX_MonthlySummary_month_num ON [dbo].[MonthlySummary] ([first_day]);

			EXEC [dbo].[p_PopulateYearlySummaryTbl];
				DROP INDEX IF EXISTS IX_YearlySummary_year ON [dbo].[YearlySummary];
				CREATE CLUSTERED INDEX IX_YearlySummary_year ON [dbo].[YearlySummary] ([year]);

		PRINT('Load process completed. Updating log table, time: '+convert(varchar, getdate(),120))
		UPDATE [acc].[LogTable]
		SET LoadEnd = GETDATE(), Status = 'Completed', CutOffDate = (SELECT MAX([day]) FROM dbo.DailySummary)
		WHERE ProcessType = @ProcessType
			AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);

END TRY
BEGIN CATCH
		PRINT ERROR_MESSAGE();
		UPDATE [acc].[LogTable]
		SET LoadEnd = NULL
			--,PriorCutOffDate = NULL
			,CutOffDate = NULL
			,Status = 'Error'
		WHERE ProcessType = @ProcessType
			AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);
END CATCH;

-- ################################# INCREMENTAL MERGE ########################################
IF @FullLoad = 0
BEGIN TRY

	DECLARE @CutOffDate DATE = (SELECT MAX(CutOffDate) FROM [acc].[LogTable] WHERE Status = 'Completed')
		IF @CutOffDate IS NULL 
			BEGIN
				PRINT (concat('No successfull load found. Executing Full Load: ',convert(varchar, getdate(),120)))
				EXEC [dbo].[p_MasterDataLoad] 1
			END
		ELSE 
/* ####### LOGGING PROCESS ####### */
	SET @ProcessType = 'Incremental Load'
	INSERT INTO [acc].[LogTable] (ProcessType, LoadStart, PriorCutOffDate, CutOffDate, Status)
    VALUES (@ProcessType, GETDATE(), (SELECT MAX([day]) FROM dbo.DailySummary), NULL, 'Started');

		--PRINT ('Merge Src tables')
		EXEC [dbo].[p_MergeSrcTables] @CutOffDate

		--PRINT ('Start merge daily table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeDailyData] @CutOffDate
	
		--PRINT ('Start merge weekly table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeWeeklyData] @CutOffDate

		--PRINT ('Start merge monthly table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeMonthlyData] @CutOffDate

		--PRINT ('Start merge yearly table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeYearlyData] @CutOffDate

	PRINT('Merge process completed. Updating log table, time: '+convert(varchar, getdate(),120))
	UPDATE [acc].[LogTable]
	SET LoadEnd = GETDATE(), Status = 'Completed', CutOffDate = (SELECT MAX([day]) FROM dbo.DailySummary)
	WHERE ProcessType = @ProcessType
		AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);
	
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE();
	UPDATE [acc].[LogTable]
	SET LoadEnd = NULL
		,CutOffDate = NULL
		,Status = 'Error'
	WHERE ProcessType = @ProcessType 
		AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);
END CATCH

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[p_MergeSrcTables] @CutOffDate DATE AS
BEGIN

--DECLARE @CutOffDate DATE = '2024-05-01'
DECLARE @SchemaName NVARCHAR(100)
	, @ViewName NVARCHAR(100)
	, @TableName NVARCHAR(100)
	, @PrimaryColumnName NVARCHAR(100)
	, @MergeType NVARCHAR(100)
	, @ColumnList NVARCHAR(MAX)
	, @UpdateColumnList NVARCHAR(MAX)
	, @MergeSQL NVARCHAR(MAX)
	, @TableColumnList NVARCHAR(MAX)
	, @MatchedColumnList NVARCHAR(MAX)

DECLARE view_cursor CURSOR FOR
	SELECT SchemaName, ViewName, TableName, PrimaryColumnName, MergeType
	FROM [acc].[SrcViewsConfig]
	WHERE IsActiveInd = 1
OPEN view_cursor
FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @TableName, @PrimaryColumnName, @MergeType

WHILE @@FETCH_STATUS = 0
BEGIN

	SET @ColumnList = (
		SELECT STRING_AGG(QUOTENAME(column_name), ', ' ) WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		)

	SET @TableColumnList = (
		SELECT STRING_AGG(CONCAT(QUOTENAME(column_name)
								,' '
								,DATA_TYPE
								,CASE WHEN DATA_TYPE = 'nvarchar' THEN '('+CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR)+')' END
			) , ', ' ) WITHIN GROUP (ORDER BY ORDINAL_POSITION ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		)

	SET @MatchedColumnList = (
		SELECT STRING_AGG(CONCAT('Target.', QUOTENAME(column_name),' = Source.',QUOTENAME(column_name)), ', ' ) WITHIN GROUP (ORDER BY ordinal_position ASC) 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		)

IF @MergeType = 'dynamic'
	BEGIN
		SET @MergeSQL = '
			DROP TABLE IF EXISTS #TempSrcData;

			CREATE TABLE #TempSrcData (' + @TableColumnList + ');
		
			INSERT INTO #TempSrcData 
			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+' 
			WHERE CAST('+ QUOTENAME(@PrimaryColumnName)+' AS DATE) >= @CutOffDate;

			MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
			USING #TempSrcData AS Source
				ON Target.' + QUOTENAME(@PrimaryColumnName) + ' = Source.' + QUOTENAME(@PrimaryColumnName) + '
			WHEN MATCHED THEN
			UPDATE 
			SET '+ @MatchedColumnList + '

			WHEN NOT MATCHED THEN
			INSERT (' + @ColumnList + ')
			VALUES (' + @ColumnList + ')
			;'
		print @MergeSQL
		EXEC sp_executesql @MergeSQL, N'@CutOffDate DATE', @CutOffDate
	END

/*
Manual merge for tables that dont have date columns. 
It's based on set substraction and inserting the difference
*/
IF @MergeType = 'manual'
	BEGIN

		SET @MergeSQL = '
			DROP TABLE IF EXISTS #TempSrcData;

			CREATE TABLE #TempSrcData (' + @TableColumnList + ');
		
			INSERT INTO #TempSrcData 

			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+' 
			EXCEPT
			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@TableName)+' 

			MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
			USING #TempSrcData AS Source
				ON Target.' + QUOTENAME(@PrimaryColumnName) + ' = Source.' + QUOTENAME(@PrimaryColumnName) + '
			WHEN MATCHED THEN
			UPDATE 
			SET '+ @MatchedColumnList + '

			WHEN NOT MATCHED THEN
			INSERT (' + @ColumnList + ')
			VALUES (' + @ColumnList + ')
			;'
		print @MergeSQL
		EXEC sp_executesql @MergeSQL

	END
/*
Exception. For this table primary key is a combination of 2 columns. Ugly solution but works.
*/
IF @MergeType = 'exception'
	BEGIN
		SET @MergeSQL = '
			DROP TABLE IF EXISTS #TempSrcData;

			CREATE TABLE #TempSrcData (' + @TableColumnList + ');
		
			INSERT INTO #TempSrcData 
			SELECT * FROM '+ QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+' 
			WHERE CAST('+ QUOTENAME(@PrimaryColumnName)+' AS DATE) >= @CutOffDate;

			MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
			USING #TempSrcData AS Source
				ON Target.' + QUOTENAME(@PrimaryColumnName) + ' = Source.' + QUOTENAME(@PrimaryColumnName) + 'AND Target.activity_type = Source.activity_type'
					+ '
			WHEN MATCHED THEN
			UPDATE 
			SET '+ @MatchedColumnList + '

			WHEN NOT MATCHED THEN
			INSERT (' + @ColumnList + ')
			VALUES (' + @ColumnList + ')
			;'
		print @MergeSQL
		EXEC sp_executesql @MergeSQL, N'@CutOffDate DATE', @CutOffDate
	END


	FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName, @TableName, @PrimaryColumnName, @MergeType
END

CLOSE view_cursor
DEALLOCATE view_cursor

END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateDailySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 1 - daily */
		drop table if exists [dbo].[DailySummary]
		select *
		into [dbo].[DailySummary]
		from [dbo].[vwTblDailySummary]
		
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateMonthlySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 3 - monthly */
		drop table if exists [dbo].[MonthlySummary]
		select *
		into [dbo].[MonthlySummary]
		from [dbo].[vwTblMonthlySummary]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_PopulateSrcTables] AS
/*
EXEC [dbo].[p_PopulateSrcTables]
*/

DECLARE @cursor CURSOR;
DECLARE @viewname NVARCHAR(100);
DECLARE @tablename NVARCHAR(100);
DECLARE @schemaname NVARCHAR(3);
BEGIN
	SET NOCOUNT ON
	SET @cursor = CURSOR FOR

	SELECT table_name AS viewname
		,SUBSTRING(table_name, 3, len(table_name)) AS tablename
		,TABLE_SCHEMA AS schemaname
	FROM INFORMATION_SCHEMA.VIEWS
	WHERE TABLE_SCHEMA IN ('src')

	OPEN @cursor

	FETCH NEXT
	FROM @cursor
	INTO @viewname, @tablename, @schemaname

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--select @viewname;
		--select @tablename;
		EXEC ('drop table if exists [' + @schemaname + '].[' + @tablename + ']');

		EXEC ('select * into [' + @schemaname + '].[' + @tablename + '] from [' + @schemaname + '].[' + @viewname + ']');

		FETCH NEXT
		FROM @cursor
		INTO @viewname
			,@tablename
			,@schemaname
	END;

	CLOSE @cursor;

	DEALLOCATE @cursor;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateWeeklySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 2 - weekly */
		drop table if exists [dbo].[WeeklySummary]
		select *
		into [dbo].[WeeklySummary]
		from [dbo].[vwTblWeeklySummary]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateYearlySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 4 - yearly */
		drop table if exists [dbo].[YearlySummary]
		select *
		into [dbo].[YearlySummary]
		from [dbo].[vwTblYearlySummary]
END
GO
