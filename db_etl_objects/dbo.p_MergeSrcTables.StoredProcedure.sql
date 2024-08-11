USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MergeSrcTables]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[p_MergeSrcTables] @CutOffDate NVARCHAR(255) AS

/*
EXEC [dbo].[p_MergeSrcTables] '2024-05-10'
DECLARE @CutOffDate varchar(1000) = '2024-05-10'
*/

DECLARE @ViewName NVARCHAR(255)
DECLARE @TableName NVARCHAR(255)
DECLARE @SchemaName NVARCHAR(255)
DECLARE @MergeSQL NVARCHAR(MAX)
DECLARE @TempTblSQL NVARCHAR(MAX)
DECLARE @ColumnList NVARCHAR(MAX)
DECLARE @UpdateColumnList NVARCHAR(MAX)
DECLARE @ViewFirstColumn NVARCHAR(255)
DECLARE @TableFirstColumn NVARCHAR(255)

DECLARE view_cursor CURSOR FOR
	SELECT TABLE_SCHEMA, TABLE_NAME
	FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_NAME LIKE 'vw%' and TABLE_SCHEMA = 'src'
		AND TABLE_NAME NOT IN ( 
			'vwGarminActivities/Activities'
			,'vwGarminActivities/ActivityLaps'
			,'vwGarminActivities/ActivityRecords'
			,'vwGarminActivities/CycleActivities'
			,'vwGarminActivities/PaddleActivities'
			,'vwGarminActivities/StepsActivities'
			,'vwGarminMonitoring/Monitoring'
			,'vwGarminMonitoring/MonitoringInfo'
		) -- this views of sink tables do not have unique columns

OPEN view_cursor

FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName

