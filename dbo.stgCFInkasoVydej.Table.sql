USE [PBI]
GO
/****** Object:  Table [dbo].[stgCFInkasoVydej]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgCFInkasoVydej](
	[Datum] [date] NULL,
	[TypCF] [nvarchar](50) NULL,
	[KodUsek] [nvarchar](50) NULL,
	[KodNS] [nvarchar](50) NULL,
	[Castka] [float] NULL,
	[Status] [int] NULL,
	[Zdroj] [nvarchar](50) NULL
) ON [PRIMARY]
GO
