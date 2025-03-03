USE [PBI]
GO
/****** Object:  View [dbo].[viewBankAccount]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[viewBankAccount]
as
SELECT [BankAccountId]
      ,[BankAccountName]
      ,[BankAccountNumber]
      ,[BankAccountIban]
      ,c.[CurrencyId]
	  ,c.CurrencyShort
  FROM [dbo].[dimBankAccount] b
  left join dbo.dimCurrency c on c.CurrencyId=b.CurrencyId
GO