WHILE @@FETCH_STATUS = 0
BEGIN

    SET @TableName = REPLACE(@ViewName, 'vw', '')

	-- Get the first column of the view to compare rows
    SELECT TOP 1 @ViewFirstColumn = COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @ViewName
		AND DATA_TYPE IN ('datetime2','datetime','date')
		--OR COLUMN_NAME = 'activity_id')
    ORDER BY ORDINAL_POSITION

    -- Get the first column of the table to compare rows
    SELECT TOP 1 @TableFirstColumn = COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @TableName
		AND DATA_TYPE IN ('datetime2','datetime','date')
		--OR COLUMN_NAME = 'activity_id')
    ORDER BY ORDINAL_POSITION

	SET @TempTblSQL = 'SELECT * INTO #MergeViewData FROM '+QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+'  WHERE '+@ViewFirstColumn+' >= '''+ @CutOffDate+''''
	--print @TempTblSQL
	EXEC sp_executesql @TempTblSQL

    -- Constructing column list
    SET @ColumnList = ''
    SET @UpdateColumnList = ''

    SELECT 
        @ColumnList = @ColumnList + QUOTENAME(COLUMN_NAME) + ',',
        @UpdateColumnList = @UpdateColumnList + 'Target.' + QUOTENAME(COLUMN_NAME) + ' = Source.' + QUOTENAME(COLUMN_NAME) + ','
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @SchemaName AND TABLE_NAME = @ViewName

    -- Constructing MERGE statement
    SET @MergeSQL = '
    MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
    USING #MergeViewData AS Source
    ON (' + QUOTENAME(@UpdateColumnList) + ')
    WHEN MATCHED THEN
    UPDATE SET '

    SET @ColumnList = LEFT(@ColumnList, LEN(@ColumnList) - 1) 
    SET @UpdateColumnList = LEFT(@UpdateColumnList, LEN(@UpdateColumnList) - 1)

    SET @MergeSQL = '
    MERGE INTO ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + ' AS Target
    USING #MergeViewData AS Source
    ON (Target.' + QUOTENAME(@TableFirstColumn) + ' = Source.' + QUOTENAME(@ViewFirstColumn) + ')
    
    WHEN MATCHED THEN
    UPDATE 
    SET '+ @UpdateColumnList

	SET @MergeSQL += '
    WHEN NOT MATCHED THEN
    INSERT (' + @ColumnList + ')
    VALUES (' + @ColumnList + ');'

	EXECUTE sp_executesql @MergeSQL
    --PRINT @MergeSQL

    IF OBJECT_ID('tempdb..#MergeViewData') IS NOT NULL
    BEGIN
        DROP TABLE #MergeViewData
    END

    FETCH NEXT FROM view_cursor INTO @SchemaName, @ViewName
END

CLOSE view_cursor
DEALLOCATE view_cursor



-- ETL EXCEPTIONS
SELECT *
INTO #GarminActivities
FROM [src].[vwGarminActivities/Activities]
WHERE [start_time] >= @CutOffDate;
	MERGE INTO [src].[GarminActivities/Activities] AS target
	USING #GarminActivities AS source
	ON target.[start_time]=source.[start_time]
	WHEN MATCHED THEN UPDATE SET target.[activity_id]=source.[activity_id], target.[name]=source.[name], target.[description]=source.[description], target.[type]=source.[type], target.[course_id]=source.[course_id], target.[laps]=source.[laps], target.[sport]=source.[sport], target.[sub_sport]=source.[sub_sport], target.[training_effect]=source.[training_effect], target.[anaerobic_training_effect]=source.[anaerobic_training_effect], target.[stop_time]=source.[stop_time], target.[elapsed_time]=source.[elapsed_time], target.[moving_time]=source.[moving_time], target.[distance]=source.[distance], target.[cycles]=source.[cycles], target.[avg_hr]=source.[avg_hr], target.[max_hr]=source.[max_hr], target.[avg_rr]=source.[avg_rr], target.[max_rr]=source.[max_rr], target.[calories]=source.[calories], target.[avg_cadence]=source.[avg_cadence], target.[max_cadence]=source.[max_cadence], target.[avg_speed]=source.[avg_speed], target.[max_speed]=source.[max_speed], target.[ascent]=source.[ascent], target.[descent]=source.[descent], target.[max_temperature]=source.[max_temperature], target.[min_temperature]=source.[min_temperature], target.[avg_temperature]=source.[avg_temperature], target.[start_lat]=source.[start_lat], target.[start_long]=source.[start_long], target.[stop_lat]=source.[stop_lat], target.[stop_long]=source.[stop_long], target.[hr_zones_method]=source.[hr_zones_method], target.[hrz_1_hr]=source.[hrz_1_hr], target.[hrz_2_hr]=source.[hrz_2_hr], target.[hrz_3_hr]=source.[hrz_3_hr], target.[hrz_4_hr]=source.[hrz_4_hr], target.[hrz_5_hr]=source.[hrz_5_hr], target.[hrz_1_time]=source.[hrz_1_time], target.[hrz_2_time]=source.[hrz_2_time], target.[hrz_3_time]=source.[hrz_3_time], target.[hrz_4_time]=source.[hrz_4_time], target.[hrz_5_time]=source.[hrz_5_time]
	WHEN NOT MATCHED BY TARGET THEN INSERT([activity_id], [name], [description], [type], [course_id], [laps], [sport], [sub_sport], [training_effect], [anaerobic_training_effect], [start_time], [stop_time], [elapsed_time], [moving_time], [distance], [cycles], [avg_hr], [max_hr], [avg_rr], [max_rr], [calories], [avg_cadence], [max_cadence], [avg_speed], [max_speed], [ascent], [descent], [max_temperature], [min_temperature], [avg_temperature], [start_lat], [start_long], [stop_lat], [stop_long], [hr_zones_method], [hrz_1_hr], [hrz_2_hr], [hrz_3_hr], [hrz_4_hr], [hrz_5_hr], [hrz_1_time], [hrz_2_time], [hrz_3_time], [hrz_4_time], [hrz_5_time])
									VALUES(source.[activity_id], source.[name], source.[description], source.[type], source.[course_id], source.[laps], source.[sport], source.[sub_sport], source.[training_effect], source.[anaerobic_training_effect], source.[start_time], source.[stop_time], source.[elapsed_time], source.[moving_time], source.[distance], source.[cycles], source.[avg_hr], source.[max_hr], source.[avg_rr], source.[max_rr], source.[calories], source.[avg_cadence], source.[max_cadence], source.[avg_speed], source.[max_speed], source.[ascent], source.[descent], source.[max_temperature], source.[min_temperature], source.[avg_temperature], source.[start_lat], source.[start_long], source.[stop_lat], source.[stop_long], source.[hr_zones_method], source.[hrz_1_hr], source.[hrz_2_hr], source.[hrz_3_hr], source.[hrz_4_hr], source.[hrz_5_hr], source.[hrz_1_time], source.[hrz_2_time], source.[hrz_3_time], source.[hrz_4_time], source.[hrz_5_time])
	WHEN NOT MATCHED BY SOURCE THEN DELETE;
DROP TABLE #GarminActivities;

SELECT *
INTO #ActivityLaps
FROM [src].[vwGarminActivities/ActivityLaps]
WHERE [start_time] >= @CutOffDate;
	MERGE INTO [src].[GarminActivities/ActivityLaps] AS target
	USING #ActivityLaps AS source
	ON target.[start_time]=source.[start_time]
		WHEN MATCHED THEN UPDATE SET target.[activity_id]=source.[activity_id], target.[lap]=source.[lap], target.[stop_time]=source.[stop_time], target.[elapsed_time]=source.[elapsed_time], target.[moving_time]=source.[moving_time], target.[distance]=source.[distance], target.[cycles]=source.[cycles], target.[avg_hr]=source.[avg_hr], target.[max_hr]=source.[max_hr], target.[avg_rr]=source.[avg_rr], target.[max_rr]=source.[max_rr], target.[calories]=source.[calories], target.[avg_cadence]=source.[avg_cadence], target.[max_cadence]=source.[max_cadence], target.[avg_speed]=source.[avg_speed], target.[max_speed]=source.[max_speed], target.[ascent]=source.[ascent], target.[descent]=source.[descent], target.[max_temperature]=source.[max_temperature], target.[min_temperature]=source.[min_temperature], target.[avg_temperature]=source.[avg_temperature], target.[start_lat]=source.[start_lat], target.[start_long]=source.[start_long], target.[stop_lat]=source.[stop_lat], target.[stop_long]=source.[stop_long], target.[hr_zones_method]=source.[hr_zones_method], target.[hrz_1_hr]=source.[hrz_1_hr], target.[hrz_2_hr]=source.[hrz_2_hr], target.[hrz_3_hr]=source.[hrz_3_hr], target.[hrz_4_hr]=source.[hrz_4_hr], target.[hrz_5_hr]=source.[hrz_5_hr], target.[hrz_1_time]=source.[hrz_1_time], target.[hrz_2_time]=source.[hrz_2_time], target.[hrz_3_time]=source.[hrz_3_time], target.[hrz_4_time]=source.[hrz_4_time], target.[hrz_5_time]=source.[hrz_5_time]
		WHEN NOT MATCHED BY TARGET THEN INSERT([activity_id], [lap], [start_time], [stop_time], [elapsed_time], [moving_time], [distance], [cycles], [avg_hr], [max_hr], [avg_rr], [max_rr], [calories], [avg_cadence], [max_cadence], [avg_speed], [max_speed], [ascent], [descent], [max_temperature], [min_temperature], [avg_temperature], [start_lat], [start_long], [stop_lat], [stop_long], [hr_zones_method], [hrz_1_hr], [hrz_2_hr], [hrz_3_hr], [hrz_4_hr], [hrz_5_hr], [hrz_1_time], [hrz_2_time], [hrz_3_time], [hrz_4_time], [hrz_5_time])
										VALUES(source.[activity_id], source.[lap], source.[start_time], source.[stop_time], source.[elapsed_time], source.[moving_time], source.[distance], source.[cycles], source.[avg_hr], source.[max_hr], source.[avg_rr], source.[max_rr], source.[calories], source.[avg_cadence], source.[max_cadence], source.[avg_speed], source.[max_speed], source.[ascent], source.[descent], source.[max_temperature], source.[min_temperature], source.[avg_temperature], source.[start_lat], source.[start_long], source.[stop_lat], source.[stop_long], source.[hr_zones_method], source.[hrz_1_hr], source.[hrz_2_hr], source.[hrz_3_hr], source.[hrz_4_hr], source.[hrz_5_hr], source.[hrz_1_time], source.[hrz_2_time], source.[hrz_3_time], source.[hrz_4_time], source.[hrz_5_time])
		WHEN NOT MATCHED BY SOURCE THEN DELETE;
DROP TABLE #ActivityLaps;

SELECT *
INTO #ActivityRecords
FROM [src].[vwGarminActivities/ActivityRecords]
WHERE [timestamp] >= @CutOffDate;
	MERGE INTO [src].[GarminActivities/ActivityRecords] AS target
	USING #ActivityRecords AS source
	ON target.[timestamp]=source.[timestamp]
		WHEN MATCHED THEN UPDATE SET target.[activity_id]=source.[activity_id], target.[record]=source.[record], target.[position_lat]=source.[position_lat], target.[position_long]=source.[position_long], target.[distance]=source.[distance], target.[cadence]=source.[cadence], target.[altitude]=source.[altitude], target.[hr]=source.[hr], target.[rr]=source.[rr], target.[speed]=source.[speed], target.[temperature]=source.[temperature]
		WHEN NOT MATCHED BY TARGET THEN INSERT([activity_id], [record], [timestamp], [position_lat], [position_long], [distance], [cadence], [altitude], [hr], [rr], [speed], [temperature])
										VALUES(source.[activity_id], source.[record], source.[timestamp], source.[position_lat], source.[position_long], source.[distance], source.[cadence], source.[altitude], source.[hr], source.[rr], source.[speed], source.[temperature])
		WHEN NOT MATCHED BY SOURCE THEN DELETE;
DROP TABLE #ActivityRecords;

--############################# TABLES DONT HAVE DATE/TIME COLUMN #############################################
MERGE INTO [src].[GarminActivities/CycleActivities] AS target
USING [src].[vwGarminActivities/CycleActivities] AS source
ON target.[activity_id]=source.[activity_id]
	WHEN MATCHED THEN UPDATE SET target.[strokes]=source.[strokes], target.[vo2_max]=source.[vo2_max]
	WHEN NOT MATCHED BY TARGET THEN INSERT([strokes], [vo2_max], [activity_id])
									VALUES(source.[strokes], source.[vo2_max], source.[activity_id])
	WHEN NOT MATCHED BY SOURCE THEN DELETE;

MERGE INTO [src].[GarminActivities/PaddleActivities] AS target
USING [src].[vwGarminActivities/PaddleActivities] AS source
ON target.[activity_id]=source.[activity_id]
	WHEN MATCHED THEN UPDATE SET target.[strokes]=source.[strokes], target.[avg_stroke_distance]=source.[avg_stroke_distance]
	WHEN NOT MATCHED BY TARGET THEN INSERT([strokes], [avg_stroke_distance], [activity_id])
									VALUES(source.[strokes], source.[avg_stroke_distance], source.[activity_id])
	WHEN NOT MATCHED BY SOURCE THEN DELETE;

MERGE INTO [src].[GarminActivities/StepsActivities] AS target
USING [src].[vwGarminActivities/StepsActivities] AS source
ON target.[activity_id]=source.[activity_id]
	WHEN MATCHED THEN UPDATE SET target.[steps]=source.[steps], target.[avg_pace]=source.[avg_pace], target.[avg_moving_pace]=source.[avg_moving_pace], target.[max_pace]=source.[max_pace], target.[avg_steps_per_min]=source.[avg_steps_per_min], target.[max_steps_per_min]=source.[max_steps_per_min], target.[avg_step_length]=source.[avg_step_length], target.[avg_vertical_ratio]=source.[avg_vertical_ratio], target.[avg_vertical_oscillation]=source.[avg_vertical_oscillation], target.[avg_gct_balance]=source.[avg_gct_balance], target.[avg_ground_contact_time]=source.[avg_ground_contact_time], target.[avg_stance_time_percent]=source.[avg_stance_time_percent], target.[vo2_max]=source.[vo2_max]
	WHEN NOT MATCHED BY TARGET THEN INSERT([steps], [avg_pace], [avg_moving_pace], [max_pace], [avg_steps_per_min], [max_steps_per_min], [avg_step_length], [avg_vertical_ratio], [avg_vertical_oscillation], [avg_gct_balance], [avg_ground_contact_time], [avg_stance_time_percent], [vo2_max], [activity_id])
									VALUES(source.[steps], source.[avg_pace], source.[avg_moving_pace], source.[max_pace], source.[avg_steps_per_min], source.[max_steps_per_min], source.[avg_step_length], source.[avg_vertical_ratio], source.[avg_vertical_oscillation], source.[avg_gct_balance], source.[avg_ground_contact_time], source.[avg_stance_time_percent], source.[vo2_max], source.[activity_id])
	WHEN NOT MATCHED BY SOURCE THEN DELETE;
--############################# TABLES DONT HAVE DATE/TIME COLUMN #############################################

SELECT *
INTO #Monitoring
FROM [src].[vwGarminMonitoring/Monitoring]
WHERE [timestamp] >= @CutOffDate;
	MERGE INTO [src].[GarminMonitoring/Monitoring] AS target
	USING #Monitoring AS source
	ON target.[timestamp]=source.[timestamp] AND target.[activity_type]=source.[activity_type]
		WHEN MATCHED THEN UPDATE SET target.[intensity]=source.[intensity], target.[duration]=source.[duration], target.[distance]=source.[distance], target.[cum_active_time]=source.[cum_active_time], target.[active_calories]=source.[active_calories], target.[steps]=source.[steps], target.[strokes]=source.[strokes], target.[cycles]=source.[cycles]
		WHEN NOT MATCHED BY TARGET THEN INSERT([timestamp], [activity_type], [intensity], [duration], [distance], [cum_active_time], [active_calories], [steps], [strokes], [cycles])
										VALUES(source.[timestamp], source.[activity_type], source.[intensity], source.[duration], source.[distance], source.[cum_active_time], source.[active_calories], source.[steps], source.[strokes], source.[cycles])
		WHEN NOT MATCHED BY SOURCE THEN DELETE;
DROP TABLE #Monitoring;

SELECT *
INTO #MonitoringInfo
FROM [src].[vwGarminMonitoring/MonitoringInfo]
WHERE [timestamp] >= @CutOffDate;
	MERGE INTO [src].[GarminMonitoring/MonitoringInfo] AS target
	USING #MonitoringInfo AS source
	ON target.[timestamp]=source.[timestamp] AND target.[activity_type]=source.[activity_type]
		WHEN MATCHED THEN UPDATE SET target.[file_id]=source.[file_id], target.[resting_metabolic_rate]=source.[resting_metabolic_rate], target.[cycles_to_distance]=source.[cycles_to_distance], target.[cycles_to_calories]=source.[cycles_to_calories]
		WHEN NOT MATCHED BY TARGET THEN INSERT([timestamp], [file_id], [activity_type], [resting_metabolic_rate], [cycles_to_distance], [cycles_to_calories])
										VALUES(source.[timestamp], source.[file_id], source.[activity_type], source.[resting_metabolic_rate], source.[cycles_to_distance], source.[cycles_to_calories])
		WHEN NOT MATCHED BY SOURCE THEN DELETE;
DROP TABLE #MonitoringInfo;




--    SELECT TOP 1 COLUMN_NAME
--    FROM INFORMATION_SCHEMA.COLUMNS
--    WHERE TABLE_NAME LIKE 'vw%' and TABLE_SCHEMA = 'src' AND TABLE_NAME = 'vwGarminActivities/Activities'
--		AND (DATA_TYPE IN ('datetime2','datetime','date') 
--		OR COLUMN_NAME = 'activity_id')
--    ORDER BY ORDINAL_POSITION



--	declare @SchemaName varchar(1000) = 'src'
--	declare @ViewName   varchar(1000) = 'vwGarmin/DailySummary'
--	DECLARE @TempTblSQL NVARCHAR(MAX)
--	DECLARE @ViewFirstColumn varchar(1000)
--	DECLARE @CutOffDate varchar(1000) = '2024-05-15'

--    set @ViewFirstColumn = 
--	(SELECT TOP 1 COLUMN_NAME 
--    FROM INFORMATION_SCHEMA.COLUMNS
--    WHERE TABLE_SCHEMA = 'src' AND TABLE_NAME = 'vwGarmin/DailySummary'
--		AND DATA_TYPE IN ('datetime2','datetime','date')
--		--OR COLUMN_NAME = 'activity_id')
--    ORDER BY ORDINAL_POSITION)

--	SET @TempTblSQL = 'SELECT * INTO #MergeViewData FROM '+QUOTENAME(@SchemaName)+'.'+QUOTENAME(@ViewName)+'  WHERE '+@ViewFirstColumn+' > '''+@CutOffDate+''''
--	print @TempTblSQL
--	EXEC sp_executesql @TempTblSQL

GO
