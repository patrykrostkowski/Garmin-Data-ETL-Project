USE [garmin]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[stress](
	[timestamp] [datetime2](7) NULL,
	[stress] [int] NULL
) ON [PRIMARY]
GO
