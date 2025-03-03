USE [PBI]
GO
/****** Object:  View [dbo].[viewFactDebitDeposit]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[viewFactDebitDeposit]
as
SELECT a.[DateID]
      ,a.[CommitmentTypeId]
      ,a.[CostCenterId]
      ,[Amount]
	  ,d.FullDate
	  ,cp.CommitmentTypeCode
	  ,cp.CommitmentTypeName
	  ,cc.[CostCenterNumber]
      ,cc.[CostCenterName]
	  ,cc.[SectionName]
      ,cc.[SectionNumber]
  FROM [dbo].[factDebitDeposit] a
  left join dbo.dimDate d on d.DateID=a.DateID
  left join dbo.dimCommitmentType cp on cp.CommitmentTypeId=a.CommitmentTypeId
  left join dbo.viewCostCenter cc on cc.CostCenterId=a.CostCenterId
GO
