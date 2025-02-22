USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCommitmentTypeId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Partner ID
-- =============================================
CREATE FUNCTION [dbo].[GetCommitmentTypeId] 
(
	@TypeName nvarchar(50)
	
)
RETURNS int
AS
BEGIN
	declare @CommitmentTypeId int
	set @CommitmentTypeId=(select top 1 CommitmentTypeId from dbo.[dimCommitmentType] where [CommitmentTypeCode]=@TypeName)
	if isnull(@CommitmentTypeId,0)=0 
	begin
		set @CommitmentTypeId=(select top 1 CommitmentTypeId from dbo.[dimCommitmentType] where [CommitmentTypeName]=@TypeName)
	end
	


RETURN @CommitmentTypeId

END
GO
