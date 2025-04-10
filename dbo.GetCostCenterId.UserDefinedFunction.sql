USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCostCenterId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Partner ID
-- =============================================
CREATE FUNCTION [dbo].[GetCostCenterId] 
(
	@CostCenterNumber nvarchar(50),
	@SectionNumber nvarchar(50)
)
RETURNS int
AS
BEGIN
	declare @CostCenterId int
	declare @SectionId int
	set @SectionId=(select top 1 [SectionId] from dbo.[dimSection] where [SectionNumber]=@SectionNumber)
	if isnull(@SectionId,0)>0
	begin
		set @CostCenterId=(select top 1 [CostCenterId] from dbo.[dimCostCenter] where [CostCenterNumber]=@CostCenterNumber and [SectionId]=@SectionId)
		if isnull(@CostCenterId,0)=0
		begin
			set @CostCenterId=(select top 1 [CostCenterId] from dbo.[dimCostCenter] where [CostCenterNumber]=0 and [SectionId]=@SectionId)
		end
	end


RETURN @CostCenterId

END
GO
