USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewStatusEnforcment]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
Create PROCEDURE [dbo].[dimNewStatusEnforcment]
@StatusEnforcmentName nvarchar(50),
@StatusEnforcmentCode nvarchar(50)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1
		if not exists(select StatusEnforcmentName from dbo.[dimStatusEnforcment] where StatusEnforcmentCode=@StatusEnforcmentCode)
		begin
			insert into dbo.[dimStatusEnforcment](StatusEnforcmentName,StatusEnforcmentCode)
			values(@StatusEnforcmentName,@StatusEnforcmentCode)
			set @messageCode=1
		end

RETURN @messageCode
GO
