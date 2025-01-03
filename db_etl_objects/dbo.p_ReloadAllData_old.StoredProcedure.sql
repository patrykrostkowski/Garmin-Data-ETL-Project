USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_ReloadAllData_old]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[p_ReloadAllData_old] AS 
/*
exec [dbo].[p_ReloadAllData]
*/
BEGIN

	/* ####### CREATE SOURCE VIEWS AND POPULATE SOURCE TABLES ####### */

		-- need to code if exists then skip step
		exec [dbo].[p_CreateSrcViews]
	
		-- populating source tables
		exec [dbo].[p_PopulateSrcTables]

		-- creating indexes on source tables
		exec [dbo].[p_CreateIndexesOnSourceTbls]


	/* ####### POPULATING SUMMARY TABLES ####### */
	
		exec [dbo].[p_PopulateDailySummaryTbl]

		exec [dbo].[p_PopulateWeeklySummaryTbl]
		
		exec [dbo].[p_PopulateMonthlySummaryTbl]
		
		exec [dbo].[p_PopulateYearlySummaryTbl]

END
GO
