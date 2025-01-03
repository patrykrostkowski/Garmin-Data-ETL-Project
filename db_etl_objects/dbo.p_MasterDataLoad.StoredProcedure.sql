USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_MasterDataLoad]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[p_MasterDataLoad]	@FullLoad BIT
AS 

/*
exec [dbo].[p_MasterDataLoad] 0
	select top 100 * from [acc].[LogTable]
	select top 100 * from [dbo].[DailySummary]	 order by 1 desc
	select top 100 * from [dbo].[WeeklySummary]	 order by 1 desc
	select top 100 * from [dbo].[MonthlySummary] order by 1 desc
	select top 100 * from [dbo].[YearlySummary]	 order by 1 desc

Log file
11-08-2024 
	-- fixed:
		incremental merge, tested full load as well. Log table looks good.
		WEEKLY SUMMARY - first week of 2024 show as the last of 2023
		there was no 02-2023 weeks summary

24-07-2024
	- added incremental 100 year ago but month, weekly and yearly merge dont work

15-06-2024
	- It would be good to catch potential errors in e.x LogTable, instead of checking Load returned message

21-05-2024:
	- Full Load works fine
	- Added CutOffDate to Log Table
	- finished [dbo].[p_MergeSrcTables] 
	- Added indexes to src tables to improve loading, test load before and after indexes
*/

DECLARE @ProcessType NVARCHAR(100)


IF @FullLoad = 1 
BEGIN TRY

	/* ####### LOGGING PROCESS ####### */
	SET @ProcessType = 'Full Load'
	INSERT INTO [acc].[LogTable] (ProcessType, LoadStart, PriorCutOffDate, CutOffDate, Status)
    VALUES (@ProcessType, GETDATE(), (SELECT MIN([day]) FROM dbo.DailySummary), NULL, 'Started');

		/* ####### CREATE SOURCE VIEWS AND POPULATE SOURCE TABLES ####### */
			EXEC [dbo].[p_CreateSrcViews]
			EXEC [dbo].[p_PopulateSrcTables]
			EXEC [dbo].[p_CreateIndexesOnSourceTbls]

		/* ####### POPULATING SUMMARY TABLES ####### */
			EXEC [dbo].[p_PopulateDailySummaryTbl];
				DROP INDEX IF EXISTS IX_DailySummary_day ON [dbo].[DailySummary];
				CREATE CLUSTERED INDEX IX_DailySummary_day ON [dbo].[DailySummary] ([day]);

			EXEC [dbo].[p_PopulateWeeklySummaryTbl];
				DROP INDEX IF EXISTS IX_WeeklySummary_first_day ON [dbo].[WeeklySummary];
				CREATE CLUSTERED INDEX IX_WeeklySummary_first_day ON [dbo].[WeeklySummary] ([first_day]);

			EXEC [dbo].[p_PopulateMonthlySummaryTbl];
				DROP INDEX IF EXISTS IX_MonthlySummary_month_num ON [dbo].[MonthlySummary];
				CREATE CLUSTERED INDEX IX_MonthlySummary_month_num ON [dbo].[MonthlySummary] ([first_day]);

			EXEC [dbo].[p_PopulateYearlySummaryTbl];
				DROP INDEX IF EXISTS IX_YearlySummary_year ON [dbo].[YearlySummary];
				CREATE CLUSTERED INDEX IX_YearlySummary_year ON [dbo].[YearlySummary] ([year]);

		PRINT('Load process completed. Updating log table, time: '+convert(varchar, getdate(),120))
		UPDATE [acc].[LogTable]
		SET LoadEnd = GETDATE(), Status = 'Completed', CutOffDate = (SELECT MAX([day]) FROM dbo.DailySummary)
		WHERE ProcessType = @ProcessType
			AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);

END TRY
BEGIN CATCH
		PRINT ERROR_MESSAGE();
		UPDATE [acc].[LogTable]
		SET LoadEnd = NULL
			--,PriorCutOffDate = NULL
			,CutOffDate = NULL
			,Status = 'Error'
		WHERE ProcessType = @ProcessType
			AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);
END CATCH;

-- ################################# INCREMENTAL MERGE ########################################
IF @FullLoad = 0
BEGIN TRY

	DECLARE @CutOffDate DATE = (SELECT MAX(CutOffDate) FROM [acc].[LogTable] WHERE Status = 'Completed')
		IF @CutOffDate IS NULL 
			BEGIN
				PRINT (concat('No successfull load found. Executing Full Load: ',convert(varchar, getdate(),120)))
				EXEC [dbo].[p_MasterDataLoad] 1
			END
		ELSE 
/* ####### LOGGING PROCESS ####### */
	SET @ProcessType = 'Incremental Load'
	INSERT INTO [acc].[LogTable] (ProcessType, LoadStart, PriorCutOffDate, CutOffDate, Status)
    VALUES (@ProcessType, GETDATE(), (SELECT MAX([day]) FROM dbo.DailySummary), NULL, 'Started');

		--PRINT ('Merge Src tables')
		EXEC [dbo].[p_MergeSrcTables] @CutOffDate

		--PRINT ('Start merge daily table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeDailyData] @CutOffDate
	
		--PRINT ('Start merge weekly table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeWeeklyData] @CutOffDate

		--PRINT ('Start merge monthly table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeMonthlyData] @CutOffDate

		--PRINT ('Start merge yearly table process: '+convert(varchar, getdate(),120))
		EXEC [dbo].[p_IncrementalMergeYearlyData] @CutOffDate

	PRINT('Merge process completed. Updating log table, time: '+convert(varchar, getdate(),120))
	UPDATE [acc].[LogTable]
	SET LoadEnd = GETDATE(), Status = 'Completed', CutOffDate = (SELECT MAX([day]) FROM dbo.DailySummary)
	WHERE ProcessType = @ProcessType
		AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);
	
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE();
	UPDATE [acc].[LogTable]
	SET LoadEnd = NULL
		,CutOffDate = NULL
		,Status = 'Error'
	WHERE ProcessType = @ProcessType 
		AND LogID = (SELECT MAX(LogID) FROM [acc].[LogTable] WHERE ProcessType = @ProcessType);
END CATCH

GO
