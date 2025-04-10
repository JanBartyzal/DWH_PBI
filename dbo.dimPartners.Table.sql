USE [PBI]
GO
/****** Object:  Table [dbo].[dimPartners]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimPartners](
	[PartnerId] [int] IDENTITY(1,1) NOT NULL,
	[PartnerICO] [nvarchar](50) NULL,
	[PartnerName] [nvarchar](255) NULL,
	[PartnerAdress1] [nvarchar](255) NULL,
	[PartnerAdress2] [nvarchar](255) NULL,
	[PartnerCity] [nvarchar](255) NULL,
	[PartnerPostCode] [nvarchar](10) NULL,
	[PartnerCountryId] [int] NULL,
	[PartnerActive] [int] NULL,
 CONSTRAINT [PK_globPartners] PRIMARY KEY CLUSTERED 
(
	[PartnerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimPartners]  WITH CHECK ADD  CONSTRAINT [FK_dimPartners_dimCountry] FOREIGN KEY([PartnerCountryId])
REFERENCES [dbo].[dimCountry] ([CountryId])
GO
ALTER TABLE [dbo].[dimPartners] CHECK CONSTRAINT [FK_dimPartners_dimCountry]
GO
