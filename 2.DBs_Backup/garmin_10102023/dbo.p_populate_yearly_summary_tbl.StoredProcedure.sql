USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_populate_yearly_summary_tbl] AS 

BEGIN
	/* ####### CREATE CALCULATED SUMMARY TABLES ####### */
	/* 4 - yearly */
		drop table if exists [garmin].[dbo].[yearly_summary]
		select *
		into [garmin].[dbo].[yearly_summary]
		from [garmin].[dbo].[vw_tbl_yearly_summary]
END
GO
