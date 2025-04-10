USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimUpdateBankAccount]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Update new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimUpdateBankAccount]

@BankAccountName nvarchar(50),
@BankAccountNumber nvarchar(50),
@BankAccountIban nvarchar(50),
@Currency nvarchar(3)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @CurrencyId int
	declare @BankAccountId int


	set @CurrencyId=(select top 1 CurrencyId from dbo.dimCurrency where CurrencyShort=@Currency)
	set @BankAccountId=(select top 1 BankAccountId from dbo.dimBankAccount where BankAccountNumber=@BankAccountNumber)

	if isnull(@CurrencyId,0)=0 
	begin
	set @messageCode=-9
	end
	else
	begin
		set @messageCode=-2
		if isnull(@BankAccountId,0)=0 
		begin
			set @messageCode=-3
		end
		else
		begin
		UPDATE dbo.dimBankAccount
			SET [BankAccountName] = @BankAccountName
			,[BankAccountIban] = @BankAccountIban
			,[CurrencyId] = @CurrencyId
			WHERE BankAccountId=@BankAccountId
			set @messageCode=1
		end
	end

RETURN @messageCode
GO
