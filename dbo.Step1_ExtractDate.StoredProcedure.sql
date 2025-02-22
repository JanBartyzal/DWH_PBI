USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step1_ExtractDate]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jan Bartyzal
-- Create date: 2024-09-01
-- Description:	Extract date from stage and create dim
-- =============================================
CREATE PROCEDURE [dbo].[Step1_ExtractDate]

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

declare @dates table
(FullDate date, DateChar nvarchar(8), DateID int)

declare @dates1 table
(FullDate date, DateChar nvarchar(8), DateID int)

insert into @dates (FullDate)
select [Datum] from [dbo].[stgCFBanky]

insert into @dates (FullDate)
select [Datum] from [dbo].[stgCFInkasoVydej]

insert into @dates (FullDate)
select [DatumSplatnosti] from [dbo].[stgCFZavazky]

insert into @dates (FullDate)
select [Datum] from [dbo].[stgKontrakt]

insert into @dates (FullDate)
select [Datum] from [dbo].[stgKurzovníListek]

insert into @dates (FullDate)
select [Datum] from [dbo].[stgPohledavkyZavazky]

insert into @dates (FullDate)
select [Datum] from [dbo].[stgTrzby]

insert into @dates (FullDate)
select GetDate()

----- Log start values ----
set @countErr=(select count (*) from @dates)
set @msg=(select 'Found ' + convert(nvarchar(50),@countErr) + ' records.' )
exec dbo.LogStage @DateID=null, @Source=@src, @Message=@msg, @Status='I'


update @dates
set DateChar=Convert(CHAR(8),FullDate,112)

update @dates
set DateID=Convert(INT,DateChar)
where DateChar is not null

insert into @dates1 (FullDate, DateChar,DateID)
select distinct FullDate, DateChar,DateID from @dates


update A
set A.FullDate=null
from @dates1 A
left join dbo.dimDate D on D.DateID=A.DateID
where D.DateID is not null

delete from @dates1
where FullDate is null

insert into dbo.dimDate ([DateID],[MonthNum],[FullDate])
select DateID, MONTH(FullDate),[FullDate]
from @dates1
SELECT @countInt=@@ROWCOUNT
----- Log inserted values ----
set @msg=(select 'Inserted ' + convert(nvarchar(50),@countInt) + ' new records.' )
exec dbo.LogStage @DateID=null, @Source=@src, @Message=@msg, @Status='I'

END
GO
