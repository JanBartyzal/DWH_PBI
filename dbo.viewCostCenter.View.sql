USE [PBI]
GO
/****** Object:  View [dbo].[viewCostCenter]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[viewCostCenter]
as
SELECT [CostCenterId]
      ,cc.[SectionId]
      ,[CostCenterNumber]
      ,[CostCenterName]
	  ,s.SectionName
	  ,s.SectionNumber
  FROM [dbo].[dimCostCenter] cc
  left join dbo.dimSection s on s.SectionId=cc.SectionId
GO
