USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateWeeklySummaryTbl]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateWeeklySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 2 - weekly */
		drop table if exists [dbo].[WeeklySummary]
		select *
		into [dbo].[WeeklySummary]
		from [dbo].[vwTblWeeklySummary]
END
GO
