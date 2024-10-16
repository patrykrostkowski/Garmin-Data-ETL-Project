USE [garmin]
GO
DROP VIEW IF EXISTS [dbo].[vwActivityLocMap]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[vwActivityLocMap] as 

SELECT 
	act.activity_id AS activity_id,
	COALESCE(act.name,'Kardio') AS name,
	acl.lap,
	act.start_time AS start_time,
	act.stop_time AS stop_time,
	act.elapsed_time AS elapsed_time,
	ROUND(act.distance, 1) AS distance,
	--activities.avg_hr AS avg_hr,
	--activities.max_hr AS max_hr,
	--activities.calories AS calories,
	--ROUND(activities.avg_temperature, 1) AS avg_temperature,
	--activities.avg_cadence AS avg_rpms,
	--activities.max_cadence AS max_rpms,
	--ROUND(activities.avg_speed, 1) AS avg_speed,
	--ROUND(activities.max_speed, 1) AS max_speed,
	--activities.hrz_1_time AS heart_rate_zone_one_time,
	--activities.hrz_2_time AS heart_rate_zone_two_time,
	--activities.hrz_3_time AS heart_rate_zone_three_time,
	--activities.hrz_4_time AS heart_rate_zone_four_time,
	--activities.hrz_5_time AS heart_rate_zone_five_time,
	CASE WHEN act.start_lat IS NULL 
		THEN 'N/A'
		ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', act.start_lat, ',', act.start_long, '&z=13') 
		END AS start_loc,
	CASE WHEN act.stop_lat IS NULL 
		THEN 'N/A'
		ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', act.stop_lat, ',', act.stop_long, '&z=13') 
		END AS stop_loc
FROM [src].[GarminActivities/Activities] act
JOIN [src].[GarminActivities/ActivityRecords] acr ON act.activity_id = acr.activity_id
JOIN [src].[GarminActivities/ActivityLaps] acl ON act.activity_id = acl.activity_id
GO
