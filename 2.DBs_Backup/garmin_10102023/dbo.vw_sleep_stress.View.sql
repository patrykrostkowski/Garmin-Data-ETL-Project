USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_sleep_stress] AS

/*
This view selects health and sleep daily data to analyse correlation and impact exercises 
to sleep and stress
*/


SELECT ds.[day] AS [Date]
	,ds.[hr_min]
	,ds.[hr_max]
	,ds.[rhr] AS hr_rest
	,ds.[stress_avg]
	,ds.[steps]
	,ds.[step_goal]
	,datediff(minute, '00:00:00', ds.moderate_activity_time) AS moderate_activity_time
	,datediff(minute, '00:00:00', ds.vigorous_activity_time) AS vigorous_activity_time
	--,datediff(minute,'00:00:00',ds.[intensity_time_goal]) -- this is for week summary, not days
	,ds.[rr_max] AS respiratory_rate_max
	,ds.[rr_waking_avg] AS respiratory_rate_min
	,datediff(minute, '00:00:00', sp.[total_sleep]) AS total_sleep
	,datediff(minute, '00:00:00', sp.[deep_sleep]) AS deep_sleep
	,datediff(minute, '00:00:00', sp.[light_sleep]) AS light_sleep
	,datediff(minute, '00:00:00', sp.[rem_sleep]) AS rem_sleep
	,datediff(minute, '00:00:00', sp.[awake]) AS awake
	,sp.[avg_rr]
	,sp.[avg_stress]
	,sp.[score]
	,sp.[qualifier]
--,pt.[deep_sleep] AS [pt_deep_sleep]
FROM [src].[daily_summary] ds
JOIN [src].[sleep] sp ON sp.day = ds.day
/* JOIN sleep_events table to check if sleep phases duration matches the daily summary.
LEFT JOIN (
	SELECT *
	FROM (
		SELECT CASE 
				WHEN DATEPART(hour, TIMESTAMP) >= 20
					THEN cast(dateadd(day, 1, TIMESTAMP) AS DATE)
				ELSE cast(TIMESTAMP AS DATE)
				END AS DATE
			,event
			,datediff(minute, '0:00:00', duration) AS phase_duration
		FROM [src].[sleep_events]
		) AS tmp
	PIVOT(sum(phase_duration) FOR [event] IN (
				[awake]
				,[deep_sleep]
				,[light_sleep]
				,[rem_sleep]
				)) AS pivot_table
	) AS pt ON pt.DATE = ds.day
*/
WHERE 1 = 1
	AND ds.[day] >= '2023-02-11' -- watch bought date
	AND sp.qualifier IS NOT NULL
GO
