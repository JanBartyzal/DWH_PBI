USE [PBI]
GO
/****** Object:  View [dbo].[viewFactAccountsRecAndPay]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[viewFactAccountsRecAndPay]
as
SELECT a.[DateId]
      ,a.[TypId]
      ,a.[StatusEnforcmentId]
      ,a.[SpeciesTypeId]
      ,a.[CostCenterId]
      ,[ReferenceNumber]
      ,a.[CategoryId1]
      ,a.[CategoryId2]
      ,[Amount]
	  ,d.FullDate
	  ,cp.CommitmentTypeCode
	  ,cp.CommitmentTypeName
	  ,se.StatusEnforcmentCode
	  ,se.StatusEnforcmentName
	  ,st.SpeciesTypeCode
	  ,st.SpeciesTypeName
	  ,cc.[CostCenterNumber]
      ,cc.[CostCenterName]
	  ,cc.[SectionName]
      ,cc.[SectionNumber]
	  ,c1.CategoryCode as CategoryCode1
	  ,c1.CategoryName as CategoryName1
	  ,c2.CategoryCode as CategoryCode2
	  ,c2.CategoryName as CategoryName2

  FROM [PBI].[dbo].[factAccountsRecAndPay] a
  left join dbo.dimDate d on d.DateID=a.DateID
  left join dbo.dimCommitmentType cp on cp.CommitmentTypeId=a.TypId
  left join dbo.dimStatusEnforcment se on se.StatusEnforcmentId=a.StatusEnforcmentId
  left join dbo.dimSpeciesType st on st.SpeciesTypeId=a.SpeciesTypeId
  left join dbo.viewCostCenter cc on cc.CostCenterId=a.CostCenterId
  left join dbo.dimCategory c1 on c1.CategoryId=a.CategoryId1
  left join dbo.dimCategory c2 on c2.CategoryId=a.CategoryId2
GO
