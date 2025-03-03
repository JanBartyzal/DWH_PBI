USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewSection]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewSection]

@SectionNumber int,
@SectionName nvarchar(50)

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @SectionId int


	if not exists(select [SectionId] from dbo.[dimSection] where [SectionNumber]=@SectionNumber)
	begin
		insert into dbo.[dimSection]([SectionName],[SectionNumber])
		values(@SectionName,@SectionNumber)
		set @SectionId=(SELECT SCOPE_IDENTITY())

		exec dbo.[dimNewCostCenter]  @CostCenterNumber=0,@CostCenterName='Global',@SectionNumber=@SectionNumber

		set @messageCode=1
	end

RETURN @messageCode
GO
