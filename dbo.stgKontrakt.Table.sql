USE [PBI]
GO
/****** Object:  Table [dbo].[stgKontrakt]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgKontrakt](
	[ICO] [nvarchar](50) NULL,
	[Nazev] [nvarchar](250) NULL,
	[KodUsek] [nvarchar](50) NULL,
	[KodNS] [nvarchar](50) NULL,
	[KodStat] [nvarchar](3) NULL,
	[Datum] [date] NULL,
	[Mena] [nvarchar](3) NULL,
	[Castka] [float] NULL,
	[ReferencniCislo] [nvarchar](50) NULL,
	[ReferentName] [nvarchar](250) NULL,
	[ReferentKod] [nvarchar](50) NULL,
	[Naklady1] [float] NULL,
	[PK] [float] NULL,
	[Naklady2] [float] NULL,
	[Marze] [float] NULL,
	[Status] [int] NULL,
	[Zdroj] [nvarchar](50) NULL
) ON [PRIMARY]
GO
