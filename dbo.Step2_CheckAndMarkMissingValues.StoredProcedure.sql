USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step2_CheckAndMarkMissingValues]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step2_CheckAndMarkMissingValues]
AS
BEGIN
    -- Nastavení NOCOUNT, aby se zabránilo vracení mezivýsledků
    SET NOCOUNT ON;
	declare @countInt int, @countErr int, @src nvarchar(50), @msg nvarchar(255), @Datum date
    set @src = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID)

	set @msg = 'Missing values check started.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'

    -- Kontrola chybějících hodnot a označení řádků ve stgCFBanky
    UPDATE dbo.stgCFBanky
    SET Status = 1
    WHERE Datum IS NULL
    OR BankaUcet IS NULL
    OR Mena IS NULL
    OR StavMena IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgCFBanky (Datum, BankaUcet, Mena, StavMena)';
		set @msg = 'Missing values found and marked in stgCFBanky -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola chybějících hodnot a označení řádků ve stgCFInkasoVydej
    UPDATE dbo.stgCFInkasoVydej
    SET Status = 1
    WHERE Datum IS NULL
    OR TypCF IS NULL
    OR KodUsek IS NULL
    OR KodNS IS NULL
    OR Castka IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgCFInkasoVydej (Datum, TypCF, KodUsek, KodNS, Castka)';
		set @msg = 'Missing values found and marked in stgCFInkasoVydej  -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola chybějících hodnot a označení řádků ve stgCFZavazky
    UPDATE dbo.stgCFZavazky
    SET Status = 1
    WHERE Typ IS NULL
    OR Mena IS NULL
    OR DatumSplatnosti IS NULL
    OR Castka IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgCFZavazky (Typ, Mena, DatumSplatnosti, Castka)';
		set @msg = 'Missing values found and marked in stgCFZavazky  -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola chybějících hodnot a označení řádků ve stgKontrakt
    UPDATE dbo.stgKontrakt
    SET Status = 1
    WHERE ICO IS NULL
    OR Nazev IS NULL
    OR KodUsek IS NULL
    OR KodNS IS NULL
    OR KodStat IS NULL
    OR Datum IS NULL
    OR Mena IS NULL
    OR Castka IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgKontrakt (ICO, Nazev, KodUsek, KodNS, KodStat, Datum, Mena, Castka)';
		set @msg = 'Missing values found and marked in stgKontrakt -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola chybějících hodnot a označení řádků ve stgKurzovníListek
    UPDATE dbo.stgKurzovníListek
    SET Status = 1
    WHERE Datum IS NULL
    OR Mena IS NULL
    OR Kurz IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgKurzovníListek (Datum, Mena, Kurz)';
		set @msg = 'Missing values found and marked in stgKurzovníListek -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola chybějících hodnot a označení řádků ve stgPohledavkyZavazky
    UPDATE dbo.stgPohledavkyZavazky
    SET Status = 1
    WHERE Datum IS NULL
    OR Typ IS NULL
    OR Stav IS NULL
    OR Druh IS NULL
    OR KodUsek IS NULL
    OR KodNS IS NULL
    OR Castka IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgPohledavkyZavazky (Datum, Typ, Stav, Druh, KodUsek, KodNS, Castka)';
		set @msg = 'Missing values found and marked in stgPohledavkyZavazky -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola chybějících hodnot a označení řádků ve stgTrzby
    UPDATE dbo.stgTrzby
    SET Status = 1
    WHERE ICO IS NULL
    OR Nazev IS NULL
    OR KodUsek IS NULL
    OR KodNS IS NULL
    OR KodStat IS NULL
    OR Datum IS NULL
    OR Mena IS NULL
    OR Castka IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Missing values found and marked in stgTrzby (ICO, Nazev, KodUsek, KodNS, KodStat, Datum, Mena, Castka)';
		set @msg = 'Missing values found and marked in stgTrzby -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Dokončení kontroly
    PRINT 'Data quality check for missing values completed.';
	set @msg = 'Data quality check for missing values completed.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
END
GO
