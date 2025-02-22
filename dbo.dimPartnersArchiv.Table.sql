USE [PBI]
GO
/****** Object:  Table [dbo].[dimPartnersArchiv]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimPartnersArchiv](
	[PartnerId] [int] NOT NULL,
	[PartnerICO] [nvarchar](50) NULL,
	[PartnerName] [nvarchar](255) NULL,
	[PartnerAdress1] [nvarchar](255) NULL,
	[PartnerAdress2] [nvarchar](255) NULL,
	[PartnerCity] [nvarchar](255) NULL,
	[PartnerPostCode] [nvarchar](10) NULL,
	[PartnerCountryId] [int] NULL,
	[PartnerActive] [int] NULL,
	[PartnerTimeStamp] [datetime] NULL,
	[DateId] [int] NULL
) ON [PRIMARY]
GO
