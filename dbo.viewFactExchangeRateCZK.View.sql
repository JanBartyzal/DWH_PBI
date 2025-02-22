USE [PBI]
GO
/****** Object:  View [dbo].[viewFactExchangeRateCZK]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viewFactExchangeRateCZK]
as
SELECT a.[DateId]
      ,[CurrencyToID]
      ,[Rate]
	  ,d.FullDate
	  ,cu.CurrencyName
	  ,cu.CurrencyRatio
  FROM [dbo].[factExchangeRateCZK] a
  left join dbo.dimDate d on d.DateID=a.DateID
  left join dbo.dimCurrency cu on cu.CurrencyId=a.CurrencyToID
GO
