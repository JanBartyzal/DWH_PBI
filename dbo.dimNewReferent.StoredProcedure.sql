USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewReferent]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewReferent]

@ReferentCode nvarchar(50),
@ReferentName nvarchar(50),
@CostCenterNumber int,
@SectionNumber int,
@SupervisorCode nvarchar(50)

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @ReferentId int
	declare @SupervisorId int
	declare @CostCenterId int
	
	set @ReferentId=(dbo.GetReferentId(@ReferentCode,@ReferentName))
	set @SupervisorId=(dbo.GetReferentId(@SupervisorCode,''))
	set @CostCenterId=(dbo.GetCostCenterId(@CostCenterNumber, @SectionNumber))

	if  @ReferentCode is null

	begin
	set @messageCode=-9
	end
	
	
	if  isnull(@ReferentId,0)=0 and @ReferentCode is not null
	begin
		
			insert into dbo.[dimReferents]([ReferentCode],[ReferentName],[CostCenterId],[SupervisorId])
			values(@ReferentCode,@ReferentName,@CostCenterId,@SupervisorId )
			set @messageCode=1
		
	end
	else
	begin
		
		set @messageCode=2

		update dbo.[dimReferents]
		set [ReferentName]=@ReferentName
		where ([ReferentName] is null or isnull([ReferentName],'')<>@ReferentName)
		and @ReferentName is not null
		and ReferentId=@ReferentId

		update dbo.[dimReferents]
		set [CostCenterId]=@CostCenterId
		where ([CostCenterId] is null or isnull([CostCenterId],0)<>@CostCenterId)
		and @CostCenterId is not null
		and ReferentId=@ReferentId


		update dbo.[dimReferents]
		set [SupervisorId]=@SupervisorId
		where ([SupervisorId] is null or isnull([SupervisorId],0)<>@SupervisorId)
		and @SupervisorId is not null
		and ReferentId=@ReferentId


	end


RETURN @messageCode
GO
