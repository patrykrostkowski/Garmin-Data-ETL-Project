USE [garmin]
GO
DROP TABLE IF EXISTS [src].[GarminMonitoring/MonitoringInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[GarminMonitoring/MonitoringInfo](
	[timestamp] [datetime2](7) NULL,
	[file_id] [int] NULL,
	[activity_type] [nvarchar](17) NULL,
	[resting_metabolic_rate] [int] NULL,
	[cycles_to_distance] [float] NULL,
	[cycles_to_calories] [float] NULL
) ON [PRIMARY]
GO
