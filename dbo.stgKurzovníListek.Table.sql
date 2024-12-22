USE [PBI]
GO
/****** Object:  Table [dbo].[stgKurzovníListek]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stgKurzovníListek](
	[Datum] [date] NULL,
	[Mena] [nvarchar](5) NULL,
	[Kurz] [float] NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
