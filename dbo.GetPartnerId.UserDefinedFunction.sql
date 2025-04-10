USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPartnerId]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Get Partner ID
-- =============================================
CREATE FUNCTION [dbo].[GetPartnerId] 
(
	@PartnerICO nvarchar(50),
	@PartnerName nvarchar(50)
)
RETURNS int
AS
BEGIN
	declare @PartnerId int
	set @PartnerId=(select top 1 [PartnerId] from dbo.[dimPartners] where [PartnerICO]=@PartnerICO)
	if isnull(@PartnerId,0)=0
	begin
		set @PartnerId=(select top 1 [PartnerId] from dbo.[dimPartners] where [PartnerName]=@PartnerName)
	end

RETURN @PartnerId

END
GO
