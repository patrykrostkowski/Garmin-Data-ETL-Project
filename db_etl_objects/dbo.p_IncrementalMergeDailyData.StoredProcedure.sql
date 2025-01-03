USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMergeDailyData]
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
