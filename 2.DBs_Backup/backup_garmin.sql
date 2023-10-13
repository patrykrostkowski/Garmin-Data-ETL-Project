USE [master]
GO
/****** Object:  Database [garmin]    Script Date: 09.10.2023 11:45:06 ******/
CREATE DATABASE [garmin]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'garmin', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'garmin_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [garmin] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [garmin].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [garmin] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [garmin] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [garmin] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [garmin] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [garmin] SET ARITHABORT OFF 
GO
ALTER DATABASE [garmin] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [garmin] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [garmin] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [garmin] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [garmin] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [garmin] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [garmin] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [garmin] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [garmin] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [garmin] SET  DISABLE_BROKER 
GO
ALTER DATABASE [garmin] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [garmin] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [garmin] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [garmin] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [garmin] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [garmin] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [garmin] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [garmin] SET RECOVERY FULL 
GO
ALTER DATABASE [garmin] SET  MULTI_USER 
GO
ALTER DATABASE [garmin] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [garmin] SET DB_CHAINING OFF 
GO
ALTER DATABASE [garmin] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [garmin] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [garmin] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [garmin] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'garmin', N'ON'
GO
ALTER DATABASE [garmin] SET QUERY_STORE = OFF
GO
USE [garmin]
GO
/****** Object:  User [test_login]    Script Date: 09.10.2023 11:45:06 ******/
CREATE USER [test_login] FOR LOGIN [test_login] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [test_login]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [test_login]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [test_login]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [test_login]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [test_login]
GO
ALTER ROLE [db_datareader] ADD MEMBER [test_login]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [test_login]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [test_login]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [test_login]
GO
/****** Object:  Schema [garmin]    Script Date: 09.10.2023 11:45:06 ******/
CREATE SCHEMA [garmin]
GO
/****** Object:  Schema [src]    Script Date: 09.10.2023 11:45:06 ******/
CREATE SCHEMA [src]
GO
/****** Object:  Table [src].[daily_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[daily_summary](
	[day] [date] NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[rhr] [int] NULL,
	[stress_avg] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [float] NULL,
	[distance] [float] NULL,
	[calories_goal] [int] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[calories_consumed] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL,
	[description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[sleep]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[sleep](
	[day] [date] NULL,
	[start] [datetime2](7) NULL,
	[end] [datetime2](7) NULL,
	[total_sleep] [time](0) NULL,
	[deep_sleep] [time](0) NULL,
	[light_sleep] [time](0) NULL,
	[rem_sleep] [time](0) NULL,
	[awake] [time](0) NULL,
	[avg_spo2] [float] NULL,
	[avg_rr] [float] NULL,
	[avg_stress] [float] NULL,
	[score] [int] NULL,
	[qualifier] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[stress]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[stress](
	[timestamp] [datetime2](7) NULL,
	[stress] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_tbl_daily_summary]    Script Date: 09.10.2023 11:45:06 ******/
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
		,case when next_day_qualifier is null then 0
			when next_day_qualifier = 'POOR' then 25
			when next_day_qualifier = 'FAIR' then 50
			when next_day_qualifier = 'GOOD' then 75
		else 100
		end as sleep_next_day_qualifier
	from (
		select 
			*
			,lead(total_sleep ,1)	over (order by day) as next_day_total_sleep
			,lead(deep_sleep  ,1)	over (order by day) as next_day_deep_sleep 
			,lead(light_sleep ,1)	over (order by day) as next_day_light_sleep
			,lead(rem_sleep	  ,1)	over (order by day) as next_day_rem_sleep	 
			,lead(awake		  ,1)	over (order by day) as next_day_awake		
			,lead(qualifier	  ,1)	over (order by day) as next_day_qualifier
		from (
			select 
				day
				,datediff(minute, '00:00:00',total_sleep	) as total_sleep
				,datediff(minute, '00:00:00',deep_sleep		) as deep_sleep	
				,datediff(minute, '00:00:00',light_sleep	) as light_sleep
				,datediff(minute, '00:00:00',rem_sleep		) as rem_sleep	
				,datediff(minute, '00:00:00',awake			) as awake		
				,qualifier
				,case when qualifier is null then 0
					when qualifier = 'POOR' then 25
					when qualifier = 'FAIR' then 50
					when qualifier = 'GOOD' then 75
				else 100
				end as sleep_qualifier
			from [garmin].[src].[sleep]
			where [end] is not null
			) tbl
		) tbl2
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
	,cte_sleep.qualifier
	,cte_sleep.next_day_total_sleep
	,cte_sleep.next_day_deep_sleep 
	,cte_sleep.next_day_light_sleep
	,cte_sleep.next_day_rem_sleep	
	,cte_sleep.next_day_awake	
	,cte_sleep.next_day_qualifier
	,cte_sleep.sleep_next_day_qualifier
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
/****** Object:  View [dbo].[vw_sleep_stress]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  View [dbo].[vw_stress_day_activeminutes]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  Table [src].[sleep_events]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[sleep_events](
	[timestamp] [datetime2](7) NULL,
	[event] [nvarchar](255) NULL,
	[duration] [time](0) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_exercises_sleepphases]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  Table [dbo].[daily_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daily_summary](
	[day] [date] NULL,
	[date_name] [nvarchar](30) NULL,
	[isweekend_ind] [int] NOT NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[hr_avg] [int] NULL,
	[rhr] [int] NULL,
	[rhr_min] [int] NULL,
	[rhr_max] [int] NULL,
	[step_goal_mine] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [int] NULL,
	[vigorous_activity_time] [int] NULL,
	[intensity_time_goal] [int] NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [int] NOT NULL,
	[total_sleep] [int] NULL,
	[sleep_min] [int] NULL,
	[sleep_max] [int] NULL,
	[deep_sleep] [int] NULL,
	[light_sleep] [int] NULL,
	[rem_sleep] [int] NULL,
	[awake] [int] NULL,
	[qualifier] [nvarchar](255) NULL,
	[next_day_total_sleep] [int] NULL,
	[next_day_deep_sleep] [int] NULL,
	[next_day_light_sleep] [int] NULL,
	[next_day_rem_sleep] [int] NULL,
	[next_day_awake] [int] NULL,
	[next_day_qualifier] [nvarchar](255) NULL,
	[sleep_next_day_qualifier] [int] NULL,
	[stress_avg] [int] NULL,
	[distance] [float] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance_km] [float] NULL,
	[daily_distance_km] [float] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_avg_waking] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL,
	[description] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_tbl_weekly_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_tbl_weekly_summary] as 

SELECT 
	datepart(week, DATEADD(DAY, - 1, [DAY])) AS [week_num]
	,min([day]) AS [first_day]
	,datename(weekday, min([day])) AS [date_name]
	,min([hr_min]) AS [hr_min]
	,max([hr_max]) AS [hr_max]
	,avg([hr_avg]) AS [hr_avg]
	,avg([rhr]) AS [rhr]
	,min([rhr_min]) AS [rhr_min]
	,max([rhr_max]) AS [rhr_max]
	,sum([step_goal]) AS [step_goal]
	,sum([steps]) AS [steps]
	,sum([moderate_activity_time]) AS [moderate_activity_time]
	,sum([vigorous_activity_time]) AS [vigorous_activity_time]
	,sum([intensity_time_goal]) AS [intensity_time_goal]
	,sum([floors_up]) AS [floors_up]
	,sum([floors_down]) AS [floors_down]
	,sum([floors_goal]) AS [floors_goal]
	,avg([total_sleep]) AS [total_sleep_avg]
	,min([sleep_min]) AS [sleep_min]
	,max([sleep_max]) AS [sleep_max]
	,avg([deep_sleep]) AS [deep_sleep_avg]
	,avg([light_sleep]) AS [light_sleep_avg]
	,avg([rem_sleep]) AS [rem_sleep_avg]
	,avg([awake]) AS [awake_avg]
	,avg([stress_avg]) AS [stress_avg]
	,sum([distance]) AS [distance]
	,sum([calories_total]) AS [calories_total]
	,sum([calories_bmr]) AS [calories_bmr]
	,sum([calories_active]) AS [calories_active]
	,count([activities]) AS [activities]
	,sum([activities_calories]) AS [activities_calories]
	,sum([activities_distance_km]) AS [activities_distance_km]
	,sum([daily_distance_km]) AS [monthly_distance_km]
	,sum([sweat_loss]) AS [sweat_loss]
	,avg([spo2_avg]) AS [spo2_avg]
	,min([spo2_min]) AS [spo2_min]
	,avg([rr_avg_waking]) AS [rr_avg_waking]
	,max([rr_max]) AS [rr_max]
	,min([rr_min]) AS [rr_min]
	,avg([bb_charged]) AS [bb_charged]
	,max([bb_max]) AS [bb_max]
	,min([bb_min]) AS [bb_min]
--,as [description]
FROM [garmin].[dbo].[daily_summary]
GROUP BY datepart(week, DATEADD(DAY, - 1, [DAY]))
GO
/****** Object:  View [dbo].[vw_tbl_monthly_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_tbl_monthly_summary] as 

SELECT 
	concat(datepart(year, [DAY]),'/',datepart(month, [DAY] /*DATEADD(DAY, - 1, [DAY])*/)) AS [month_num]
	,min([day]) AS [first_day]
	,datename(weekday, min([day])) AS [date_name]
	,min([hr_min]) AS [hr_min]
	,max([hr_max]) AS [hr_max]
	,avg([hr_avg]) AS [hr_avg]
	,avg([rhr]) AS [rhr]
	,min([rhr_min]) AS [rhr_min]
	,max([rhr_max]) AS [rhr_max]
	,sum([step_goal]) AS [step_goal]
	,sum([steps]) AS [steps]
	,sum([moderate_activity_time]) AS [moderate_activity_time]
	,sum([vigorous_activity_time]) AS [vigorous_activity_time]
	,sum([intensity_time_goal]) AS [intensity_time_goal]
	,sum([floors_up]) AS [floors_up]
	,sum([floors_down]) AS [floors_down]
	,sum([floors_goal]) AS [floors_goal]
	,avg([total_sleep]) AS [total_sleep_avg]
	,min([sleep_min]) AS [sleep_min]
	,max([sleep_max]) AS [sleep_max]
	,avg([deep_sleep]) AS [deep_sleep_avg]
	,avg([light_sleep]) AS [light_sleep_avg]
	,avg([rem_sleep]) AS [rem_sleep_avg]
	,avg([awake]) AS [awake_avg]
	,avg([stress_avg]) AS [stress_avg]
	,sum([distance]) AS [distance]
	,sum([calories_total]) AS [calories_total]
	,sum([calories_bmr]) AS [calories_bmr]
	,sum([calories_active]) AS [calories_active]
	,count([activities]) AS [activities]
	,sum([activities_calories]) AS [activities_calories]
	,sum([activities_distance_km]) AS [activities_distance_km]
	,sum([daily_distance_km]) AS [monthly_distance_km]
	,sum([sweat_loss]) AS [sweat_loss]
	,avg([spo2_avg]) AS [spo2_avg]
	,min([spo2_min]) AS [spo2_min]
	,avg([rr_avg_waking]) AS [rr_avg_waking]
	,max([rr_max]) AS [rr_max]
	,min([rr_min]) AS [rr_min]
	,avg([bb_charged]) AS [bb_charged]
	,max([bb_max]) AS [bb_max]
	,min([bb_min]) AS [bb_min]
