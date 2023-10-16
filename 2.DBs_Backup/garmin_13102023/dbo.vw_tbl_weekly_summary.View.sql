USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_tbl_weekly_summary] as 

SELECT 
	datepart(week, DATEADD(DAY, - 1, [DAY])) AS [week_num]
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
FROM [garmin].[dbo].[daily_summary]
GROUP BY datepart(week, DATEADD(DAY, - 1, [DAY]))
GO
