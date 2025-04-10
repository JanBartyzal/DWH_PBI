USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewDate]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewDate]

@FullDate date

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1
	declare @DateID int
	declare @DateChar CHAR(8)


	if not exists(select [DateID] from dbo.[dimDate] where [FullDate]=@FullDate)
	begin
		set @DateChar=Convert(CHAR(8),@FullDate,112)
		set @DateID=Convert(INT,@DateChar)
		insert into dbo.[dimDate]([DateID],[MonthNum],[FullDate])
		values(@DateID,MONTH(@FullDate), @FullDate)
		set @messageCode=1
	end

RETURN @messageCode
GO
