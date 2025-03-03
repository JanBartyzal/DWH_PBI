USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[dimNewPartner]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bartyzal Jan
-- Create date: 2024-08-24
-- Description:	Create new bank account
-- =============================================
CREATE PROCEDURE [dbo].[dimNewPartner]

@PartnerICO nvarchar(50),
@PartnerName nvarchar(50),
@PartnerAdress1 nvarchar(50),
@PartnerAdress2 nvarchar(50),
@PartnerCity nvarchar(50),
@PartnerPostCode nvarchar(50),
@PartnerCountryCode nvarchar(50)

AS

	SET NOCOUNT ON;
	declare @messageCode int
	set @messageCode=-1
	declare @PartnerId int
	

	declare @CountryId int
	set @CountryId=(select top 1 [CountryId] from dbo.[dimCountry] where CountryCode=@PartnerCountryCode)
	if isnull(@CountryId,0)=0 
	begin
	set @messageCode=-7
	end
	

	if  @messageCode=-1
	begin
		if not exists(select [PartnerId] from dbo.[dimPartners] where PartnerICO=@PartnerICO)
		begin
			insert into dbo.[dimPartners]([PartnerICO],[PartnerName],[PartnerAdress1],[PartnerAdress2],[PartnerCity],[PartnerPostCode],[PartnerCountryId],[PartnerActive])
			values(@PartnerICO,@PartnerName,@PartnerAdress1,@PartnerAdress2,@PartnerCity,@PartnerPostCode,@CountryId,1)
			set @messageCode=1
		end
		else
		begin
			set @PartnerId=(select top 1 [PartnerId] from dbo.[dimPartners] where PartnerICO=@PartnerICO)

			if exists(
				select [PartnerId] from dbo.[dimPartners] where PartnerId=@PartnerId
				and (
				[PartnerName]<> @PartnerName OR
				[PartnerAdress1]<> @PartnerAdress1 OR
				[PartnerAdress2]<> @PartnerAdress2 OR
				[PartnerCity]<> @PartnerCity OR
				[PartnerPostCode]<> @PartnerPostCode OR
				[PartnerCountryId]<> @CountryId )
				)
				begin
			
					insert into [dbo].[dimPartnersArchiv] ([PartnerICO],[PartnerName],[PartnerAdress1],[PartnerAdress2],[PartnerCity],[PartnerPostCode],[PartnerCountryId],[PartnerActive],[PartnerTimeStamp],[DateId] )
					select [PartnerICO],[PartnerName],[PartnerAdress1],[PartnerAdress2],[PartnerCity],[PartnerPostCode],[PartnerCountryId],[PartnerActive], GetDate(), [dbo].[GetDateID] (GetDate())
					from  dbo.[dimPartners] where PartnerId=@PartnerId


					update dbo.[dimPartners]
					set [PartnerName]=@PartnerName,
						[PartnerAdress1]=@PartnerAdress1,
						[PartnerAdress2]=@PartnerAdress2,
						[PartnerCity]=@PartnerCity,
						[PartnerPostCode]=@PartnerPostCode,
						[PartnerCountryId]=@CountryId
					where PartnerId=@PartnerId
				end
		end
	end

RETURN @messageCode
GO
