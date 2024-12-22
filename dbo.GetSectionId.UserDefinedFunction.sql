USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetSectionId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Partner ID
-- =============================================
CREATE FUNCTION [dbo].[GetSectionId] 
(
	@SectionNumber nvarchar(50)
)
RETURNS int
AS
BEGIN
	declare @SectionId int
	set @SectionId=(select top 1 [SectionId] from dbo.[dimSection] where [SectionNumber]=@SectionNumber)

RETURN @SectionId

END
GO
