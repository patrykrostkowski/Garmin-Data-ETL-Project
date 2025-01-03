USE [garmin]
GO
DROP PROCEDURE IF EXISTS [dbo].[p_PopulateMonthlySummaryTbl]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_PopulateMonthlySummaryTbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 3 - monthly */
		drop table if exists [dbo].[MonthlySummary]
		select *
		into [dbo].[MonthlySummary]
		from [dbo].[vwTblMonthlySummary]
END
GO
