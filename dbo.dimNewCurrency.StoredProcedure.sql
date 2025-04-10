USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCurrency]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewCurrency]

@CurrencyShort nvarchar(50),
@CurrencyName nvarchar(50),
@CurrencyRatio int


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1


	if not exists(select [CurrencyId] from dbo.[dimCurrency] where CurrencyShort=@CurrencyShort)
	begin
		insert into dbo.[dimCurrency]([CurrencyShort],[CurrencyName],[CurrencyRatio])
		values(@CurrencyShort,@CurrencyName,@CurrencyRatio)
		set @messageCode=1
	end

RETURN @messageCode
GO
