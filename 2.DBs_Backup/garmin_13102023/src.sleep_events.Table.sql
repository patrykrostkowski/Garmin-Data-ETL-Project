USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[sleep_events](
	[timestamp] [datetime2](7) NULL,
	[event] [nvarchar](255) NULL,
	[duration] [time](0) NULL
) ON [PRIMARY]
GO
