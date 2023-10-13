-- #######################################################
USE [garmin]
CREATE TABLE [dbo].[config] ([TableName] [nchar](20) NULL,
	[SchemaName] [nchar](10) NULL,
	[IsActive] [nchar](1) NULL) ON [PRIMARY]
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'daily_summary       ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'resting_hr          ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'sleep               ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'sleep_events        ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'stress              ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'weight              ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'_attributes         ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'attributes          ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'device_info         ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'devices             ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'files               ', N'src       ', N'N')
GO

-- #######################################################
USE [garmin_activities]
CREATE TABLE [dbo].[config] ([TableName] [nchar](20) NULL,
	[SchemaName] [nchar](10) NULL,
	[IsActive] [nchar](1) NULL) ON [PRIMARY]
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'_attributes         ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'activities          ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'activities_devices  ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'activity_laps       ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'activity_records    ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'cycle_activities    ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'paddle_activities   ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'steps_activities    ', N'src       ', N'Y')
GO

-- #######################################################
USE [garmin_monitoring]
CREATE TABLE [dbo].[config] ([TableName] [nchar](20) NULL,
	[SchemaName] [nchar](10) NULL,
	[IsActive] [nchar](1) NULL) ON [PRIMARY]
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'_attributes         ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring          ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring_climb    ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring_hr       ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring_info     ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring_intensity', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring_pulse_ox ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'monitoring_rr       ', N'src       ', N'Y')
GO

-- #######################################################
USE [garmin_summary]
CREATE TABLE [dbo].[config] ([TableName] [nchar](20) NULL,
	[SchemaName] [nchar](10) NULL,
	[IsActive] [nchar](1) NULL) ON [PRIMARY]
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'_attributes         ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'days_summary        ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'intensity_hr        ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'months_summary      ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'summary             ', N'src       ', N'N')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'weeks_summary       ', N'src       ', N'Y')
GO
INSERT [dbo].[config]([TableName], [SchemaName], [IsActive])
VALUES(N'years_summary       ', N'src       ', N'Y')
GO