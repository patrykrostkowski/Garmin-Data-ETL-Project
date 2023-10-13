USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_steps_over_hour] as

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
	FROM [garmin_monitoring].[src].[monitoring] 
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
	FROM [garmin_monitoring].[src].[monitoring] 
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
