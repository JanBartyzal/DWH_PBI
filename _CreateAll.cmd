Echo Create DB PBI
sqlcmd -S localhost -d master -E -i PBI.Database.sql
Echo Stage tables
sqlcmd -S localhost -d PBI -E -i dbo.stgCFBanky.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.stgCFInkasoVydej.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.stgCFZavazky.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.stgKontrakt.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.stgKurzovn¡Listek.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.stgPohledavkyZavazky.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.stgTrzby.Table.sql
Echo Dimension tables
sqlcmd -S localhost -d PBI -E -i dbo.dimBankAccount.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCategory.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCommitmentType.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCostCenter.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCountry.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCountryContinent.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCountryRegion.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimCurrency.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimDate.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimMonthTable.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewBankAccount.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCategory.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCommitmentType.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCostCenter.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCountry.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCountryContinent.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCountryRegion.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewCurrency.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewDate.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewMonthTable.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewPartner.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewReferent.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewSection.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewSource.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewSpeciesType.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimNewStatusEnforcment.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimPartners.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimPartnersArchiv.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimReferents.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimSection.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimSource.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimSpeciesType.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimStatusEnforcment.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.dimUpdateBankAccount.StoredProcedure.sql
Echo Fact tables
sqlcmd -S localhost -d PBI -E -i dbo.factAccountsRecAndPay.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.factBankAccounts.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.factContracts.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.factDebitDeposit.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.factExchangeRateCZK.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.factLiabilities.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.factSales.Table.sql
sqlcmd -S localhost -d PBI -E -i dbo.logsStage.Table.sql
Echo User functions
sqlcmd -S localhost -d PBI -E -i dbo.GetBankID.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetCommitmentTypeId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetCostCenterId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetCountryId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetCurrencyId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetDateID.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetPartnerId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetReferentId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.GetSectionId.UserDefinedFunction.sql
sqlcmd -S localhost -d PBI -E -i dbo.LogStage.StoredProcedure.sql
Echo Stored Procedures
sqlcmd -S localhost -d PBI -E -i dbo.Step1_ExtractDate.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step1_ExtractPartner.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step2_CheckAndMarkMissingValues.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step2_CheckStageDataQuality.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step2_CreateExchageRate.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessAccountsRecAndPay.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessBankAccounts.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessContracts.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessDebitDeposit.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessExchangeRates.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessLiabilities.StoredProcedure.sql
sqlcmd -S localhost -d PBI -E -i dbo.Step3_ProcessSales.StoredProcedure.sql
Echo Views
sqlcmd -S localhost -d PBI -E -i dbo.viewBankAccount.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewCostCenter.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewCountry.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewDate.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactAccountsRecAndPay.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactBankAccount.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactContracts.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactDebitDeposit.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactExchangeRateCZK.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactLiabilities.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewFactSales.View.sql
sqlcmd -S localhost -d PBI -E -i dbo.viewPartners.View.sql
Echo Init data
sqlcmd -S localhost -d PBI -E -i Init_script.sql
Echo Test data
sqlcmd -S localhost -d PBI -E -i Init_Data1.sql
sqlcmd -S localhost -d PBI -E -i Init_Data2.sql
