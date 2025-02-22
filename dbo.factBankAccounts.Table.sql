USE [PBI]
GO
/****** Object:  Table [dbo].[factBankAccounts]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factBankAccounts](
	[DateID] [int] NOT NULL,
	[BankAccountId] [int] NOT NULL,
	[Balance] [float] NULL,
	[TotIncome] [float] NULL,
	[TotExpend] [float] NULL,
	[SourceId] [int] NOT NULL,
 CONSTRAINT [PK_factBankAccounts] PRIMARY KEY CLUSTERED 
(
	[DateID] ASC,
	[BankAccountId] ASC,
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factBankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_factBankAccounts_dimBankAccount] FOREIGN KEY([BankAccountId])
REFERENCES [dbo].[dimBankAccount] ([BankAccountId])
GO
ALTER TABLE [dbo].[factBankAccounts] CHECK CONSTRAINT [FK_factBankAccounts_dimBankAccount]
GO
ALTER TABLE [dbo].[factBankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_factBankAccounts_dimDate] FOREIGN KEY([DateID])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factBankAccounts] CHECK CONSTRAINT [FK_factBankAccounts_dimDate]
GO
ALTER TABLE [dbo].[factBankAccounts]  WITH CHECK ADD  CONSTRAINT [FK_factBankAccounts_dimSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[dimSource] ([SourceId])
GO
ALTER TABLE [dbo].[factBankAccounts] CHECK CONSTRAINT [FK_factBankAccounts_dimSource]
GO
