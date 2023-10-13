USE [garmin_summary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[intensity_hr](
	[timestamp] [datetime2](7) NULL,
	[intensity] [int] NULL,
	[heart_rate] [int] NULL
) ON [PRIMARY]
GO
