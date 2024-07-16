USE [master]
GO

/****** Object:  LinkedServer [GARMIN]    Script Date: 11/30/2023 9:42:54 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GARMIN', @srvproduct=N'GARMIN', @provider=N'MSDASQL', @datasrc=N'GARMIN'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GARMIN',@useself=N'False',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


USE [master]
GO

/****** Object:  LinkedServer [GARMIN_ACTIVITIES]    Script Date: 11/30/2023 9:43:25 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GARMIN_ACTIVITIES', @srvproduct=N'garmin_activities', @provider=N'MSDASQL', @datasrc=N'garmin_activities'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GARMIN_ACTIVITIES',@useself=N'False',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_ACTIVITIES', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


USE [master]
GO

/****** Object:  LinkedServer [GARMIN_MONITORING]    Script Date: 11/30/2023 9:43:43 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GARMIN_MONITORING', @srvproduct=N'garmin_monitoring', @provider=N'MSDASQL', @datasrc=N'garmin_monitoring'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GARMIN_MONITORING',@useself=N'False',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_MONITORING', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


USE [master]
GO

/****** Object:  LinkedServer [GARMIN_SUMMARY]    Script Date: 11/30/2023 9:44:01 PM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GARMIN_SUMMARY', @srvproduct=N'garmin_summary', @provider=N'MSDASQL', @datasrc=N'garmin_summary'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GARMIN_SUMMARY',@useself=N'False',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GARMIN_SUMMARY', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


