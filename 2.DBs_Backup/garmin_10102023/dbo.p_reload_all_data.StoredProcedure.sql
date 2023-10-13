USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[p_reload_all_data] AS 

BEGIN

	/* POPULATING STAGING TABLES ON 4 DATABASES */
	exec [garmin].[dbo].[p_create_src_views]
	exec [garmin].[dbo].[p_populate_src_tables]

	exec [garmin_activities].[dbo].[p_create_src_views]
	exec [garmin_activities].[dbo].[p_populate_src_tables]

	exec [garmin_monitoring].[dbo].[p_create_src_views]
	exec [garmin_monitoring].[dbo].[p_populate_src_tables]

	exec [garmin_summary].[dbo].[p_create_src_views]
	exec [garmin_summary].[dbo].[p_populate_src_tables]
	
	/* ####### POPULATE SUMMARY TABLES ####### */
	--exec [dbo].[p_populate_daily_summary_tbl]
	--exec [dbo].[p_populate_weekly_summary_tbl]
	--exec [dbo].[p_populate_monthly_summary_tbl]
	--exec [dbo].[p_populate_yearly_summary_tbl]
END
GO
