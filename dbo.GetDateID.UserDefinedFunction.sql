USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDateID]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDateID]
(
	@FullDate date
)
RETURNS int
AS
BEGIN
declare @DateChar nvarchar(10)
declare @DateID int
	set @DateChar=(Select Convert(CHAR(8),@FullDate,112))

	set @DateID=(Select Convert(INT,@DateChar))


	RETURN @DateID

END
GO
