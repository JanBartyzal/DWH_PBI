USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCountry]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewCountry]

@CountryCode nvarchar(50),
@CountryName nvarchar(50),
@ContinentName nvarchar(50),
@RegionName nvarchar(50),
@CurrencyCode nvarchar(3)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @CountryId int
	declare @CountryContinentId int
	declare @CountryRegionId int
	declare @CountryCurrencyId int


	set @CountryContinentId=(select top 1 CountryContinentId from dbo.[dimCountryContinent] where ContinentName=@ContinentName)
	set @CountryRegionId=(select top 1 CountryRegionId from dbo.[dimCountryRegion] where RegionName=@RegionName)
	set @CountryCurrencyId=(select top 1 [CurrencyId] from dbo.[dimCurrency] where CurrencyShort=@CurrencyCode)

	if isnull(@CountryContinentId,0)=0 
	begin
	set @messageCode=-9
	end

	if isnull(@CountryRegionId,0)=0 
	begin
	set @messageCode=-8
	end

	if isnull(@CountryCurrencyId,0)=0 
	begin
	set @messageCode=-7
	end
	

	if  @messageCode=-1
	begin
		set @messageCode=-2
		if not exists(select [CountryId] from dbo.[dimCountry] where CountryCode=@CountryCode)
		begin
			insert into dbo.[dimCountry]([CountryCode],[CountryName],[CountryContinentId],[CountryRegionId],[CountryCurrencyId])
			values(@CountryCode, @CountryName, @CountryContinentId,@CountryRegionId,@CountryCurrencyId)
			set @messageCode=1
		end
	end

RETURN @messageCode
GO
