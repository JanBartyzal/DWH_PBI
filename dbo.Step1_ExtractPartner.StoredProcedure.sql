USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step1_ExtractPartner]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Jan Bartyzal
-- Create date: 2024-09-01
-- Description:	Extract date from stage and create dim
-- =============================================
CREATE PROCEDURE [dbo].[Step1_ExtractPartner]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

declare @countInt int
declare @countErr int
declare @src nvarchar(50)
set @src=(select OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID))
declare @msg nvarchar(255)

declare @partner table
(ICO nvarchar(50), [Nazev] nvarchar(255), PartnerID int)

insert into @partner ([ICO],[Nazev])
select distinct [ICO],[Nazev] from [dbo].[stgKontrakt]

insert into @partner ([ICO],[Nazev])
select distinct [ICO],[Nazev] from [dbo].[stgTrzby]

delete from @partner
where ICO is null

update A
set a.PartnerID=b.PartnerID
from @partner A
left join dbo.dimPartners B on a.ICO=b.PartnerICO
where a.ICO is not null

delete from @partner
where PartnerID is not null


declare @ICO nvarchar(50)
declare @Nazev nvarchar(255)


declare curr cursor for select distinct [ICO],[Nazev] from @partner where ICO is not null
open curr
fetch next from curr into @ICO, @Nazev

if @@FETCH_STATUS<>0
begin
	exec [dbo].[dimNewPartner] @PartnerICO=@ICO, @PartnerName=@Nazev,@PartnerAdress1=NULL ,@PartnerAdress2=NULL,@PartnerCity=NULL,@PartnerPostCode=NULL ,@PartnerCountryCode=NULL
fetch next from curr into @ICO, @Nazev
end

close curr
deallocate curr


END
GO
