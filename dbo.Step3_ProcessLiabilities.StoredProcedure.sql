USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessLiabilities]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessLiabilities]
@DateID int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum DATE;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgCFZavazky
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 DatumSplatnosti FROM [dbo].[stgCFZavazky] where Status=0  ORDER BY DatumSplatnosti ASC);
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

        -- Nastavení defaultního statusu ve stgCFZavazky
        UPDATE [dbo].[stgCFZavazky]
        SET [Status] = 0
        WHERE [Status] IS NULL AND DatumSplatnosti = @Datum;

        -- Vložení záznamů do temp tabulky @zavazky
        DECLARE @zavazky TABLE (
            [Typ] NVARCHAR(50),
            [Mena] NVARCHAR(3),
            [DatumSplatnosti] DATE,
            [Castka] FLOAT,
            [Status] INT,
            [DateID] INT,
            [CommitmentTypeId] INT,
            [CurrencyId] INT,
            [Amount] FLOAT,
			[Zdroj] NVARCHAR(50),
			[SourceId] int
        );

        -- Naplnění temp tabulky daty ze stgCFZavazky
        INSERT INTO @zavazky ([Typ], [Mena], [DatumSplatnosti], [Castka], [DateID], Zdroj)
        SELECT DISTINCT [Typ], [Mena], [DatumSplatnosti], [Castka], @DateID, Zdroj
        FROM [dbo].[stgCFZavazky]
        WHERE DatumSplatnosti = @Datum AND [Status] = 0;

        -- Aktualizace CommitmentTypeId na základě Typu závazku
        UPDATE z
        SET z.CommitmentTypeId = ct.CommitmentTypeId
        FROM @zavazky z
        LEFT JOIN dbo.dimCommitmentType ct ON ct.CommitmentTypeCode = z.Typ
        WHERE z.CommitmentTypeId IS NULL;

        -- Aktualizace CurrencyId na základě měny
        UPDATE z
        SET z.CurrencyId = c.CurrencyId
        FROM @zavazky z
        LEFT JOIN dbo.dimCurrency c ON c.CurrencyShort = z.Mena
        WHERE z.CurrencyId IS NULL;

		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @zavazky b
        LEFT JOIN dbo.dimSource s ON s.SourceName = b.Zdroj
        WHERE b.[SourceId] IS NULL;

		--defaultni zdroj
		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @zavazky b
        LEFT JOIN dbo.dimSource s ON s.SourceName = 'default'
        WHERE b.[SourceId] IS NULL;

		select * from @zavazky

        -- Odstranění záznamů s neplatným CommitmentTypeId nebo CurrencyId
        DELETE FROM @zavazky WHERE CommitmentTypeId IS NULL OR CurrencyId IS NULL;

        -- Vložení/aktualizace záznamů do factLiabilities pomocí MERGE
        MERGE INTO dbo.factLiabilities AS tgt
        USING @zavazky AS src
        ON tgt.DateID = src.DateID AND tgt.CommitmentTypeId = src.CommitmentTypeId AND tgt.CurrencyId = src.CurrencyId and tgt.SourceId=src.SourceId
        WHEN MATCHED THEN
            UPDATE SET tgt.Amount = src.Castka
        WHEN NOT MATCHED THEN
            INSERT ([DateID], [CommitmentTypeId], [CurrencyId], [Amount], [SourceId])
            VALUES (src.DateID, src.CommitmentTypeId, src.CurrencyId, src.Castka,src.SourceId);

        -- Aktualizace statusu ve stgCFZavazky na základě záznamů vložených do factLiabilities
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgCFZavazky s
        JOIN @zavazky z
        ON s.Typ = z.Typ
        AND s.Mena = z.Mena
        --AND s.Castka = z.Castka
		and isnull(s.Zdroj,'')=isnull(z.Zdroj,'')
        WHERE s.DatumSplatnosti = @Datum AND s.Status = 0;

        -- Odstranění zpracovaných záznamů ze stgCFZavazky
        DELETE FROM [dbo].[stgCFZavazky] WHERE DatumSplatnosti = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgCFZavazky] SET [Status] = 9 WHERE DatumSplatnosti = @Datum AND [Status] = 0;
    END
END
GO
