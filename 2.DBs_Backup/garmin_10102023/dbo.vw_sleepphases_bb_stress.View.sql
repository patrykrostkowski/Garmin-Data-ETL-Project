USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_sleepphases_bb_stress] as 

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

FROM [garmin].[src].[daily_summary] ds
left JOIN [garmin].[src].[sleep] sp ON sp.day = ds.day
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
			from [garmin].[src].[stress]
			where stress > 0 and cast(timestamp as time) between '06:00:00' and '22:00:00'
			group by timestamp--,CAST(timestamp as date)
			) st
	group by st.day
) stt ON stt.day = ds.day

WHERE 1 = 1
	AND ds.[day] >= '2023-02-11' -- watch bought date
	AND sp.qualifier IS NOT NULL

GO
