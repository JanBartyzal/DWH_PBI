USE [PBI]
GO
/****** Object:  Table [dbo].[factContracts]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factContracts](
	[DateID] [int] NOT NULL,
	[PartnerId] [int] NOT NULL,
	[CostCenterId] [int] NOT NULL,
	[CountryId] [int] NULL,
	[CurrencyId] [int] NULL,
	[ReferenceNumber] [nvarchar](50) NOT NULL,
	[Amount] [float] NULL,
	[ReferentId] [int] NULL,
	[Costs1] [float] NULL,
	[PK] [float] NULL,
	[Costs2] [float] NULL,
	[Margin] [float] NULL,
	[SourceId] [int] NOT NULL,
 CONSTRAINT [PK_factContracts] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[PartnerId] ASC,
	[CostCenterId] ASC,
	[ReferenceNumber] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factContracts]  WITH CHECK ADD  CONSTRAINT [FK_factContracts_dimCostCenter] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[dimCostCenter] ([CostCenterId])
GO
ALTER TABLE [dbo].[factContracts] CHECK CONSTRAINT [FK_factContracts_dimCostCenter]
GO
ALTER TABLE [dbo].[factContracts]  WITH CHECK ADD  CONSTRAINT [FK_factContracts_dimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factContracts] CHECK CONSTRAINT [FK_factContracts_dimDate]
GO
ALTER TABLE [dbo].[factContracts]  WITH CHECK ADD  CONSTRAINT [FK_factContracts_dimPartners] FOREIGN KEY([PartnerId])
REFERENCES [dbo].[dimPartners] ([PartnerId])
GO
ALTER TABLE [dbo].[factContracts] CHECK CONSTRAINT [FK_factContracts_dimPartners]
GO
ALTER TABLE [dbo].[factContracts]  WITH CHECK ADD  CONSTRAINT [FK_factContracts_dimSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[dimSource] ([SourceId])
GO
ALTER TABLE [dbo].[factContracts] CHECK CONSTRAINT [FK_factContracts_dimSource]
GO
