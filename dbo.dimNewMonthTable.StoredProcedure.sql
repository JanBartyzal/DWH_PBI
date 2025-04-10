USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewMonthTable]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewMonthTable]

@MonthNum int,
@MonthName nvarchar(50),
@QuartalName nvarchar(50),
@BusinessName nvarchar(50),
@ClosingName nvarchar(50)

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1


	if not exists(select [MonthNum] from dbo.[dimMonthTable] where [MonthNum]=@MonthNum)
	begin
		insert into dbo.[dimMonthTable]([MonthNum],[MonthName],[QuartalName],[BusinessName],[ClosingName])
		values(@MonthNum,@MonthName,@QuartalName,@BusinessName,@ClosingName)
		set @messageCode=1
	end

RETURN @messageCode
GO
