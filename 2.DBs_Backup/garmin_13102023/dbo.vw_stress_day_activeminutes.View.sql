USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_stress_day_activeminutes] as

/*
Data to analyse correlation between stress level and active minutes across days
*/


SELECT ds.day
	,datename(weekday,ds.day) as week_day
	,ds.stress_avg
	,ds.calories_active
	,ds.distance
	,datediff(minute, '00:00:00', ds.moderate_activity_time) AS moderate_activity_time
	,datediff(minute, '00:00:00', ds.vigorous_activity_time) AS vigorous_activity_time
	,ds.bb_charged
	,ds.bb_max
	,LEAD(ds.stress_avg,1) OVER (ORDER BY ds.[day] asc) as stress_next_day
	
FROM src.daily_summary ds
WHERE ds.day >= '2023-02-11'
GO
