USE [master]
GO
/****** Object:  Database [garmin_summary]    Script Date: 09.10.2023 11:47:46 ******/
CREATE DATABASE [garmin_summary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'garmin_summary', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_summary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'garmin_summary_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_summary_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [garmin_summary] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [garmin_summary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [garmin_summary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [garmin_summary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [garmin_summary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [garmin_summary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [garmin_summary] SET ARITHABORT OFF 
GO
ALTER DATABASE [garmin_summary] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [garmin_summary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [garmin_summary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [garmin_summary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [garmin_summary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [garmin_summary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [garmin_summary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [garmin_summary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [garmin_summary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [garmin_summary] SET  DISABLE_BROKER 
GO
ALTER DATABASE [garmin_summary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [garmin_summary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [garmin_summary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [garmin_summary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [garmin_summary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [garmin_summary] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [garmin_summary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [garmin_summary] SET RECOVERY FULL 
GO
ALTER DATABASE [garmin_summary] SET  MULTI_USER 
GO
ALTER DATABASE [garmin_summary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [garmin_summary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [garmin_summary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [garmin_summary] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [garmin_summary] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [garmin_summary] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'garmin_summary', N'ON'
GO
ALTER DATABASE [garmin_summary] SET QUERY_STORE = OFF
GO
USE [garmin_summary]
GO
/****** Object:  User [test_login]    Script Date: 09.10.2023 11:47:46 ******/
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
/****** Object:  Schema [src]    Script Date: 09.10.2023 11:47:46 ******/
CREATE SCHEMA [src]
GO
/****** Object:  Schema [summary]    Script Date: 09.10.2023 11:47:46 ******/
CREATE SCHEMA [summary]
GO
/****** Object:  View [src].[vw_days_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_days_summary]         as select * from openquery(garmin_summary,'select * from days_summary        ')
GO
/****** Object:  View [src].[vw_intensity_hr]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_intensity_hr]         as select * from openquery(garmin_summary,'select * from intensity_hr        ')
GO
/****** Object:  View [src].[vw_months_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_months_summary]       as select * from openquery(garmin_summary,'select * from months_summary      ')
GO
/****** Object:  View [src].[vw_weeks_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_weeks_summary]        as select * from openquery(garmin_summary,'select * from weeks_summary       ')
GO
/****** Object:  View [src].[vw_years_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_years_summary]        as select * from openquery(garmin_summary,'select * from years_summary       ')
GO
/****** Object:  Table [dbo].[config]    Script Date: 09.10.2023 11:47:46 ******/
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
/****** Object:  Table [src].[days_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[days_summary](
	[day] [date] NULL,
	[hr_avg] [float] NULL,
	[hr_min] [float] NULL,
	[hr_max] [float] NULL,
	[rhr_avg] [float] NULL,
	[rhr_min] [float] NULL,
	[rhr_max] [float] NULL,
	[inactive_hr_avg] [float] NULL,
	[inactive_hr_min] [float] NULL,
	[inactive_hr_max] [float] NULL,
	[weight_avg] [float] NULL,
	[weight_min] [float] NULL,
	[weight_max] [float] NULL,
	[intensity_time] [time](0) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[steps] [int] NULL,
	[steps_goal] [int] NULL,
	[floors] [float] NULL,
	[floors_goal] [float] NULL,
	[sleep_avg] [time](0) NULL,
	[sleep_min] [time](0) NULL,
	[sleep_max] [time](0) NULL,
	[rem_sleep_avg] [time](0) NULL,
	[rem_sleep_min] [time](0) NULL,
	[rem_sleep_max] [time](0) NULL,
	[stress_avg] [int] NULL,
	[calories_avg] [int] NULL,
	[calories_bmr_avg] [int] NULL,
	[calories_active_avg] [int] NULL,
	[calories_goal] [int] NULL,
	[calories_consumed_avg] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_avg] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss_avg] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[intensity_hr]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[intensity_hr](
	[timestamp] [datetime2](7) NULL,
	[intensity] [int] NULL,
	[heart_rate] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[months_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[months_summary](
	[first_day] [date] NULL,
	[hr_avg] [float] NULL,
	[hr_min] [float] NULL,
	[hr_max] [float] NULL,
	[rhr_avg] [float] NULL,
	[rhr_min] [float] NULL,
	[rhr_max] [float] NULL,
	[inactive_hr_avg] [float] NULL,
	[inactive_hr_min] [float] NULL,
	[inactive_hr_max] [float] NULL,
	[weight_avg] [float] NULL,
	[weight_min] [float] NULL,
	[weight_max] [float] NULL,
	[intensity_time] [time](0) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[steps] [int] NULL,
	[steps_goal] [int] NULL,
	[floors] [float] NULL,
	[floors_goal] [float] NULL,
	[sleep_avg] [time](0) NULL,
	[sleep_min] [time](0) NULL,
	[sleep_max] [time](0) NULL,
	[rem_sleep_avg] [time](0) NULL,
	[rem_sleep_min] [time](0) NULL,
	[rem_sleep_max] [time](0) NULL,
	[stress_avg] [int] NULL,
	[calories_avg] [int] NULL,
	[calories_bmr_avg] [int] NULL,
	[calories_active_avg] [int] NULL,
	[calories_goal] [int] NULL,
	[calories_consumed_avg] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_avg] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss_avg] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[weeks_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[weeks_summary](
	[first_day] [date] NULL,
	[hr_avg] [float] NULL,
	[hr_min] [float] NULL,
	[hr_max] [float] NULL,
	[rhr_avg] [float] NULL,
	[rhr_min] [float] NULL,
	[rhr_max] [float] NULL,
	[inactive_hr_avg] [float] NULL,
	[inactive_hr_min] [float] NULL,
	[inactive_hr_max] [float] NULL,
	[weight_avg] [float] NULL,
	[weight_min] [float] NULL,
	[weight_max] [float] NULL,
	[intensity_time] [time](0) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[steps] [int] NULL,
	[steps_goal] [int] NULL,
	[floors] [float] NULL,
	[floors_goal] [float] NULL,
	[sleep_avg] [time](0) NULL,
	[sleep_min] [time](0) NULL,
	[sleep_max] [time](0) NULL,
	[rem_sleep_avg] [time](0) NULL,
	[rem_sleep_min] [time](0) NULL,
	[rem_sleep_max] [time](0) NULL,
	[stress_avg] [int] NULL,
	[calories_avg] [int] NULL,
	[calories_bmr_avg] [int] NULL,
	[calories_active_avg] [int] NULL,
	[calories_goal] [int] NULL,
	[calories_consumed_avg] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_avg] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss_avg] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[years_summary]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[years_summary](
	[first_day] [date] NULL,
	[hr_avg] [float] NULL,
	[hr_min] [float] NULL,
	[hr_max] [float] NULL,
	[rhr_avg] [float] NULL,
	[rhr_min] [float] NULL,
	[rhr_max] [float] NULL,
	[inactive_hr_avg] [float] NULL,
	[inactive_hr_min] [float] NULL,
	[inactive_hr_max] [float] NULL,
	[weight_avg] [float] NULL,
	[weight_min] [float] NULL,
	[weight_max] [float] NULL,
	[intensity_time] [time](0) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL,
	[intensity_time_goal] [time](0) NULL,
	[steps] [int] NULL,
	[steps_goal] [int] NULL,
	[floors] [float] NULL,
	[floors_goal] [float] NULL,
	[sleep_avg] [time](0) NULL,
	[sleep_min] [time](0) NULL,
	[sleep_max] [time](0) NULL,
	[rem_sleep_avg] [time](0) NULL,
	[rem_sleep_min] [time](0) NULL,
	[rem_sleep_max] [time](0) NULL,
	[stress_avg] [int] NULL,
	[calories_avg] [int] NULL,
	[calories_bmr_avg] [int] NULL,
	[calories_active_avg] [int] NULL,
	[calories_goal] [int] NULL,
	[calories_consumed_avg] [int] NULL,
	[activities] [int] NULL,
	[activities_calories] [int] NULL,
	[activities_distance] [int] NULL,
	[hydration_goal] [int] NULL,
	[hydration_avg] [int] NULL,
	[hydration_intake] [int] NULL,
	[sweat_loss_avg] [int] NULL,
	[sweat_loss] [int] NULL,
	[spo2_avg] [float] NULL,
	[spo2_min] [float] NULL,
	[rr_waking_avg] [float] NULL,
	[rr_max] [float] NULL,
	[rr_min] [float] NULL,
	[bb_max] [int] NULL,
	[bb_min] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[p_create_src_views]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--##########################################################################

CREATE procedure [dbo].[p_create_src_views]
as

declare @linkedserver nvarchar(20) = 'garmin_summary'
declare @cursor cursor;
declare @tablename nvarchar(30);
declare @schemaname nvarchar(10);

begin
    set @cursor = cursor for
    select TableName, SchemaName
    from dbo.config
    where IsActive = 'Y'

    open @cursor
    fetch next from @cursor
    into @tablename, @schemaname

    while @@FETCH_STATUS = 0
    begin

        exec ('create or alter view '+@schemaname+'.vw_' + @tablename + ' as select * from openquery('+@linkedserver+',''select * from ' + @tablename + ''')')

        fetch next from @cursor
        into @tablename, @schemaname
    end
    close @cursor;
    deallocate @cursor;
end
GO
/****** Object:  StoredProcedure [dbo].[p_populate_src_tables]    Script Date: 09.10.2023 11:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--##########################################################################

CREATE procedure [dbo].[p_populate_src_tables]
as

declare @cursor cursor;
declare @viewname nvarchar(30);
declare @tablename nvarchar(30);
declare @schemaname nvarchar(15);

begin
    set @cursor = cursor for
    select table_name as viewname, SUBSTRING(table_name, 4, len(table_name)) as tablename, TABLE_SCHEMA as schemaname
    from INFORMATION_SCHEMA.VIEWS
    where TABLE_SCHEMA = 'src'

    open @cursor
    fetch next from @cursor
    into @viewname, @tablename, @schemaname

    while @@FETCH_STATUS = 0
    begin
		--select @viewname;
		--select @tablename;
        exec ('drop table if exists '+@schemaname+'.' + @tablename);
        exec ('select * into '+@schemaname+'.' + @tablename + ' from '+@schemaname+'.' + @viewname);
		fetch next from @cursor
		into @viewname, @tablename, @schemaname
    end;

    close @cursor;
    deallocate @cursor;
end
GO
USE [master]
GO
ALTER DATABASE [garmin_summary] SET  READ_WRITE 
GO
