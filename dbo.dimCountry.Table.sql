USE [PBI]
GO
/****** Object:  Table [dbo].[dimCountry]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimCountry](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryCode] [nvarchar](3) NULL,
	[CountryName] [nvarchar](255) NULL,
	[CountryContinentId] [int] NULL,
	[CountryRegionId] [int] NULL,
	[CountryCurrencyId] [int] NULL,
 CONSTRAINT [PK_dimCountry] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimCountry]  WITH CHECK ADD  CONSTRAINT [FK_dimCountry_dimCountryContinent] FOREIGN KEY([CountryContinentId])
REFERENCES [dbo].[dimCountryContinent] ([CountryContinentId])
GO
ALTER TABLE [dbo].[dimCountry] CHECK CONSTRAINT [FK_dimCountry_dimCountryContinent]
GO
ALTER TABLE [dbo].[dimCountry]  WITH CHECK ADD  CONSTRAINT [FK_dimCountry_dimCountryRegion] FOREIGN KEY([CountryRegionId])
REFERENCES [dbo].[dimCountryRegion] ([CountryRegionId])
GO
ALTER TABLE [dbo].[dimCountry] CHECK CONSTRAINT [FK_dimCountry_dimCountryRegion]
GO
ALTER TABLE [dbo].[dimCountry]  WITH CHECK ADD  CONSTRAINT [FK_dimCountry_dimCurrency] FOREIGN KEY([CountryCurrencyId])
REFERENCES [dbo].[dimCurrency] ([CurrencyId])
GO
ALTER TABLE [dbo].[dimCountry] CHECK CONSTRAINT [FK_dimCountry_dimCurrency]
GO
