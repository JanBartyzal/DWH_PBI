USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewSource]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewSource]

@SourceName nvarchar(50)

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1

	declare @SectionId int


	if not exists(select [SourceId] from dbo.[dimSource] where [SourceName]=@SourceName)
	begin
		insert into dbo.[dimSource]([SourceName])
		values(@SourceName)
		set @messageCode=1
	end

RETURN @messageCode
GO
