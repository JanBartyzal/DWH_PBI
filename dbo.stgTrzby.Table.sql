USE [PBI]
GO
/****** Object:  Table [dbo].[stgTrzby]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgTrzby](
	[ICO] [nvarchar](50) NULL,
	[Nazev] [nvarchar](250) NULL,
	[KodUsek] [nvarchar](50) NULL,
	[KodNS] [nvarchar](50) NULL,
	[KodStat] [nvarchar](3) NULL,
	[Datum] [date] NULL,
	[Mena] [nvarchar](3) NULL,
	[ReferencniCislo] [nvarchar](50) NULL,
	[Castka] [float] NULL,
	[Status] [int] NULL,
	[Zdroj] [nvarchar](50) NULL
) ON [PRIMARY]
GO
