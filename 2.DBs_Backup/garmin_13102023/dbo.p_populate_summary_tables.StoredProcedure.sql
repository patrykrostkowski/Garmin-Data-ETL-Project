USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_populate_summary_tables] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 1 - daily */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[daily_summary]
		from [garmin].[dbo].[vw_tbl_daily_summary]
		
	/* 2 - weekly */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[weekly_summary]
		from [garmin].[dbo].[vw_tbl_weekly_summary]

	/* 3 - monthly */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[monthly_summary]
		from [garmin].[dbo].[vw_tbl_monthly_summary]

	/* 4 - yearly */
		drop table if exists [garmin].[dbo].[daily_summary]
		select *
		into [garmin].[dbo].[yearly_summary]
		from [garmin].[dbo].[vw_tbl_yearly_summary]
END
GO
