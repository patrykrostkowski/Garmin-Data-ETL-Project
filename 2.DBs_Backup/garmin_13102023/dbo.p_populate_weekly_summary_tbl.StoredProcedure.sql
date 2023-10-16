USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_populate_weekly_summary_tbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 2 - weekly */
		drop table if exists [garmin].[dbo].[weekly_summary]
		select *
		into [garmin].[dbo].[weekly_summary]
		from [garmin].[dbo].[vw_tbl_weekly_summary]
END
GO
