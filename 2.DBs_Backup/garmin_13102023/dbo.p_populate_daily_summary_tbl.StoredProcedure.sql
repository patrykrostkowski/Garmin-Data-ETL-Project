USE [garmin]
GO
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
