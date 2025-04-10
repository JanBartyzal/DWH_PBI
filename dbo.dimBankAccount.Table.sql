USE [PBI]
GO
/****** Object:  Table [dbo].[dimBankAccount]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimBankAccount](
	[BankAccountId] [int] IDENTITY(1,1) NOT NULL,
	[BankAccountName] [nvarchar](50) NULL,
	[BankAccountNumber] [nvarchar](50) NULL,
	[BankAccountIban] [nvarchar](50) NULL,
	[CurrencyId] [int] NULL,
 CONSTRAINT [PK_dimbankAccount] PRIMARY KEY CLUSTERED 
(
	[BankAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
