USE [garmin]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringIntensity_timestamp] ON [src].[GarminMonitoring/MonitoringIntensity] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringIntensity]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringIntensity](
	[timestamp] [datetime2](7) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringIntensity_timestamp] ON [src].[GarminMonitoring/MonitoringIntensity]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
