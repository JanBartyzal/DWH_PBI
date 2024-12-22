USE [PBI]
GO
/****** Object:  Table [dbo].[stgCFZavazky]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgCFZavazky](
	[Typ] [nvarchar](50) NULL,
	[Mena] [nvarchar](3) NULL,
	[DatumSplatnosti] [date] NULL,
	[Castka] [float] NULL,
	[Status] [int] NULL,
	[Zdroj] [nvarchar](50) NULL
) ON [PRIMARY]
GO
