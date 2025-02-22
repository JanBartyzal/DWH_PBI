USE [PBI]
GO
/****** Object:  Table [dbo].[factExchangeRateCZK]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factExchangeRateCZK](
	[DateId] [int] NOT NULL,
	[CurrencyToId] [int] NOT NULL,
	[Rate] [float] NULL,
 CONSTRAINT [PK_factExchangeRateCZK] PRIMARY KEY CLUSTERED 
(
	[DateId] ASC,
	[CurrencyToId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[factExchangeRateCZK]  WITH CHECK ADD  CONSTRAINT [FK_factExchangeRateCZK_dimCurrency] FOREIGN KEY([CurrencyToId])
REFERENCES [dbo].[dimCurrency] ([CurrencyId])
GO
ALTER TABLE [dbo].[factExchangeRateCZK] CHECK CONSTRAINT [FK_factExchangeRateCZK_dimCurrency]
GO
ALTER TABLE [dbo].[factExchangeRateCZK]  WITH CHECK ADD  CONSTRAINT [FK_factExchangeRateCZK_dimDate] FOREIGN KEY([DateId])
REFERENCES [dbo].[dimDate] ([DateID])
GO
ALTER TABLE [dbo].[factExchangeRateCZK] CHECK CONSTRAINT [FK_factExchangeRateCZK_dimDate]
GO
