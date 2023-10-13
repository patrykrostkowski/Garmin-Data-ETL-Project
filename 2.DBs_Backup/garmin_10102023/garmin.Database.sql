﻿USE [master]
GO
CREATE DATABASE [garmin]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'garmin', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'garmin_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\garmin_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [garmin].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [garmin] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [garmin] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [garmin] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [garmin] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [garmin] SET ARITHABORT OFF 
GO
ALTER DATABASE [garmin] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [garmin] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [garmin] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [garmin] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [garmin] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [garmin] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [garmin] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [garmin] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [garmin] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [garmin] SET  DISABLE_BROKER 
GO
ALTER DATABASE [garmin] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [garmin] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [garmin] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [garmin] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [garmin] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [garmin] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [garmin] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [garmin] SET RECOVERY FULL 
GO
ALTER DATABASE [garmin] SET  MULTI_USER 
GO
ALTER DATABASE [garmin] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [garmin] SET DB_CHAINING OFF 
GO
ALTER DATABASE [garmin] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [garmin] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [garmin] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'garmin', N'ON'
GO
ALTER DATABASE [garmin] SET QUERY_STORE = OFF
GO
USE [garmin]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE [garmin] SET  READ_WRITE 
GO
