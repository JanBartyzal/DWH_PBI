USE [PBI]
GO
/****** Object:  View [dbo].[viewFactSales]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viewFactSales]
as
SELECT a.[DateId]
      ,a.[PartnerId]
      ,a.[CostCenterId]
      ,a.[CountryId]
      ,a.[CurrencyId]
      ,[ReferenceNumber]
      ,[Amount]
	  ,d.FullDate
	  ,p.PartnerICO
	  ,p.PartnerName
	  ,p.[PartnerCountryId]
	  ,p.[CountryCode] as PartnerCountryCode
	  ,cc.[CostCenterNumber]
      ,cc.[CostCenterName]
	  ,cc.[SectionName]
      ,cc.[SectionNumber]
	  ,cu.CurrencyShort
  FROM [PBI].[dbo].[factSales] a
  left join dbo.dimDate d on d.DateID=a.DateID
  left join dbo.viewPartners p on p.PartnerId=a.PartnerId
  left join dbo.viewCostCenter cc on cc.CostCenterId=a.CostCenterId
  left join dbo.viewCountry cn on cn.CountryId=a.CountryId
  left join dbo.dimCurrency cu on cu.CurrencyId=a.CurrencyId
  
GO
