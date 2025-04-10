USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCountryId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Partner ID
-- =============================================
CREATE FUNCTION [dbo].[GetCountryId] 
(
	@CountryCode nvarchar(50)
)
RETURNS int
AS
BEGIN
	declare @CountryId int
	set @CountryId=(select top 1 [CountryId] from dbo.[dimCountry] where [CountryCode]=@CountryCode)

RETURN @CountryId

END
GO
