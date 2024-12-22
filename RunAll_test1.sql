USE [PBI]
GO



EXEC [dbo].[Step3_ProcessBankAccounts] @DateID = NULL
EXEC [dbo].[Step3_ProcessContracts] @DateID = NULL
EXEC [dbo].[Step3_ProcessExchangeRates] @DateID = NULL
EXEC [dbo].[Step3_ProcessDebitDeposit] @DateID = NULL
EXEC [dbo].[Step3_ProcessLiabilities] @DateID = NULL
EXEC [dbo].[Step3_ProcessAccountsRecAndPay] @DateID = NULL
EXEC [dbo].[Step3_ProcessSales] @DateID = NULL

update [dbo].stgCFBanky set Status=0
update [dbo].stgCFInkasoVydej set Status=0
update [dbo].stgCFZavazky set Status=0
update [dbo].[stgKontrakt] set Status=0
update [dbo].[stgKurzovníListek] set Status=0
update [dbo].stgPohledavkyZavazky set Status=0
update [dbo].stgTrzby set Status=0




