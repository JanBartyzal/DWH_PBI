USE [PBI]
GO
/****** Object:  View [dbo].[viewCountry]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[viewCountry]
as
select
	 Co.CountryId
	,Co.CountryCode
	,cu.CurrencyShort
	,co.CountryName
	,cu.CurrencyName
	,cr.RegionName
	,cc.ContinentName
	,co.[CountryContinentId]
    ,co.[CountryRegionId]
    ,[CountryCurrencyId]
from dbo.dimCountry Co
  left join dbo.dimCountryRegion Cr on Cr.CountryRegionId=co.CountryRegionId
  left join dbo.dimCountryContinent Cc on Cc.CountryContinentId=co.CountryContinentId
  left join dbo.dimCurrency Cu on Cu.CurrencyId=Co.CountryCurrencyId
GO
