USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_IncrementalMerge_OLD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[p_IncrementalMerge_OLD] @incr_period INT AS 

BEGIN

	/* ####### MERGE DAILY SUMMARY TABLE ####### */

		--exec [dbo].[p_PopulateDailySummaryTbl]
		--create incremental merge - 30 days

		--[dbo].[p_MergeSrcTables_test] -- it works pretty well, need add logic to merge tbls where date column not exists
		exec [dbo].[p_IncrementalMergeDailyData_TESTWithParam] @incr_period
	
	/* ####### POPULATE SUMMARY TABLES ####### */
		--create incremental merge - 4 weeks
		exec [dbo].[p_PopulateWeeklySummaryTbl]
		
		--create incremental merge - 2 months
		exec [dbo].[p_PopulateMonthlySummaryTbl]
		
		--create incremental merge - 2 years
		exec [dbo].[p_PopulateYearlySummaryTbl]

END
GO
