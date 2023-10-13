USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vw_tbl_daily_summary] as 

/*
	This summary is created for training purpose. It contains the same details as in already existed table but calculated manually.
	It collects data from 
			[garmin], 
			[garmin_activities] and 
			[garmin_monitoring] servers.
	I'm gonna use it further as a base table.
*/

with cte_rhr as (
	SELECT [day]
		,min(moving_avg) AS resting_heart_rate
	FROM (
		SELECT cast(TIMESTAMP AS DATE) AS [day]
			,avg(heart_rate) OVER (ORDER BY TIMESTAMP rows BETWEEN 30 preceding	AND CURRENT row) AS moving_avg
		FROM [garmin_monitoring].[src].[monitoring_hr]
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
	FROM [garmin_monitoring].[src].[monitoring_hr]
	WHERE cast(TIMESTAMP AS DATE) >= '2023-02-11'
	GROUP BY cast(TIMESTAMP AS DATE)
	--ORDER BY day
)

,cte_stress as (
	SELECT cast(s.TIMESTAMP AS DATE) AS day
		,avg(s.stress) AS avg_stress
	FROM [garmin].[src].[stress] s
	WHERE s.stress > 0
	GROUP BY cast(TIMESTAMP AS DATE)
	--ORDER BY day
	)

,cte_activity_time as (
	SELECT cast(TIMESTAMP AS DATE) AS day
		,sum(datediff(minute, '00:00:00:00', moderate_activity_time)) AS moderate_activity_time
		,sum(datediff(minute, '00:00:00:00', vigorous_activity_time)) AS vigorous_activity_time
	FROM [garmin_monitoring].[src].[monitoring_intensity]
	GROUP BY cast(TIMESTAMP AS DATE)
	)

,cte_steps as (
	SELECT cast(mt.TIMESTAMP AS DATE) AS day
		,round(sum(mt.distance) / 1000, 2) AS distance_km
		,sum(mt.steps) AS steps
	FROM [garmin_monitoring].[src].[monitoring] mt
	WHERE 1 = 1
		AND cast(mt.TIMESTAMP AS TIME) = '23:59:59' -- because values sums cummulative
		AND mt.activity_type NOT IN ('generic','stop_disable')
	GROUP BY cast(mt.TIMESTAMP AS DATE), mt.TIMESTAMP
-- need to create recursive cte for step goal



	)

,cte_floors as (
	SELECT cast(TIMESTAMP AS DATE) AS day
		,round(sum(ascent)/3, 2) AS floors_up
		,round(sum(descent)/3, 2) AS floors_down
	FROM [garmin_monitoring].[src].[monitoring_climb]
	GROUP BY cast(TIMESTAMP AS DATE)
	--ORDER BY cast(TIMESTAMP AS DATE)
	)

,cte_calories as (
	SELECT cast(mt.TIMESTAMP AS DATE) AS day
		,sum(mt.active_calories) AS calories_active
		,(SELECT TOP 1 mm.resting_metabolic_rate
			FROM [garmin_monitoring].[src].[monitoring_info] mm
			WHERE cast(mt.TIMESTAMP AS DATE) = cast(mm.TIMESTAMP AS DATE)
			) AS calories_bmr
		,sum(mt.active_calories) + (
			SELECT TOP 1 mm.resting_metabolic_rate
			FROM [garmin_monitoring].[src].[monitoring_info] mm
			WHERE cast(mt.TIMESTAMP AS DATE) = cast(mm.TIMESTAMP AS DATE)
			) AS calories_total
	FROM [garmin_monitoring].[src].[monitoring] mt
	WHERE 1 = 1
		AND cast(mt.TIMESTAMP AS TIME) = '23:59:59' -- because values sums cummulative
		AND mt.activity_type NOT IN ('stop_disable')
	GROUP BY cast(mt.TIMESTAMP AS DATE), mt.TIMESTAMP
	)

,cte_respiratory_rate as (
	select 
		cast(rr.timestamp as date) as day
		,min(rr.rr) as rr_max
		,min(rr.rr) as rr_min
		,(
			SELECT ROUND(avg(rr2.rr),2) 
			FROM [garmin_monitoring].[src].[monitoring_rr] rr2
			JOIN [garmin_monitoring].[src].[monitoring] mt2 on mt2.timestamp = rr2.timestamp 
					and mt2.activity_type = 'walking'
			WHERE CAST(rr2.timestamp as date) = CAST(rr.timestamp as date)
			GROUP BY cast(rr2.timestamp as date)
		) as rr_avg_waking
	FROM [garmin_monitoring].[src].[monitoring_rr] rr
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
		from [garmin].[src].[sleep]
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
	from [garmin_monitoring].[src].[monitoring] mtr
	LEFT JOIN 
		(select 
			cast(act.start_time as date) as day
			,count(act.sport) as activity_count
			,sum(act.calories) as activity_calories
			,sum(act.distance) as activity_distance
			--,sum(mtr.daily_distance) as daily_distance --including steps
		from [garmin_activities].[src].[activities] act
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
	--,[step_goal]
	,case 
		when cte_steps.day = '2023-02-11' then 7500 

		--yesterday goal < 7500, not met
		when cte_steps.steps < lag(cte_steps.steps,1) over(order by cte_steps.day)
			and lag(cte_steps.steps,1) over(order by cte_steps.day) < 7500 then '1'

		--yesterday goal < 7500, met
		when cte_steps.steps > lag(cte_steps.steps,1) over(order by cte_steps.day) 
			and lag(cte_steps.steps,1) over(order by cte_steps.day) < 7500 then '2'

		--yesterday goal between 7500 and 10k, not met
		when cte_steps.steps < lag(cte_steps.steps,1) over(order by cte_steps.day) 
			and lag(cte_steps.steps,1) over(order by cte_steps.day) between 7500 and 10000 then '3'

		--yesterday goal between 7500 and 10k, met
		when cte_steps.steps > lag(cte_steps.steps,1) over(order by cte_steps.day) 
			and lag(cte_steps.steps,1) over(order by cte_steps.day) between 7500 and 10000 then '4'
		
		--yesterday goal > 10000, not met
		when cte_steps.steps < lag(cte_steps.steps,1) over(order by cte_steps.day) 
			and lag(cte_steps.steps,1) over(order by cte_steps.day) < 10000 then '5'
		
		--yesterday goal > 10000, met
		when cte_steps.steps > lag(cte_steps.steps,1) over(order by cte_steps.day) 
			and lag(cte_steps.steps,1) over(order by cte_steps.day) < 10000 then '6'


	END AS step_goal_mine
/* garmin step goal algorithm -> https://www.ukentry.com/garmin-steps-auto-goal-how-it-works.html
	In summary, first day is set up manually - 7500 in my case on 2023-02-11. 
	The next day's Garmin auto-goal for steps is increased as follows:

	Goal < 7,500 steps: add 25% of the excess, 6% max
	Goal 7,500 to 10,000 steps: add 15% of the excess, 4% max
	Goal > 10,000 steps: add 5% of the excess, 2% max

	When you do not reach your step goal for one day, 5% of the number of steps by which you missed it is deducted from your goal for the next day. 
	For subsequent days, 35% of the number of steps by which you miss the goal is deducted. 
	The maximum changes are 5% in a day for goals less than 10,000 steps and 7.5% for goals more than that.
*/
	,dsm.step_goal
	,cte_steps.steps
	,COALESCE(cte_activity_time.moderate_activity_time,0) AS moderate_activity_time
	,COALESCE(cte_activity_time.vigorous_activity_time,0) AS vigorous_activity_time
	,ROUND(250/7,2) as intensity_time_goal --set as constant value 
	,cte_floors.floors_up --based on internal barometer to measure elevation changes as you climb floors. A floor climbed is equal to 3m 
	,cte_floors.floors_down
	,10 as floors_goal --set as constant value 
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
	--,NULL AS calories_goal
	,cal.calories_total
	,cal.calories_bmr
	,cal.calories_active
	--,NULL AS calories_consumed
	,act.activity_count as activities
	,act.activity_calories as activities_calories
	,act.activity_distance as activities_distance_km
	,act.daily_distance as daily_distance_km
	--,ds.hydration_goal AS [hydration_goal]
	--,ds.hydration_intake AS [hydration_intake]
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
JOIN cte_hr ON cte_hr.day								= rhr.day
left JOIN cte_stress ON cte_stress.day					= rhr.day
LEFT JOIN cte_activity_time on cte_activity_time.day	= rhr.day
LEFT JOIN cte_steps ON cte_steps.day					= rhr.day
LEFT JOIN cte_floors ON cte_floors.day					= rhr.day
LEFT JOIN cte_sleep ON cte_sleep.day					= rhr.day
JOIN cte_calories cal on cal.day						= rhr.day
JOIN cte_respiratory_rate ON cte_respiratory_rate.day	= rhr.day
JOIN garmin.src.daily_summary dsm ON dsm.day			= rhr.day
LEFT JOIN cte_activity_count act ON act.day				= rhr.day
--order by cte_rhr.[day]

GO
