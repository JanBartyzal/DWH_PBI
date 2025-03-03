USE [PBI]
GO
/****** Object:  View [dbo].[viewFactContracts]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[viewFactContracts]
as
SELECT c.[DateID]
      ,c.[PartnerId]
      ,c.[CostCenterId]
      ,c.[CountryId]
      ,c.[CurrencyId]
      ,[ReferenceNumber]
	  ,d.FullDate
	  ,cc.[CostCenterNumber]
      ,cc.[CostCenterName]
	  ,cc.[SectionName]
      ,cc.[SectionNumber]
      ,[Amount]
	  ,cu.CurrencyShort
      ,c.[ReferentId]
	  ,r.ReferentCode
	  ,r.ReferentName
      ,[Costs1]
      ,[PK]
      ,[Costs2]
      ,[Margin]

  FROM [PBI].[dbo].[factContracts] c
  left join dbo.dimDate d on d.DateID=c.DateID
  left join dbo.dimPartners p on p.PartnerId=c.PartnerId
  left join dbo.viewCostCenter cc on cc.CostCenterId=c.CostCenterId
  left join dbo.viewCountry cn on cn.CountryId=c.CountryId
  left join dbo.dimCurrency cu on cu.CurrencyId=c.CurrencyId
  left join dbo.dimReferents r on r.ReferentId=c.ReferentId
GO
