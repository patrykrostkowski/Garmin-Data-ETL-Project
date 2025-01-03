USE [garmin]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[acc].[LogTable]') AND type in (N'U'))
ALTER TABLE [acc].[LogTable] DROP CONSTRAINT IF EXISTS [DF__LogTable__LoadSt__3793653F]
GO
DROP TABLE IF EXISTS [acc].[LogTable]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [acc].[LogTable](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessType] [nvarchar](100) NULL,
	[LoadStart] [datetime] NULL,
	[LoadEnd] [datetime] NULL,
	[PriorCutOffDate] [date] NULL,
	[CutOffDate] [date] NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [acc].[LogTable] ADD  DEFAULT (getdate()) FOR [LoadStart]
GO
