USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_activity_loc_map] as 

SELECT 
	activities.activity_id AS activity_id,
	COALESCE(activities.name,'Kardio') AS name,
	activity_laps.lap,
	activities.start_time AS start_time,
	activities.stop_time AS stop_time,
	activities.elapsed_time AS elapsed_time,
	ROUND(activities.distance, 1) AS distance,
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
	CASE WHEN activities.start_lat IS NULL 
		THEN 'N/A'
		ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', activities.start_lat, ',', activities.start_long, '&z=13') 
		END AS start_loc,
	CASE WHEN activities.stop_lat IS NULL 
		THEN 'N/A'
		ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', activities.stop_lat, ',', activities.stop_long, '&z=13') 
		END AS stop_loc
FROM [garmin_activities].src.activities
JOIN [garmin_activities].src.activity_records ON activities.activity_id = activity_records.activity_id
JOIN [garmin_activities].src.activity_laps ON activities.activity_id = activity_laps.activity_id
GO
