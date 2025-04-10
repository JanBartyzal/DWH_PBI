USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step2_CheckStageDataQuality]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step2_CheckStageDataQuality]
AS
BEGIN
    -- Nastavení NOCOUNT, aby se zabránilo vracení mezivýsledků
    SET NOCOUNT ON;
	declare @countInt int, @countErr int, @src nvarchar(50), @msg nvarchar(255), @Datum date
    set @src = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID)

	set @msg = 'Data quality process started.'
    exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'

    -- Kontrola a označení duplicit v každé stage tabulce na základě klíčových sloupců

    -- Kontrola a označení duplicit pro stgCFBanky
    UPDATE s
    SET Status = 2
    FROM dbo.stgCFBanky s
    WHERE EXISTS (
        SELECT Datum, BankaUcet, Mena
        FROM dbo.stgCFBanky
        WHERE s.Datum = Datum
        AND s.BankaUcet = BankaUcet
        AND s.Mena = Mena
        GROUP BY Datum, BankaUcet, Mena
        HAVING COUNT(*) > 1
    );

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Duplicate rows found and marked in stgCFBanky based on (Datum, BankaUcet, Mena)';
		set @msg = 'Duplicate rows found and marked in stgCFBanky based on (Datum, BankaUcet, Mena) -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola a označení duplicit pro stgCFInkasoVydej
    UPDATE s
    SET Status = 2
    FROM dbo.stgCFInkasoVydej s
    WHERE EXISTS (
        SELECT Datum, TypCF, KodUsek, KodNS
        FROM dbo.stgCFInkasoVydej
        WHERE s.Datum = Datum
        AND s.TypCF = TypCF
        AND s.KodUsek = KodUsek
        AND s.KodNS = KodNS
        GROUP BY Datum, TypCF, KodUsek, KodNS
        HAVING COUNT(*) > 1
    );

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Duplicate rows found and marked in stgCFInkasoVydej based on (Datum, TypCF, KodUsek, KodNS)';
		set @msg = 'Duplicate rows found and marked in stgCFInkasoVydej based on (Datum, TypCF, KodUsek, KodNS) -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Validace hodnot proti dimenzionálním tabulkám a označení neplatných záznamů

    -- Validace měny ve stgCFBanky proti dimCurrency
    UPDATE s
    SET Status = 2
    FROM dbo.stgCFBanky s
    LEFT JOIN dbo.dimCurrency d ON s.Mena = d.CurrencyShort
    WHERE d.CurrencyShort IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Invalid currency found and marked in stgCFBanky';
		set @msg = 'Invalid currency found and marked in stgCFBanky ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Validace země ve stgKontrakt proti dimCountry
    UPDATE s
    SET Status = 2
    FROM dbo.stgKontrakt s
    LEFT JOIN dbo.dimCountry d ON s.KodStat = d.CountryCode
    WHERE d.CountryCode IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Invalid country code found and marked in stgKontrakt';
		set @msg = 'Invalid country code found and marked in stgKontrakt -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Kontrola správnosti číselných formátů a označení chybně formátovaných záznamů

    -- Kontrola číselného formátu ve stgCFZavazky (sloupec Castka)
    UPDATE s
    SET Status = 2
    FROM dbo.stgCFZavazky s
    WHERE TRY_CAST(s.Castka AS FLOAT) IS NULL;

    IF @@ROWCOUNT > 0
    BEGIN
        PRINT 'Invalid numeric format found and marked in stgCFZavazky for Castka';
		set @msg = 'Invalid numeric format found and marked in stgCFZavazky for Castk -  ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
    END

    -- Možné přidání dalších kontrol pro jiné stage tabulky, případně další validace dle potřeby

    -- Dokončení kontroly kvality dat
    PRINT 'Data quality checks completed.';
	set @msg = 'Data quality checks completed..'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'
END
GO
