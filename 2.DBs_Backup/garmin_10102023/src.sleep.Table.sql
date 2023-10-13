USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[sleep](
	[day] [date] NULL,
	[start] [datetime2](7) NULL,
	[end] [datetime2](7) NULL,
	[total_sleep] [time](0) NULL,
	[deep_sleep] [time](0) NULL,
	[light_sleep] [time](0) NULL,
	[rem_sleep] [time](0) NULL,
	[awake] [time](0) NULL,
	[avg_spo2] [float] NULL,
	[avg_rr] [float] NULL,
	[avg_stress] [float] NULL,
	[score] [int] NULL,
	[qualifier] [nvarchar](255) NULL
) ON [PRIMARY]
GO
