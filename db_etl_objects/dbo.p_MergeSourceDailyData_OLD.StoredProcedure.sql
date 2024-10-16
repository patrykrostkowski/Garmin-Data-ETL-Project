USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MergeSourceDailyData_OLD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_MergeSourceDailyData_OLD]
AS
BEGIN

MERGE INTO [dbo].[DailySummary] AS target
USING ( 
	SELECT 
		[day],[date_name],[isweekend_ind],[hr_min],[hr_max],[hr_avg],[rhr],[rhr_min],[rhr_max],[step_goal],[steps],[moderate_activity_time],[vigorous_activity_time],[intensity_time_goal]
		,[floors_up],[floors_down],[floors_goal],[total_sleep],[sleep_min],[sleep_max],[deep_sleep],[light_sleep],[rem_sleep],[awake],[sleep_score],[qualifier],[next_day_total_sleep]
		,[next_day_deep_sleep],[next_day_light_sleep],[next_day_rem_sleep],[next_day_awake],[next_day_sleep_score],[next_day_qualifier],[stress_avg],[distance],[calories_total]
		,[calories_bmr],[calories_active],[activities],[activities_calories],[activities_distance_km],[daily_distance_km],[hydration_goal],[hydration_intake],[sweat_loss]
		,[spo2_avg],[spo2_min],[rr_avg_waking],[rr_max],[rr_min],[bb_charged],[bb_max],[bb_min],[description]	
	FROM [dbo].[vwTblDailySummary] 
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


END
GO
