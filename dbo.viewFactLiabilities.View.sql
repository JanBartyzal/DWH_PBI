USE [PBI]
GO
/****** Object:  View [dbo].[viewFactLiabilities]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[viewFactLiabilities]
as
SELECT  a.[DateID]
      ,a.[CommitmentTypeId]
      ,a.[CurrencyId]
      ,[Amount]
	   ,d.FullDate
	  ,cp.CommitmentTypeCode
	  ,cp.CommitmentTypeName
	  ,cu.CurrencyShort
  FROM [dbo].[factLiabilities] a
  left join dbo.dimDate d on d.DateID=a.DateID
  left join dbo.dimCommitmentType cp on cp.CommitmentTypeId=a.CommitmentTypeId
  left join dbo.dimCurrency cu on cu.CurrencyId=a.CurrencyId
GO