--,as [description]
FROM [garmin].[dbo].[daily_summary]
GROUP BY concat(datepart(year, [DAY]),'/',datepart(month, [DAY] /*DATEADD(DAY, - 1, [DAY])*/))
GO
/****** Object:  View [dbo].[vw_tbl_yearly_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_tbl_yearly_summary] as 

SELECT 
	datepart(year, [DAY]) AS [year]
	,min([day]) AS [first_day]
	,datename(weekday, min([day])) AS [date_name]
	,min([hr_min]) AS [hr_min]
	,max([hr_max]) AS [hr_max]
	,avg([hr_avg]) AS [hr_avg]
	,avg([rhr]) AS [rhr]
	,min([rhr_min]) AS [rhr_min]
	,max([rhr_max]) AS [rhr_max]
	,sum([step_goal]) AS [step_goal]
	,sum([steps]) AS [steps]
	,sum([moderate_activity_time]) AS [moderate_activity_time]
	,sum([vigorous_activity_time]) AS [vigorous_activity_time]
	,sum([intensity_time_goal]) AS [intensity_time_goal]
	,sum([floors_up]) AS [floors_up]
	,sum([floors_down]) AS [floors_down]
	,sum([floors_goal]) AS [floors_goal]
	,avg([total_sleep]) AS [total_sleep_avg]
	,min([sleep_min]) AS [sleep_min]
	,max([sleep_max]) AS [sleep_max]
	,avg([deep_sleep]) AS [deep_sleep_avg]
	,avg([light_sleep]) AS [light_sleep_avg]
	,avg([rem_sleep]) AS [rem_sleep_avg]
	,avg([awake]) AS [awake_avg]
	,avg([stress_avg]) AS [stress_avg]
	,sum([distance]) AS [distance]
	,sum([calories_total]) AS [calories_total]
	,sum([calories_bmr]) AS [calories_bmr]
	,sum([calories_active]) AS [calories_active]
	,count([activities]) AS [activities]
	,sum([activities_calories]) AS [activities_calories]
	,sum([activities_distance_km]) AS [activities_distance_km]
	,sum([daily_distance_km]) AS [monthly_distance_km]
	,sum([sweat_loss]) AS [sweat_loss]
	,avg([spo2_avg]) AS [spo2_avg]
	,min([spo2_min]) AS [spo2_min]
	,avg([rr_avg_waking]) AS [rr_avg_waking]
	,max([rr_max]) AS [rr_max]
	,min([rr_min]) AS [rr_min]
	,avg([bb_charged]) AS [bb_charged]
	,max([bb_max]) AS [bb_max]
	,min([bb_min]) AS [bb_min]
--,as [description]
FROM [garmin].[dbo].[daily_summary]
GROUP BY datepart(year, [DAY])
GO
/****** Object:  View [dbo].[vw_sleepphases_bb_stress]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  View [dbo].[vw_activities_over_month]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  View [dbo].[vw_activity_loc_map]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  View [dbo].[vw_cycling]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_cycling] as 

SELECT 
	activities.activity_id AS activity_id,
	COALESCE(activities.name,'Kardio') AS name,
	--activity_laps.lap,
	activities.start_time AS start_time,
	activities.stop_time AS stop_time,
	activities.elapsed_time AS elapsed_time,
	ROUND(activities.distance, 1) AS distance,
	activities.avg_hr AS avg_hr,
	activities.max_hr AS max_hr,
	activities.calories AS calories,
	ROUND(activities.avg_temperature, 1) AS avg_temperature,
	activities.avg_cadence AS avg_rpms,
	activities.max_cadence AS max_rpms,
	ROUND(activities.avg_speed, 1) AS avg_speed,
	ROUND(activities.max_speed, 1) AS max_speed,
	activities.hrz_1_time AS heart_rate_zone_one_time,
	activities.hrz_2_time AS heart_rate_zone_two_time,
	activities.hrz_3_time AS heart_rate_zone_three_time,
	activities.hrz_4_time AS heart_rate_zone_four_time,
	activities.hrz_5_time AS heart_rate_zone_five_time
	--CASE WHEN activities.start_lat IS NULL 
	--	THEN 'N/A'
	--	ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', activities.start_lat, ',', activities.start_long, '&z=13') 
	--	END AS start_loc,
	--CASE WHEN activities.stop_lat IS NULL 
	--	THEN 'N/A'
	--	ELSE CONCAT('http://maps.google.com/?ie=UTF8&q=', activities.stop_lat, ',', activities.stop_long, '&z=13') 
	--	END AS stop_loc
FROM [garmin_activities].src.activities
--JOIN activities.activity_records ON activities.activity_id = activity_records.activity_id
--JOIN activities.activity_laps ON activities.activity_id = activity_laps.activity_id
GO
/****** Object:  View [dbo].[vw_steps_over_hour]    Script Date: 09.10.2023 11:45:06 ******/
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
/****** Object:  View [dbo].[vw_tbl_weekly_summary(based on garmin_summary table)]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_tbl_weekly_summary(based on garmin_summary table)] as 


-- weekly summary based from daily
SELECT 
	datepart(week, DATEADD(DAY, -1, [DAY])) AS [week_num]
	,min([day]) AS [first_day]
	,datename(weekday, min([day])) AS [date_name]
	,round(avg([hr_avg]),2) AS [hr_avg]
	,min([hr_min]) AS [hr_min]
	,max([hr_max]) AS [hr_max]
	,round(avg([rhr_avg]),2) AS [rhr_avg]
	,min([rhr_min]) AS [rhr_min]
	,max([rhr_max]) AS [rhr_max]
	,round(avg([inactive_hr_avg]),2) AS [inactive_hr_avg]
	,min([inactive_hr_min]) AS [inactive_hr_min]
	,max([inactive_hr_max]) AS [inactive_hr_max]
	--,[weight_avg]
	--,[weight_min]
	--,[weight_max]
	,round(avg(datediff(minute, '00:00:00', [intensity_time])			),2)	AS [intensity_time]
	,round(avg(datediff(minute, '00:00:00', [moderate_activity_time])	),2)	AS [moderate_activity_time]
	,round(avg(datediff(minute, '00:00:00', [vigorous_activity_time])	),2)	AS [vigorous_activity_time]
	,round(avg(datediff(minute, '00:00:00', [intensity_time_goal])		),2)	AS [intensity_time_goal]
	,sum([steps]) AS [steps]
	,sum([steps_goal]) AS [steps_goal]
	,round(sum([floors]),2) AS [floors]
	,sum([floors_goal]) AS [floors_goal]
	,round(avg(datediff(minute, '00:00:00', [sleep_avg])),2) AS [sleep_avg]
	,min(datediff(minute, '00:00:00', [sleep_min])) AS [sleep_min]
	,max(datediff(minute, '00:00:00', [sleep_max])) AS [sleep_max]
	,avg(datediff(minute, '00:00:00', [rem_sleep_avg])) AS [rem_sleep_avg]
	,min(datediff(minute, '00:00:00', [rem_sleep_min])) AS [rem_sleep_min]
	,max(datediff(minute, '00:00:00', [rem_sleep_max])) AS [rem_sleep_max]
	,avg([stress_avg]) AS [stress_avg]
	,avg([calories_avg]) AS [calories_avg]
	,avg([calories_bmr_avg]) AS [calories_bmr_avg]
	,avg([calories_active_avg]) AS [calories_active_avg]
	--,[calories_goal]
	--,[calories_consumed_avg]
	,sum([activities]) AS [activities]
	,sum([activities_calories]) AS [activities_calories]
	,sum([activities_distance]) AS [activities_distance_km]
	--,[hydration_goal]
	--,[hydration_avg]
	--,[hydration_intake]
	--,[sweat_loss_avg]
	,sum([sweat_loss]) AS [sweat_loss]
	,avg([spo2_avg]) as [spo2_avg]
	,min([spo2_min]) as [spo2_min]
	,round(avg([rr_waking_avg]),2) AS [rr_waking_avg]
	,max([rr_max]) AS [rr_max]
	,min([rr_min]) AS [rr_min]
	,max([bb_max]) AS [bb_max]
	,min([bb_min]) AS [bb_min]
--,avg(dsm.bb_charged ) as [avg_bb_charged]		 --idea to add body battery charged
--,max(dsm.bb_charged ) as [avg_bb_charged]		 --idea to add body battery charged
FROM [garmin_summary].[src].[days_summary] gsd
GROUP BY datepart(week, DATEADD(DAY, -1, [DAY]))
GO
/****** Object:  View [src].[vw_daily_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_daily_summary]        as select * from openquery(garmin,'select * from daily_summary       ')
GO
/****** Object:  View [src].[vw_resting_hr]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_resting_hr]           as select * from openquery(garmin,'select * from resting_hr          ')
GO
/****** Object:  View [src].[vw_sleep]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_sleep]                as select * from openquery(garmin,'select * from sleep               ')
GO
/****** Object:  View [src].[vw_sleep_events]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_sleep_events]         as select * from openquery(garmin,'select * from sleep_events        ')
GO
/****** Object:  View [src].[vw_stress]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_stress]               as select * from openquery(garmin,'select * from stress              ')
GO
/****** Object:  Table [dbo].[config]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[config](
	[TableName] [nchar](20) NULL,
	[SchemaName] [nchar](10) NULL,
	[IsActive] [nchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[monthly_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monthly_summary](
	[month_num] [varchar](25) NOT NULL,
	[first_day] [date] NULL,
	[date_name] [nvarchar](30) NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[hr_avg] [int] NULL,
	[rhr] [int] NULL,
	[rhr_min] [int] NULL,
	[rhr_max] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [int] NULL,
	[vigorous_activity_time] [int] NULL,
	[intensity_time_goal] [int] NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [int] NULL,
	[total_sleep_avg] [int] NULL,
	[sleep_min] [int] NULL,
	[sleep_max] [int] NULL,
	[deep_sleep_avg] [int] NULL,
	[light_sleep_avg] [int] NULL,
	[rem_sleep_avg] [int] NULL,
	[awake_avg] [int] NULL,
	[stress_avg] [int] NULL,
	[distance] [float] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance_km] [float] NULL,
	[monthly_distance_km] [float] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_avg_waking] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[weekly_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[weekly_summary](
	[week_num] [int] NULL,
	[first_day] [date] NULL,
	[date_name] [nvarchar](30) NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[hr_avg] [int] NULL,
	[rhr] [int] NULL,
	[rhr_min] [int] NULL,
	[rhr_max] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [int] NULL,
	[vigorous_activity_time] [int] NULL,
	[intensity_time_goal] [int] NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [int] NULL,
	[total_sleep_avg] [int] NULL,
	[sleep_min] [int] NULL,
	[sleep_max] [int] NULL,
	[deep_sleep_avg] [int] NULL,
	[light_sleep_avg] [int] NULL,
	[rem_sleep_avg] [int] NULL,
	[awake_avg] [int] NULL,
	[stress_avg] [int] NULL,
	[distance] [float] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance_km] [float] NULL,
	[monthly_distance_km] [float] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_avg_waking] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[yearly_summary]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[yearly_summary](
	[year] [int] NULL,
	[first_day] [date] NULL,
	[date_name] [nvarchar](30) NULL,
	[hr_min] [int] NULL,
	[hr_max] [int] NULL,
	[hr_avg] [int] NULL,
	[rhr] [int] NULL,
	[rhr_min] [int] NULL,
	[rhr_max] [int] NULL,
	[step_goal] [int] NULL,
	[steps] [int] NULL,
	[moderate_activity_time] [int] NULL,
	[vigorous_activity_time] [int] NULL,
	[intensity_time_goal] [int] NULL,
	[floors_up] [float] NULL,
	[floors_down] [float] NULL,
	[floors_goal] [int] NULL,
	[total_sleep_avg] [int] NULL,
	[sleep_min] [int] NULL,
	[sleep_max] [int] NULL,
	[deep_sleep_avg] [int] NULL,
	[light_sleep_avg] [int] NULL,
	[rem_sleep_avg] [int] NULL,
	[awake_avg] [int] NULL,
	[stress_avg] [int] NULL,
	[distance] [float] NULL,
	[calories_total] [int] NULL,
	[calories_bmr] [int] NULL,
	[calories_active] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance_km] [float] NULL,
	[monthly_distance_km] [float] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_avg_waking] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_charged] [int] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[resting_hr]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[resting_hr](
	[day] [date] NULL,
	[resting_heart_rate] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[p_create_src_views]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[p_create_src_views]
as

declare @linkedserver nvarchar(20) = 'garmin'
declare @cursor cursor;
declare @tablename nvarchar(30);
declare @schemaname nvarchar(10);

begin
    set @cursor = cursor for
    select TableName, SchemaName
    from dbo.config
    where IsActive = 'Y'

    open @cursor
    fetch next from @cursor
    into @tablename, @schemaname

    while @@FETCH_STATUS = 0
    begin

        exec ('create or alter view '+@schemaname+'.vw_' + @tablename + ' as select * from openquery('+@linkedserver+',''select * from ' + @tablename +''')')
		 --print ('create or alter view '+@schemaname+'.vw_' + @tablename + ' as select * from openquery('+@linkedserver+',''select * from ' + @tablename + ' where case '+@tablename+' not in (''daily_summary'') then 1=1 else [day] >= ''2023-02-11'''')')

        fetch next from @cursor
        into @tablename, @schemaname
    end
    close @cursor;
    deallocate @cursor;
end

--exec [dbo].[p_create_views]
GO
/****** Object:  StoredProcedure [dbo].[p_populate_daily_summary_tbl]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_populate_daily_summary_tbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 1 - daily */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[daily_summary]
		from [garmin].[dbo].[vw_tbl_daily_summary]
		
