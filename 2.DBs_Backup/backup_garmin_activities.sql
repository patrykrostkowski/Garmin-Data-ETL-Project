USE [master]
GO
/****** Object:  Database [garmin_activities]    Script Date: 09.10.2023 11:46:34 ******/
CREATE DATABASE [garmin_activities]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'garmin_activities', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_activities.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'garmin_activities_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_activities_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [garmin_activities] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [garmin_activities].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [garmin_activities] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [garmin_activities] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [garmin_activities] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [garmin_activities] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [garmin_activities] SET ARITHABORT OFF 
GO
ALTER DATABASE [garmin_activities] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [garmin_activities] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [garmin_activities] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [garmin_activities] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [garmin_activities] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [garmin_activities] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [garmin_activities] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [garmin_activities] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [garmin_activities] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [garmin_activities] SET  DISABLE_BROKER 
GO
ALTER DATABASE [garmin_activities] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [garmin_activities] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [garmin_activities] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [garmin_activities] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [garmin_activities] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [garmin_activities] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [garmin_activities] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [garmin_activities] SET RECOVERY FULL 
GO
ALTER DATABASE [garmin_activities] SET  MULTI_USER 
GO
ALTER DATABASE [garmin_activities] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [garmin_activities] SET DB_CHAINING OFF 
GO
ALTER DATABASE [garmin_activities] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [garmin_activities] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [garmin_activities] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [garmin_activities] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'garmin_activities', N'ON'
GO
ALTER DATABASE [garmin_activities] SET QUERY_STORE = OFF
GO
USE [garmin_activities]
GO
/****** Object:  User [test_login]    Script Date: 09.10.2023 11:46:34 ******/
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
/****** Object:  Schema [activities]    Script Date: 09.10.2023 11:46:35 ******/
CREATE SCHEMA [activities]
GO
/****** Object:  Schema [src]    Script Date: 09.10.2023 11:46:35 ******/
CREATE SCHEMA [src]
GO
/****** Object:  View [src].[vw_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_activities]           as select * from openquery(GARMIN_ACTIVITIES,'select * from activities          ')
GO
/****** Object:  View [src].[vw_activities_devices]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_activities_devices]   as select * from openquery(GARMIN_ACTIVITIES,'select * from activities_devices  ')
GO
/****** Object:  View [src].[vw_activity_laps]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_activity_laps]        as select * from openquery(GARMIN_ACTIVITIES,'select * from activity_laps       ')
GO
/****** Object:  View [src].[vw_activity_records]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_activity_records]     as select * from openquery(GARMIN_ACTIVITIES,'select * from activity_records    ')
GO
/****** Object:  View [src].[vw_cycle_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_cycle_activities]     as select * from openquery(GARMIN_ACTIVITIES,'select * from cycle_activities    ')
GO
/****** Object:  View [src].[vw_paddle_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_paddle_activities]    as select * from openquery(GARMIN_ACTIVITIES,'select * from paddle_activities   ')
GO
/****** Object:  View [src].[vw_steps_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_steps_activities]     as select * from openquery(GARMIN_ACTIVITIES,'select * from steps_activities    ')
GO
/****** Object:  Table [dbo].[config]    Script Date: 09.10.2023 11:46:35 ******/
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
/****** Object:  Table [src].[activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activities](
	[activity_id] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[type] [nvarchar](255) NULL,
	[course_id] [int] NULL,
	[laps] [int] NULL,
	[sport] [nvarchar](255) NULL,
	[sub_sport] [nvarchar](255) NULL,
	[training_effect] [float] NULL,
	[anaerobic_training_effect] [float] NULL,
	[start_time] [datetime2](7) NULL,
	[stop_time] [datetime2](7) NULL,
	[elapsed_time] [time](0) NULL,
	[moving_time] [time](0) NULL,
	[distance] [float] NULL,
	[cycles] [float] NULL,
	[avg_hr] [int] NULL,
	[max_hr] [int] NULL,
	[avg_rr] [float] NULL,
	[max_rr] [float] NULL,
	[calories] [int] NULL,
	[avg_cadence] [int] NULL,
	[max_cadence] [int] NULL,
	[avg_speed] [float] NULL,
	[max_speed] [float] NULL,
	[ascent] [float] NULL,
	[descent] [float] NULL,
	[max_temperature] [float] NULL,
	[min_temperature] [float] NULL,
	[avg_temperature] [float] NULL,
	[start_lat] [float] NULL,
	[start_long] [float] NULL,
	[stop_lat] [float] NULL,
	[stop_long] [float] NULL,
	[hr_zones_method] [nvarchar](18) NULL,
	[hrz_1_hr] [int] NULL,
	[hrz_2_hr] [int] NULL,
	[hrz_3_hr] [int] NULL,
	[hrz_4_hr] [int] NULL,
	[hrz_5_hr] [int] NULL,
	[hrz_1_time] [time](0) NULL,
	[hrz_2_time] [time](0) NULL,
	[hrz_3_time] [time](0) NULL,
	[hrz_4_time] [time](0) NULL,
	[hrz_5_time] [time](0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[activities_devices]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activities_devices](
	[activity_id] [nvarchar](255) NULL,
	[device_serial_number] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[activity_laps]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activity_laps](
	[activity_id] [nvarchar](255) NULL,
	[lap] [int] NULL,
	[start_time] [datetime2](7) NULL,
	[stop_time] [datetime2](7) NULL,
	[elapsed_time] [time](0) NULL,
	[moving_time] [time](0) NULL,
	[distance] [float] NULL,
	[cycles] [float] NULL,
	[avg_hr] [int] NULL,
	[max_hr] [int] NULL,
	[avg_rr] [float] NULL,
	[max_rr] [float] NULL,
	[calories] [int] NULL,
	[avg_cadence] [int] NULL,
	[max_cadence] [int] NULL,
	[avg_speed] [float] NULL,
	[max_speed] [float] NULL,
	[ascent] [float] NULL,
	[descent] [float] NULL,
	[max_temperature] [float] NULL,
	[min_temperature] [float] NULL,
	[avg_temperature] [float] NULL,
	[start_lat] [float] NULL,
	[start_long] [float] NULL,
	[stop_lat] [float] NULL,
	[stop_long] [float] NULL,
	[hr_zones_method] [nvarchar](18) NULL,
	[hrz_1_hr] [int] NULL,
	[hrz_2_hr] [int] NULL,
	[hrz_3_hr] [int] NULL,
	[hrz_4_hr] [int] NULL,
	[hrz_5_hr] [int] NULL,
	[hrz_1_time] [time](0) NULL,
	[hrz_2_time] [time](0) NULL,
	[hrz_3_time] [time](0) NULL,
	[hrz_4_time] [time](0) NULL,
	[hrz_5_time] [time](0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[activity_records]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[activity_records](
	[activity_id] [nvarchar](255) NULL,
	[record] [int] NULL,
	[timestamp] [datetime2](7) NULL,
	[position_lat] [float] NULL,
	[position_long] [float] NULL,
	[distance] [float] NULL,
	[cadence] [int] NULL,
	[altitude] [float] NULL,
	[hr] [int] NULL,
	[rr] [float] NULL,
	[speed] [float] NULL,
	[temperature] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[cycle_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[cycle_activities](
	[strokes] [int] NULL,
	[vo2_max] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[paddle_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[paddle_activities](
	[strokes] [int] NULL,
	[avg_stroke_distance] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[steps_activities]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[steps_activities](
	[steps] [int] NULL,
	[avg_pace] [time](0) NULL,
	[avg_moving_pace] [time](0) NULL,
	[max_pace] [time](0) NULL,
	[avg_steps_per_min] [int] NULL,
	[max_steps_per_min] [int] NULL,
	[avg_step_length] [float] NULL,
	[avg_vertical_ratio] [float] NULL,
	[avg_vertical_oscillation] [float] NULL,
	[avg_gct_balance] [float] NULL,
	[avg_ground_contact_time] [time](0) NULL,
	[avg_stance_time_percent] [float] NULL,
	[vo2_max] [float] NULL,
	[activity_id] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[p_create_src_views]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_create_src_views]
as

declare @linkedserver nvarchar(20) = 'GARMIN_ACTIVITIES'
declare @cursor cursor;
declare @tablename nvarchar(30);
declare @schemaname nvarchar(20);

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
/****** Object:  StoredProcedure [dbo].[p_populate_src_tables]    Script Date: 09.10.2023 11:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
        exec ('select * into '+@schemaname+'.'+ @tablename + ' from '+@schemaname+'.' + @viewname);
		fetch next from @cursor
		into @viewname, @tablename, @schemaname
    end;

    close @cursor;
    deallocate @cursor;
end
GO
USE [master]
GO
ALTER DATABASE [garmin_activities] SET  READ_WRITE 
GO
