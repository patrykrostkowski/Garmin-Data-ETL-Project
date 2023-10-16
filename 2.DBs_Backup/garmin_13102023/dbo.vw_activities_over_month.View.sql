USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE view [dbo].[vw_activities_over_month] as 

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
	FROM [garmin_activities].[src].[activities] act
	WHERE act.sport not like 'unknown%' 
	GROUP BY 
		cast(DATEADD(month, datediff(month,0,act.start_time),0) as date)
		,act.sport
		,act.sub_sport
	) tbl
JOIN [garmin_summary].[src].[months_summary] gsm ON gsm.first_day = tbl.first_day
WHERE sum_elapsed_time <> 0
GO
