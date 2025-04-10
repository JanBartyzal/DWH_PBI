USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewSpeciesType]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
Create PROCEDURE [dbo].[dimNewSpeciesType]
@SpeciesTypeName nvarchar(50),
@SpeciesTypeCode nvarchar(50)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1
		if not exists(select SpeciesTypeName from dbo.[dimSpeciesType] where SpeciesTypeCode=@SpeciesTypeCode)
		begin
			insert into dbo.[dimSpeciesType](SpeciesTypeName,SpeciesTypeCode)
			values(@SpeciesTypeName,@SpeciesTypeCode)
			set @messageCode=1
		end

RETURN @messageCode
GO
