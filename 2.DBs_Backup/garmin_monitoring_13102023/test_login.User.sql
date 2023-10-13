USE [garmin_monitoring]
GO
CREATE USER [test_login] FOR LOGIN [test_login] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [test_login]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [test_login]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [test_login]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [test_login]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [test_login]
GO
ALTER ROLE [db_datareader] ADD MEMBER [test_login]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [test_login]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [test_login]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [test_login]
GO
