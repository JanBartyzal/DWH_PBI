USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCommitmentType]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewCommitmentType]
@CommitmentTypeName nvarchar(50),
@CommitmentTypeCode nvarchar(50)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1
		if not exists(select CommitmentTypeName from dbo.[dimCommitmentType] where CommitmentTypeCode=@CommitmentTypeCode)
		begin
			insert into dbo.[dimCommitmentType](CommitmentTypeName,CommitmentTypeCode)
			values(@CommitmentTypeName,@CommitmentTypeCode)
			set @messageCode=1
		end

RETURN @messageCode
GO
