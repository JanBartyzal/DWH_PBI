USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCurrencyId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Partner ID
-- =============================================
CREATE FUNCTION [dbo].[GetCurrencyId] 
(
	@CurrencyCode nvarchar(50)
)
RETURNS int
AS
BEGIN
	declare @CurrencyId int
	set @CurrencyId=(select top 1 [CurrencyId] from dbo.[dimCurrency] where [CurrencyShort]=@CurrencyCode)

RETURN @CurrencyId

END
GO
