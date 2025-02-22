USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessExchangeRates]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessExchangeRates]
@DateID INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum DATE;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgKurzovníListek
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgKurzovníListek]  where Status=0 ORDER BY Datum ASC);
        SET @DateID = [dbo].[GetDateID](@Datum);

        SET @msg = 'No DateID provided, found ' + CONVERT(NVARCHAR(50), @DateID) + ' as oldest in table.';
        EXEC dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'I';
    END

    PRINT @DateID;

    -- Pokud @DateID je validní, pokračujeme
    IF ISNULL(@DateID, 0) > 0 
    BEGIN
        -- Získání full date z dimDate
        SET @Datum = (SELECT TOP 1 FullDate FROM dbo.dimDate WHERE DateID = @DateID);

        -- Nastavení defaultního statusu ve stgKurzovníListek
        UPDATE [dbo].[stgKurzovníListek]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum;

        -- Vložení záznamů do temp tabulky @kurzovniListek
        DECLARE @kurzovniListek TABLE (
            [Datum] DATE,
            [Mena] NVARCHAR(5),
            [Kurz] FLOAT,
            [Status] INT,
            [DateID] INT,
            [CurrencyId] INT,
            [Rate] FLOAT,
			[SourceId] int
        );

        -- Naplnění temp tabulky daty ze stgKurzovníListek
        INSERT INTO @kurzovniListek ([Datum], [Mena], [Kurz], [DateID])
        SELECT DISTINCT [Datum], [Mena], [Kurz], @DateID
        FROM [dbo].[stgKurzovníListek]
        WHERE Datum = @Datum AND [Status] = 0;

        -- Aktualizace CurrencyId na základě Měny
        UPDATE kl
        SET kl.CurrencyId = cu.CurrencyId
        FROM @kurzovniListek kl
        LEFT JOIN dbo.dimCurrency cu ON cu.CurrencyShort = kl.Mena
        WHERE kl.CurrencyId IS NULL;

		select * from @kurzovniListek
		
        -- Odstranění záznamů s neplatným CurrencyId
        DELETE FROM @kurzovniListek WHERE CurrencyId IS NULL;

        -- Vložení/aktualizace záznamů do factExchangeRateCZK pomocí MERGE
        MERGE INTO dbo.factExchangeRateCZK AS tgt
        USING @kurzovniListek AS src
        ON tgt.DateId = src.DateID AND tgt.CurrencyToId = src.CurrencyId 
        WHEN MATCHED THEN
            UPDATE SET tgt.Rate = src.Kurz
        WHEN NOT MATCHED THEN
            INSERT ([DateId], [CurrencyToId], [Rate])
            VALUES (src.DateID, src.CurrencyId, src.Kurz);

        -- Aktualizace statusu ve stgKurzovníListek na základě záznamů vložených do factExchangeRateCZK
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgKurzovníListek s
        JOIN @kurzovniListek kl
        ON s.Mena = kl.Mena
        --AND s.Kurz = kl.Kurz

        WHERE s.Datum = @Datum AND s.Status = 0;

        -- Odstranění zpracovaných záznamů ze stgKurzovníListek
        DELETE FROM [dbo].[stgKurzovníListek] WHERE Datum = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgKurzovníListek] SET [Status] = 9 WHERE Datum = @Datum AND [Status] = 0;
    END
END
GO
