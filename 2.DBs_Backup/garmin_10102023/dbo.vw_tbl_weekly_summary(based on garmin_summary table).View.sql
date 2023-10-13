USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_tbl_weekly_summary(based on garmin_summary table)] as 


-- weekly summary based from daily
SELECT 
	datepart(week, DATEADD(DAY, -1, [DAY])) AS [week_num]
	,min([day]) AS [first_day]
	,datename(weekday, min([day])) AS [date_name]
	,round(avg([hr_avg]),2) AS [hr_avg]
	,min([hr_min]) AS [hr_min]
	,max([hr_max]) AS [hr_max]
	,round(avg([rhr_avg]),2) AS [rhr_avg]
	,min([rhr_min]) AS [rhr_min]
	,max([rhr_max]) AS [rhr_max]
	,round(avg([inactive_hr_avg]),2) AS [inactive_hr_avg]
	,min([inactive_hr_min]) AS [inactive_hr_min]
	,max([inactive_hr_max]) AS [inactive_hr_max]
	--,[weight_avg]
	--,[weight_min]
	--,[weight_max]
	,round(avg(datediff(minute, '00:00:00', [intensity_time])			),2)	AS [intensity_time]
	,round(avg(datediff(minute, '00:00:00', [moderate_activity_time])	),2)	AS [moderate_activity_time]
	,round(avg(datediff(minute, '00:00:00', [vigorous_activity_time])	),2)	AS [vigorous_activity_time]
	,round(avg(datediff(minute, '00:00:00', [intensity_time_goal])		),2)	AS [intensity_time_goal]
	,sum([steps]) AS [steps]
	,sum([steps_goal]) AS [steps_goal]
	,round(sum([floors]),2) AS [floors]
	,sum([floors_goal]) AS [floors_goal]
	,round(avg(datediff(minute, '00:00:00', [sleep_avg])),2) AS [sleep_avg]
	,min(datediff(minute, '00:00:00', [sleep_min])) AS [sleep_min]
	,max(datediff(minute, '00:00:00', [sleep_max])) AS [sleep_max]
	,avg(datediff(minute, '00:00:00', [rem_sleep_avg])) AS [rem_sleep_avg]
	,min(datediff(minute, '00:00:00', [rem_sleep_min])) AS [rem_sleep_min]
	,max(datediff(minute, '00:00:00', [rem_sleep_max])) AS [rem_sleep_max]
	,avg([stress_avg]) AS [stress_avg]
	,avg([calories_avg]) AS [calories_avg]
	,avg([calories_bmr_avg]) AS [calories_bmr_avg]
	,avg([calories_active_avg]) AS [calories_active_avg]
	--,[calories_goal]
	--,[calories_consumed_avg]
	,sum([activities]) AS [activities]
	,sum([activities_calories]) AS [activities_calories]
	,sum([activities_distance]) AS [activities_distance_km]
	--,[hydration_goal]
	--,[hydration_avg]
	--,[hydration_intake]
	--,[sweat_loss_avg]
	,sum([sweat_loss]) AS [sweat_loss]
	,avg([spo2_avg]) as [spo2_avg]
	,min([spo2_min]) as [spo2_min]
	,round(avg([rr_waking_avg]),2) AS [rr_waking_avg]
	,max([rr_max]) AS [rr_max]
	,min([rr_min]) AS [rr_min]
	,max([bb_max]) AS [bb_max]
	,min([bb_min]) AS [bb_min]
--,avg(dsm.bb_charged ) as [avg_bb_charged]		 --idea to add body battery charged
--,max(dsm.bb_charged ) as [avg_bb_charged]		 --idea to add body battery charged
FROM [garmin_summary].[src].[days_summary] gsd
GROUP BY datepart(week, DATEADD(DAY, -1, [DAY]))
GO
