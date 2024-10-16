USE [garmin]
GO
DROP INDEX IF EXISTS [IX_GarminMonitoring/MonitoringRr_timestamp] ON [src].[GarminMonitoring/MonitoringRr] WITH ( ONLINE = OFF )
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringRr]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringRr](
	[timestamp] [datetime2](7) NULL,
	[rr] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [IX_GarminMonitoring/MonitoringRr_timestamp] ON [src].[GarminMonitoring/MonitoringRr]
(
	[timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
