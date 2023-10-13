USE [master]
GO
/****** Object:  Database [garmin_monitoring]    Script Date: 09.10.2023 11:47:12 ******/
CREATE DATABASE [garmin_monitoring]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'garmin_monitoring', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_monitoring.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'garmin_monitoring_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_monitoring_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [garmin_monitoring] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [garmin_monitoring].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [garmin_monitoring] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [garmin_monitoring] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [garmin_monitoring] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [garmin_monitoring] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [garmin_monitoring] SET ARITHABORT OFF 
GO
ALTER DATABASE [garmin_monitoring] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [garmin_monitoring] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [garmin_monitoring] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [garmin_monitoring] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [garmin_monitoring] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [garmin_monitoring] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [garmin_monitoring] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [garmin_monitoring] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [garmin_monitoring] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [garmin_monitoring] SET  DISABLE_BROKER 
GO
ALTER DATABASE [garmin_monitoring] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [garmin_monitoring] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [garmin_monitoring] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [garmin_monitoring] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [garmin_monitoring] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [garmin_monitoring] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [garmin_monitoring] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [garmin_monitoring] SET RECOVERY FULL 
GO
ALTER DATABASE [garmin_monitoring] SET  MULTI_USER 
GO
ALTER DATABASE [garmin_monitoring] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [garmin_monitoring] SET DB_CHAINING OFF 
GO
ALTER DATABASE [garmin_monitoring] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [garmin_monitoring] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [garmin_monitoring] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [garmin_monitoring] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'garmin_monitoring', N'ON'
GO
ALTER DATABASE [garmin_monitoring] SET QUERY_STORE = OFF
GO
USE [garmin_monitoring]
GO
/****** Object:  User [test_login]    Script Date: 09.10.2023 11:47:12 ******/
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
/****** Object:  Schema [monitoring]    Script Date: 09.10.2023 11:47:12 ******/
CREATE SCHEMA [monitoring]
GO
/****** Object:  Schema [src]    Script Date: 09.10.2023 11:47:12 ******/
CREATE SCHEMA [src]
GO
/****** Object:  View [src].[vw_monitoring]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring]           as select * from openquery(garmin_monitoring,'select * from monitoring          ')
GO
/****** Object:  View [src].[vw_monitoring_climb]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring_climb]     as select * from openquery(garmin_monitoring,'select * from monitoring_climb    ')
GO
/****** Object:  View [src].[vw_monitoring_hr]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring_hr]        as select * from openquery(garmin_monitoring,'select * from monitoring_hr       ')
GO
/****** Object:  View [src].[vw_monitoring_info]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring_info]      as select * from openquery(garmin_monitoring,'select * from monitoring_info     ')
GO
/****** Object:  View [src].[vw_monitoring_intensity]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring_intensity] as select * from openquery(garmin_monitoring,'select * from monitoring_intensity')
GO
/****** Object:  View [src].[vw_monitoring_rr]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [src].[vw_monitoring_rr]        as select * from openquery(garmin_monitoring,'select * from monitoring_rr       ')
GO
/****** Object:  Table [dbo].[config]    Script Date: 09.10.2023 11:47:12 ******/
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
/****** Object:  Table [src].[monitoring]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring](
	[timestamp] [datetime2](7) NULL,
	[activity_type] [nvarchar](17) NULL,
	[intensity] [int] NULL,
	[duration] [time](0) NULL,
	[distance] [float] NULL,
	[cum_active_time] [time](0) NULL,
	[active_calories] [int] NULL,
	[steps] [int] NULL,
	[strokes] [int] NULL,
	[cycles] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[monitoring_climb]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_climb](
	[timestamp] [datetime2](7) NULL,
	[ascent] [float] NULL,
	[descent] [float] NULL,
	[cum_ascent] [float] NULL,
	[cum_descent] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[monitoring_hr]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_hr](
	[timestamp] [datetime2](7) NULL,
	[heart_rate] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[monitoring_info]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_info](
	[timestamp] [datetime2](7) NULL,
	[file_id] [int] NULL,
	[activity_type] [nvarchar](17) NULL,
	[resting_metabolic_rate] [int] NULL,
	[cycles_to_distance] [float] NULL,
	[cycles_to_calories] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[monitoring_intensity]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_intensity](
	[timestamp] [datetime2](7) NULL,
	[moderate_activity_time] [time](0) NULL,
	[vigorous_activity_time] [time](0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [src].[monitoring_rr]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [src].[monitoring_rr](
	[timestamp] [datetime2](7) NULL,
	[rr] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[p_create_src_views]    Script Date: 09.10.2023 11:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[p_create_src_views]
as

declare @linkedserver nvarchar(20) = 'garmin_monitoring'
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
/****** Object:  StoredProcedure [dbo].[p_populate_src_tables]    Script Date: 09.10.2023 11:47:12 ******/
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
ALTER DATABASE [garmin_monitoring] SET  READ_WRITE 
GO
