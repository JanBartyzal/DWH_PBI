USE [PBI]
GO
/****** Object:  Table [dbo].[factLiabilities]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factLiabilities](
	[DateID] [int] NOT NULL,
	[CommitmentTypeId] [int] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[Amount] [float] NULL,
	[SourceId] [int] NOT NULL,
 CONSTRAINT [PK_factLiabilities] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[CommitmentTypeId] ASC,
	[CurrencyId] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factLiabilities]  WITH CHECK ADD  CONSTRAINT [FK_factLiabilities_dimCommitmentType] FOREIGN KEY([CommitmentTypeId])
REFERENCES [dbo].[dimCommitmentType] ([CommitmentTypeId])
GO
ALTER TABLE [dbo].[factLiabilities] CHECK CONSTRAINT [FK_factLiabilities_dimCommitmentType]
GO
ALTER TABLE [dbo].[factLiabilities]  WITH CHECK ADD  CONSTRAINT [FK_factLiabilities_dimCurrency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[dimCurrency] ([CurrencyId])
GO
ALTER TABLE [dbo].[factLiabilities] CHECK CONSTRAINT [FK_factLiabilities_dimCurrency]
GO
ALTER TABLE [dbo].[factLiabilities]  WITH CHECK ADD  CONSTRAINT [FK_factLiabilities_dimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factLiabilities] CHECK CONSTRAINT [FK_factLiabilities_dimDate]
GO
ALTER TABLE [dbo].[factLiabilities]  WITH CHECK ADD  CONSTRAINT [FK_factLiabilities_dimSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[dimSource] ([SourceId])
GO
ALTER TABLE [dbo].[factLiabilities] CHECK CONSTRAINT [FK_factLiabilities_dimSource]
GO
