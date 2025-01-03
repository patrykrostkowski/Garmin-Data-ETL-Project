USE [garmin]
GO
DROP INDEX IF EXISTS [IX_Garmin/Sleep_day] ON [src].[Garmin/Sleep] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[Garmin/Sleep]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[Garmin/Sleep](
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
CREATE UNIQUE CLUSTERED INDEX [IX_Garmin/Sleep_day] ON [src].[Garmin/Sleep]
(
	[day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
