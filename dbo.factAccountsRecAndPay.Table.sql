USE [PBI]
GO
/****** Object:  Table [dbo].[factAccountsRecAndPay]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factAccountsRecAndPay](
	[DateId] [int] NOT NULL,
	[TypId] [int] NOT NULL,
	[StatusEnforcmentId] [int] NOT NULL,
	[SpeciesTypeId] [int] NOT NULL,
	[CostCenterId] [int] NOT NULL,
	[ReferenceNumber] [nvarchar](50) NOT NULL,
	[CategoryId1] [int] NULL,
	[CategoryId2] [int] NULL,
	[Amount] [float] NULL,
	[SourceId] [int] NOT NULL,
 CONSTRAINT [PK_factAccountsRecAndPay] PRIMARY KEY CLUSTERED 
(
	[DateId] ASC,
	[TypId] ASC,
	[StatusEnforcmentId] ASC,
	[SpeciesTypeId] ASC,
	[CostCenterId] ASC,
	[ReferenceNumber] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factAccountsRecAndPay]  WITH CHECK ADD  CONSTRAINT [FK_factAccountsRecAndPay_dimCommitmentType] FOREIGN KEY([TypId])
REFERENCES [dbo].[dimCommitmentType] ([CommitmentTypeId])
GO
ALTER TABLE [dbo].[factAccountsRecAndPay] CHECK CONSTRAINT [FK_factAccountsRecAndPay_dimCommitmentType]
GO
ALTER TABLE [dbo].[factAccountsRecAndPay]  WITH CHECK ADD  CONSTRAINT [FK_factAccountsRecAndPay_dimCostCenter] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[dimCostCenter] ([CostCenterId])
GO
ALTER TABLE [dbo].[factAccountsRecAndPay] CHECK CONSTRAINT [FK_factAccountsRecAndPay_dimCostCenter]
GO
ALTER TABLE [dbo].[factAccountsRecAndPay]  WITH CHECK ADD  CONSTRAINT [FK_factAccountsRecAndPay_dimDate] FOREIGN KEY([DateId])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factAccountsRecAndPay] CHECK CONSTRAINT [FK_factAccountsRecAndPay_dimDate]
GO
ALTER TABLE [dbo].[factAccountsRecAndPay]  WITH CHECK ADD  CONSTRAINT [FK_factAccountsRecAndPay_dimSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[dimSource] ([SourceId])
GO
ALTER TABLE [dbo].[factAccountsRecAndPay] CHECK CONSTRAINT [FK_factAccountsRecAndPay_dimSource]
GO
ALTER TABLE [dbo].[factAccountsRecAndPay]  WITH CHECK ADD  CONSTRAINT [FK_factAccountsRecAndPay_dimSpeciesType] FOREIGN KEY([SpeciesTypeId])
REFERENCES [dbo].[dimSpeciesType] ([SpeciesTypeId])
GO
ALTER TABLE [dbo].[factAccountsRecAndPay] CHECK CONSTRAINT [FK_factAccountsRecAndPay_dimSpeciesType]
GO
ALTER TABLE [dbo].[factAccountsRecAndPay]  WITH CHECK ADD  CONSTRAINT [FK_factAccountsRecAndPay_dimStatusEnforcment] FOREIGN KEY([StatusEnforcmentId])
REFERENCES [dbo].[dimStatusEnforcment] ([StatusEnforcmentId])
GO
ALTER TABLE [dbo].[factAccountsRecAndPay] CHECK CONSTRAINT [FK_factAccountsRecAndPay_dimStatusEnforcment]
GO