END
GO
/****** Object:  StoredProcedure [dbo].[p_populate_monthly_summary_tbl]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_populate_monthly_summary_tbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 3 - monthly */
		drop table if exists [garmin].[dbo].[monthly_summary]
		select *
		into [garmin].[dbo].[monthly_summary]
		from [garmin].[dbo].[vw_tbl_monthly_summary]
END
GO
/****** Object:  StoredProcedure [dbo].[p_populate_src_tables]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[p_populate_src_tables]
as

declare @cursor cursor;
declare @viewname nvarchar(30);
declare @tablename nvarchar(30);
declare @schemaname nvarchar(15);

begin
    set @cursor = cursor for
    select table_name as viewname, SUBSTRING(table_name, 4, len(table_name)) as tablename, TABLE_SCHEMA as schemaname
    from INFORMATION_SCHEMA.VIEWS
    where TABLE_SCHEMA in ('src')

    open @cursor
    fetch next from @cursor
    into @viewname, @tablename, @schemaname

    while @@FETCH_STATUS = 0
    begin
		--select @viewname;
		--select @tablename;
        exec ('drop table if exists '+@schemaname+'.' + @tablename);
        exec ('select * into '+@schemaname+'.' + @tablename + ' from '+@schemaname+'.' + @viewname);
		fetch next from @cursor
		into @viewname, @tablename, @schemaname
    end;

    close @cursor;
    deallocate @cursor;
end
GO
/****** Object:  StoredProcedure [dbo].[p_populate_summary_tables]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_populate_summary_tables] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 1 - daily */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[daily_summary]
		from [garmin].[dbo].[vw_tbl_daily_summary]
		
	/* 2 - weekly */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[weekly_summary]
		from [garmin].[dbo].[vw_tbl_weekly_summary]

	/* 3 - monthly */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[monthly_summary]
		from [garmin].[dbo].[vw_tbl_monthly_summary]

	/* 4 - yearly */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[yearly_summary]
		from [garmin].[dbo].[vw_tbl_yearly_summary]
