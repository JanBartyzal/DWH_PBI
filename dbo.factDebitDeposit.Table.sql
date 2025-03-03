USE [PBI]
GO
/****** Object:  Table [dbo].[factDebitDeposit]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factDebitDeposit](
	[DateID] [int] NOT NULL,
	[CommitmentTypeId] [int] NOT NULL,
	[CostCenterId] [int] NOT NULL,
	[Amount] [float] NULL,
	[SourceId] [int] NOT NULL,
 CONSTRAINT [PK_factDebitDeposit_1] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[CommitmentTypeId] ASC,
	[CostCenterId] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factDebitDeposit]  WITH CHECK ADD  CONSTRAINT [FK_factDebitDeposit_dimCommitmentType] FOREIGN KEY([CommitmentTypeId])
REFERENCES [dbo].[dimCommitmentType] ([CommitmentTypeId])
GO
ALTER TABLE [dbo].[factDebitDeposit] CHECK CONSTRAINT [FK_factDebitDeposit_dimCommitmentType]
GO
ALTER TABLE [dbo].[factDebitDeposit]  WITH CHECK ADD  CONSTRAINT [FK_factDebitDeposit_dimCostCenter] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[dimCostCenter] ([CostCenterId])
GO
ALTER TABLE [dbo].[factDebitDeposit] CHECK CONSTRAINT [FK_factDebitDeposit_dimCostCenter]
GO
ALTER TABLE [dbo].[factDebitDeposit]  WITH CHECK ADD  CONSTRAINT [FK_factDebitDeposit_dimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factDebitDeposit] CHECK CONSTRAINT [FK_factDebitDeposit_dimDate]
GO
ALTER TABLE [dbo].[factDebitDeposit]  WITH CHECK ADD  CONSTRAINT [FK_factDebitDeposit_dimSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[dimSource] ([SourceId])
GO
ALTER TABLE [dbo].[factDebitDeposit] CHECK CONSTRAINT [FK_factDebitDeposit_dimSource]
GO
