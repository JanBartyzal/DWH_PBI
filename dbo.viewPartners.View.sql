USE [PBI]
GO
/****** Object:  View [dbo].[viewPartners]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[viewPartners]
as
SELECT [PartnerId]
      ,[PartnerICO]
      ,[PartnerName]
      ,[PartnerAdress1]
      ,[PartnerAdress2]
      ,[PartnerCity]
      ,[PartnerPostCode]
      ,[PartnerCountryId]
      ,[PartnerActive]
	  ,Co.CountryCode
	  ,co.CountryName
	  ,co.RegionName
	  ,co.ContinentName
  FROM [dbo].[dimPartners] P
  left join dbo.viewCountry Co on co.CountryId=p.PartnerCountryId
  
GO
