USE [garmin]
GO
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
