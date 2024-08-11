USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateDailySummaryTbl]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateDailySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 1 - daily */
		drop table if exists [dbo].[DailySummary]
		select *
		into [dbo].[DailySummary]
		from [dbo].[vwTblDailySummary]
		
END

GO
