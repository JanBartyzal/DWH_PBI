USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCountryRegion]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewCountryRegion]

@RegionName nvarchar(50)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1


	if not exists(select [CountryRegionId] from dbo.[dimCountryRegion] where RegionName=@RegionName)
	begin
		insert into dbo.[dimCountryRegion](RegionName)
		values(@RegionName)
		set @messageCode=1
	end

RETURN @messageCode
GO
