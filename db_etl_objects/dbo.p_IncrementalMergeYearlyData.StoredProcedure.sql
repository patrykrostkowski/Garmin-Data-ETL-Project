USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMergeYearlyData]
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
