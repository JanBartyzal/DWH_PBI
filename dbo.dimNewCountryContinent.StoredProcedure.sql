USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCountryContinent]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewCountryContinent]

@ContinentName nvarchar(50)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1


	if not exists(select [CountryContinentId] from dbo.[dimCountryContinent] where ContinentName=@ContinentName)
	begin
		insert into dbo.[dimCountryContinent](ContinentName)
		values(@ContinentName)
		set @messageCode=1
	end

RETURN @messageCode
GO
