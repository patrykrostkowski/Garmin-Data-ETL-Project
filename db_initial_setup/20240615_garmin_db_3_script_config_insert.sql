USE [garmin]
GO
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'daily_summary', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'resting_hr', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'sleep', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'sleep_events', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'stress', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'weight', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'_attributes', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'attributes', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'device_info', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'devices', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin', N'files', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'_attributes', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'activities', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'activities_devices', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'activity_laps', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'activity_records', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'cycle_activities', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'paddle_activities', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_activities', N'steps_activities', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'_attributes', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring_climb', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring_hr', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring_info', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring_intensity', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring_pulse_ox', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_monitoring', N'monitoring_rr', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'_attributes', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'days_summary', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'intensity_hr', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'months_summary', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'summary', N'src', 0)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'weeks_summary', N'src', 1)
INSERT [acc].[SrcTblConfig] ([Domain], [TableName], [SchemaName], [IsActive]) VALUES (N'garmin_summary', N'years_summary', N'src', 1)
GO
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarmin/DailySummary', N'Garmin/DailySummary', N'day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarmin/RestingHr', N'Garmin/RestingHr', N'day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarmin/Sleep', N'Garmin/Sleep', N'day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarmin/SleepEvents', N'Garmin/SleepEvents', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarmin/Stress', N'Garmin/Stress', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarmin/Weight', N'Garmin/Weight', N'day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminActivities/Activities', N'GarminActivities/Activities', N'start_time', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminActivities/ActivityLaps', N'GarminActivities/ActivityLaps', N'start_time', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminActivities/ActivityRecords', N'GarminActivities/ActivityRecords', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminActivities/CycleActivities', N'GarminActivities/CycleActivities', N'activity_id', 1, N'manual')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminActivities/PaddleActivities', N'GarminActivities/PaddleActivities', N'activity_id', 1, N'manual')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminActivities/StepsActivities', N'GarminActivities/StepsActivities', N'activity_id', 1, N'manual')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/Monitoring', N'GarminMonitoring/Monitoring', N'timestamp', 1, N'exception')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/MonitoringClimb', N'GarminMonitoring/MonitoringClimb', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/MonitoringHr', N'GarminMonitoring/MonitoringHr', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/MonitoringInfo', N'GarminMonitoring/MonitoringInfo', N'timestamp', 1, N'manual')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/MonitoringIntensity', N'GarminMonitoring/MonitoringIntensity', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/MonitoringPulseOx', N'GarminMonitoring/MonitoringPulseOx', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminMonitoring/MonitoringRr', N'GarminMonitoring/MonitoringRr', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminSummary/DaysSummary', N'GarminSummary/DaysSummary', N'day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminSummary/IntensityHr', N'GarminSummary/IntensityHr', N'timestamp', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminSummary/MonthsSummary', N'GarminSummary/MonthsSummary', N'first_day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminSummary/WeeksSummary', N'GarminSummary/WeeksSummary', N'first_day', 1, N'dynamic')
INSERT [acc].[SrcViewsConfig] ([SchemaName], [ViewName], [TableName], [PrimaryColumnName], [IsActiveInd], [MergeType]) VALUES (N'src', N'vwGarminSummary/YearsSummary', N'GarminSummary/YearsSummary', N'first_day', 1, N'dynamic')
GO
