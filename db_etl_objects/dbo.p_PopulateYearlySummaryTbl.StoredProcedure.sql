USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateYearlySummaryTbl]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateYearlySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 4 - yearly */
		drop table if exists [dbo].[YearlySummary]
		select *
		into [dbo].[YearlySummary]
		from [dbo].[vwTblYearlySummary]
END
GO
