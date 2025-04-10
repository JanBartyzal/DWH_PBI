USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[LogStage]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jan Bartyzal
-- Create date: 2024-09-01
-- Description:	Add message to log
-- =============================================
Create PROCEDURE [dbo].[LogStage]
	
	@DateID int,
	@Source nvarchar(50),
    @Message nvarchar(255),
    @Status  nvarchar(20)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

if (isnull(@DateID,0)=0)
	begin
	declare @DateChar nvarchar(8)
	set @DateChar=(select Convert(CHAR(8),GetDate(),112))
	set @DateID=(select(Convert(INT,@DateChar)))

	end

insert into dbo.logsStage([DateID],[Source],[Message],[Status],[TimeStamp])
values (@DateID, @Source, @Message, @Status, GetDate())


END
GO
