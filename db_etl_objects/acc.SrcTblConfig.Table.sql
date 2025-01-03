USE [garmin]
GO
DROP TABLE IF EXISTS [acc].[SrcTblConfig]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [acc].[SrcTblConfig](
	[Domain] [nvarchar](50) NOT NULL,
	[TableName] [nvarchar](50) NOT NULL,
	[SchemaName] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL
) ON [PRIMARY]
GO
