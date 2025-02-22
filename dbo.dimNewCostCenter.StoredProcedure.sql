USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCostCenter]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewCostCenter]

@CostCenterNumber nvarchar(50),
@CostCenterName nvarchar(50),
@SectionNumber int

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @SectionId int


	set @SectionId=(select top 1 [SectionId] from dbo.[dimSection] where SectionNumber=@SectionNumber)

	if isnull(@SectionId,0)=0 
	begin
	set @messageCode=-9
	end
	else
	begin
		set @messageCode=-2
		if not exists(select CostCenterNumber from dbo.[dimCostCenter] where CostCenterNumber=@CostCenterNumber and SectionId=@SectionId)
		begin
			insert into dbo.[dimCostCenter]([SectionId], CostCenterNumber,CostCenterName)
			values(@SectionId, @CostCenterNumber, @CostCenterName)
			set @messageCode=1
		end
	end

RETURN @messageCode
GO
