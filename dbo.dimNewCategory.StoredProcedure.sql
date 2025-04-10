USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewCategory]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
Create PROCEDURE [dbo].[dimNewCategory]
@CategoryName nvarchar(50),
@CategoryCode nvarchar(50)


AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1
		if not exists(select CategoryName from dbo.[dimCategory] where CategoryCode=@CategoryCode)
		begin
			insert into dbo.[dimCategory](CategoryName,CategoryCode)
			values(@CategoryName,@CategoryCode)
			set @messageCode=1
		end

RETURN @messageCode
GO
