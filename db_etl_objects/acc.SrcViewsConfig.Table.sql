USE [garmin]
GO
DROP TABLE IF EXISTS [acc].[SrcViewsConfig]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [acc].[SrcViewsConfig](
	[SchemaName] [nvarchar](100) NOT NULL,
	[ViewName] [nvarchar](100) NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[PrimaryColumnName] [nvarchar](100) NOT NULL,
	[IsActiveInd] [int] NULL,
	[MergeType] [nvarchar](50) NULL
) ON [PRIMARY]
GO
