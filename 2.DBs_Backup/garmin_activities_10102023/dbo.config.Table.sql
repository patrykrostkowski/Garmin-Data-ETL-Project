USE [garmin_activities]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[config](
	[TableName] [nchar](20) NULL,
	[SchemaName] [nchar](10) NULL,
	[IsActive] [nchar](1) NULL
) ON [PRIMARY]
GO
