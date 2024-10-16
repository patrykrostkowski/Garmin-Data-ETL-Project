USE [garmin]
GO
DROP INDEX IF EXISTS [IX_GarminActivities/ActivityRecords_timestamp] ON [src].[GarminActivities/ActivityRecords] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminActivities/ActivityRecords]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminActivities/ActivityRecords](
	[activity_id] [nvarchar](255) NULL,
	[record] [int] NULL,
	[timestamp] [datetime2](7) NULL,
	[position_lat] [float] NULL,
	[position_long] [float] NULL,
	[distance] [float] NULL,
	[cadence] [int] NULL,
	[altitude] [float] NULL,
	[hr] [int] NULL,
	[rr] [float] NULL,
	[speed] [float] NULL,
	[temperature] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminActivities/ActivityRecords_timestamp] ON [src].[GarminActivities/ActivityRecords]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
