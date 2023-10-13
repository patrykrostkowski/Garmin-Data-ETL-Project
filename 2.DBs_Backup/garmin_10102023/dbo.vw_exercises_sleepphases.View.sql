USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_exercises_sleepphases] as 

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
from [garmin].[src].[sleep] sp

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
		FROM [src].[sleep_events]
		) AS tmp
	PIVOT(COUNT(phase_duration) FOR [event] IN (
				[awake]
				,[deep_sleep]
				,[light_sleep]
				,[rem_sleep]
				)) AS pivot_table
	) AS se ON se.DATE = sp.day

/* join to get activities details from previous day */
LEFT JOIN [garmin_activities].[src].[activities] a ON cast([start_time] as date) = dateadd(day,-1,sp.day)

where 1=1
	and sp.start is not null	/*only records with sleep data*/
GO
