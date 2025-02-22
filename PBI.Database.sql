USE [master]
GO
/****** Object:  Database [PBI]    Script Date: 22.12.2024 18:08:36 ******/
CREATE DATABASE [PBI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PBI', FILENAME = N'F:\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\PBI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PBI_log', FILENAME = N'F:\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\PBI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PBI] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PBI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PBI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PBI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PBI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PBI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PBI] SET ARITHABORT OFF 
GO
ALTER DATABASE [PBI] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PBI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PBI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PBI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PBI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PBI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PBI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PBI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PBI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PBI] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PBI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PBI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PBI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PBI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PBI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PBI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PBI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PBI] SET RECOVERY FULL 
GO
ALTER DATABASE [PBI] SET  MULTI_USER 
GO
ALTER DATABASE [PBI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PBI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PBI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PBI] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PBI] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PBI] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PBI', N'ON'
GO
ALTER DATABASE [PBI] SET QUERY_STORE = OFF
GO
ALTER DATABASE [PBI] SET  READ_WRITE 
GO
