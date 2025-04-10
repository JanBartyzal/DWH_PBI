USE [PBI]
GO
/****** Object:  Table [dbo].[stgPohledavkyZavazky]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgPohledavkyZavazky](
	[Datum] [date] NULL,
	[Typ] [nvarchar](50) NULL,
	[Stav] [nvarchar](50) NULL,
	[Druh] [nvarchar](50) NULL,
	[KodUsek] [nvarchar](50) NULL,
	[KodNS] [nvarchar](50) NULL,
	[ReferencniCislo] [nvarchar](50) NULL,
	[Kategorie1] [nvarchar](50) NULL,
	[Kategorie2] [nvarchar](50) NULL,
	[Castka] [float] NULL,
	[Status] [int] NULL,
	[Zdroj] [nvarchar](50) NULL
) ON [PRIMARY]
GO
