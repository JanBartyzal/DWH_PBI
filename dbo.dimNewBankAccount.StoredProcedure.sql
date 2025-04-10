USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewBankAccount]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewBankAccount]

@BankAccountName nvarchar(50),
@BankAccountNumber nvarchar(50),
@BankAccountIban nvarchar(50),
@Currency nvarchar(3)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @CurrencyId int


	set @CurrencyId=(select top 1 CurrencyId from dbo.dimCurrency where CurrencyShort=@Currency)

	if isnull(@CurrencyId,0)=0 
	begin
	set @messageCode=-9
	end
	else
	begin
		set @messageCode=-2
		if not exists(select BankAccountNumber from dbo.dimBankAccount where BankAccountNumber=@BankAccountNumber)
		begin
			insert into dbo.dimBankAccount([BankAccountName],[BankAccountNumber],[BankAccountIban],[CurrencyId])
			values(@BankAccountName, @BankAccountNumber, @BankAccountIban,@CurrencyId)
			set @messageCode=1
		end
	end

RETURN @messageCode
GO
