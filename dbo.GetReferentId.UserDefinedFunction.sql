USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetReferentId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Referent ID
-- =============================================
CREATE FUNCTION [dbo].[GetReferentId] 
(
	@ReferentCode nvarchar(50),
	@ReferentName nvarchar(50)
)
RETURNS int
AS
BEGIN
	declare @ReferentId int
	set @ReferentId=(select top 1 [ReferentId] from dbo.[dimReferents] where [ReferentCode]=@ReferentCode)
	if isnull(@ReferentId,0)=0
	begin
		set @ReferentId=(select top 1 [ReferentId] from dbo.[dimReferents] where [ReferentName]=@ReferentName)
	end

RETURN @ReferentId

END
GO