END
GO
/****** Object:  StoredProcedure [dbo].[p_populate_weekly_summary_tbl]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_populate_weekly_summary_tbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 2 - weekly */
		drop table if exists [garmin].[dbo].[weekly_summary]
		select *
		into [garmin].[dbo].[weekly_summary]
		from [garmin].[dbo].[vw_tbl_weekly_summary]
END
GO
/****** Object:  StoredProcedure [dbo].[p_populate_yearly_summary_tbl]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_populate_yearly_summary_tbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 4 - yearly */
		drop table if exists [garmin].[dbo].[yearly_summary]
		select *
		into [garmin].[dbo].[yearly_summary]
		from [garmin].[dbo].[vw_tbl_yearly_summary]
END
GO
/****** Object:  StoredProcedure [dbo].[p_reload_all_data]    Script Date: 09.10.2023 11:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[p_reload_all_data] AS 

BEGIN

	/* POPULATING STAGING TABLES ON 4 DATABASES */
	exec [garmin].[dbo].[p_create_src_views]
	exec [garmin].[dbo].[p_populate_src_tables]

	exec [garmin_activities].[dbo].[p_create_src_views]
	exec [garmin_activities].[dbo].[p_populate_src_tables]

	exec [garmin_monitoring].[dbo].[p_create_src_views]
	exec [garmin_monitoring].[dbo].[p_populate_src_tables]

	exec [garmin_summary].[dbo].[p_create_src_views]
	exec [garmin_summary].[dbo].[p_populate_src_tables]
	
	/* ####### POPULATE SUMMARY TABLES ####### */
	--exec [dbo].[p_populate_daily_summary_tbl]
	--exec [dbo].[p_populate_weekly_summary_tbl]
	--exec [dbo].[p_populate_monthly_summary_tbl]
	--exec [dbo].[p_populate_yearly_summary_tbl]
END
GO
USE [master]
GO
ALTER DATABASE [garmin] SET  READ_WRITE 
GO
