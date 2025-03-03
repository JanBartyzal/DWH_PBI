USE [PBI]
GO
/****** Object:  View [dbo].[viewDate]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[viewDate]
as
SELECT d.[DateID]
      ,d.[MonthNum]
      ,[FullDate]
	  ,m.MonthName
	  ,m.QuartalName
	  ,m.BusinessName
	  ,m.ClosingName
  FROM [PBI].[dbo].[dimDate] d
  left join dimMonthTable m on d.MonthNum=m.MonthNum
GO
