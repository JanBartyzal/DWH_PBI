USE [PBI]
GO
/****** Object:  View [dbo].[viewFactBankAccount]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[viewFactBankAccount]
as
SELECT b.[DateID]
	  ,d.FullDate
      ,b.[BankAccountId]
	  ,ba.[BankAccountName]
      ,[Balance]
      ,[TotIncome]
      ,[TotExpend]
	  ,ba.CurrencyShort
  FROM [dbo].[factBankAccounts] b
  left join dbo.dimDate d on d.DateID=b.DateID
  left join dbo.viewBankAccount ba on ba.BankAccountId=b.BankAccountId
  
GO
