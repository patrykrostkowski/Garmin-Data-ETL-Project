USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activities_devices](
	[activity_id] [nvarchar](255) NULL,
	[device_serial_number] [int] NULL
) ON [PRIMARY]
GO
