USE [PBI]
GO
/****** Object:  Table [dbo].[factSales]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factSales](
	[DateId] [int] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CostCenterId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[ReferenceNumber] [nvarchar](50) NOT NULL,
	[Amount] [float] NULL,
	[SourceId] [int] NOT NULL,
 CONSTRAINT [PK_factSales] PRIMARY KEY CLUSTERED 
(
	[DateId] ASC,
	[PartnerId] ASC,
	[CostCenterId] ASC,
	[CountryId] ASC,
	[CurrencyId] ASC,
	[ReferenceNumber] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factSales]  WITH CHECK ADD  CONSTRAINT [FK_factSales_dimCostCenter] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[dimCostCenter] ([CostCenterId])
GO
ALTER TABLE [dbo].[factSales] CHECK CONSTRAINT [FK_factSales_dimCostCenter]
GO
ALTER TABLE [dbo].[factSales]  WITH CHECK ADD  CONSTRAINT [FK_factSales_dimCountry] FOREIGN KEY([CountryId])
REFERENCES [dbo].[dimCountry] ([CountryId])
GO
ALTER TABLE [dbo].[factSales] CHECK CONSTRAINT [FK_factSales_dimCountry]
GO
ALTER TABLE [dbo].[factSales]  WITH CHECK ADD  CONSTRAINT [FK_factSales_dimCurrency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[dimCurrency] ([CurrencyId])
GO
ALTER TABLE [dbo].[factSales] CHECK CONSTRAINT [FK_factSales_dimCurrency]
GO
ALTER TABLE [dbo].[factSales]  WITH CHECK ADD  CONSTRAINT [FK_factSales_dimDate] FOREIGN KEY([DateId])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factSales] CHECK CONSTRAINT [FK_factSales_dimDate]
GO
ALTER TABLE [dbo].[factSales]  WITH CHECK ADD  CONSTRAINT [FK_factSales_dimPartners] FOREIGN KEY([PartnerId])
REFERENCES [dbo].[dimPartners] ([PartnerId])
GO
ALTER TABLE [dbo].[factSales] CHECK CONSTRAINT [FK_factSales_dimPartners]
GO
ALTER TABLE [dbo].[factSales]  WITH CHECK ADD  CONSTRAINT [FK_factSales_dimSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[dimSource] ([SourceId])
GO
ALTER TABLE [dbo].[factSales] CHECK CONSTRAINT [FK_factSales_dimSource]
GO
