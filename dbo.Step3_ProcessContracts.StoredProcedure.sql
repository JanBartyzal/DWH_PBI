USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessContracts]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessContracts]
@DateID INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum DATE;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgKontrakt
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgKontrakt] where Status=0 ORDER BY Datum ASC);
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

        -- Nastavení defaultního statusu ve stgKontrakt
        UPDATE [dbo].[stgKontrakt]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum;

        -- Vložení záznamů do temp tabulky @kontrakty
        DECLARE @kontrakty TABLE (
            [ICO] NVARCHAR(50),
            [Nazev] NVARCHAR(250),
            [KodUsek] NVARCHAR(50),
            [KodNS] NVARCHAR(50),
            [KodStat] NVARCHAR(3),
            [Datum] DATE,
            [Mena] NVARCHAR(3),
            [Castka] FLOAT,
            [ReferencniCislo] NVARCHAR(50),
            [ReferentName] NVARCHAR(250),
            [ReferentKod] NVARCHAR(50),
            [Naklady1] FLOAT,
            [PK] FLOAT,
            [Naklady2] FLOAT,
            [Marze] FLOAT,
            [DateID] INT,
            [PartnerId] INT,
            [CostCenterId] INT,
            [CountryId] INT,
            [CurrencyId] INT,
            [ReferentId] INT,
			[Zdroj] NVARCHAR(50),
			[SourceId] int
        );

        -- Naplnění temp tabulky daty ze stgKontrakt
        INSERT INTO @kontrakty ([ICO], [Nazev], [KodUsek], [KodNS], [KodStat], [Datum], [Mena], [Castka], [ReferencniCislo], [ReferentName], [ReferentKod], [Naklady1], [PK], [Naklady2], [Marze], [DateID], Zdroj)
        SELECT DISTINCT [ICO], [Nazev], [KodUsek], [KodNS], [KodStat], [Datum], [Mena], [Castka], [ReferencniCislo], [ReferentName], [ReferentKod], [Naklady1], [PK], [Naklady2], [Marze], @DateID, Zdroj
        FROM [dbo].[stgKontrakt]
        WHERE Datum = @Datum AND [Status] = 0;

        -- Aktualizace PartnerId na základě ICO
        UPDATE k
        SET k.PartnerId = p.PartnerId
        FROM @kontrakty k
        LEFT JOIN dbo.dimPartners p ON p.PartnerICO = k.ICO
        WHERE k.PartnerId IS NULL;

        -- Aktualizace CostCenterId na základě Kodu úseku
        UPDATE k
        SET k.CostCenterId = cc.CostCenterId
        FROM @kontrakty k
		left join dbo.dimSection s on s.SectionNumber=k.KodUsek
		LEFT JOIN dbo.dimCostCenter cc ON cc.SectionId = s.SectionId
        WHERE k.CostCenterId IS NULL
		and cc.CostCenterNumber=k.KodNS

        -- Aktualizace CountryId na základě KodStat
        UPDATE k
        SET k.CountryId = c.CountryId
        FROM @kontrakty k
        LEFT JOIN dbo.dimCountry c ON c.CountryCode = k.KodStat
        WHERE k.CountryId IS NULL;

        -- Aktualizace CurrencyId na základě Měny
        UPDATE k
        SET k.CurrencyId = cu.CurrencyId
        FROM @kontrakty k
        LEFT JOIN dbo.dimCurrency cu ON cu.CurrencyShort = k.Mena
        WHERE k.CurrencyId IS NULL;

        -- Aktualizace ReferentId na základě ReferentKodu
        UPDATE k
        SET k.ReferentId = r.ReferentId
        FROM @kontrakty k
        LEFT JOIN dbo.dimReferents r ON r.ReferentCode = k.ReferentKod
        WHERE k.ReferentId IS NULL;

		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @kontrakty b
        LEFT JOIN dbo.dimSource s ON s.SourceName = b.Zdroj
        WHERE b.[SourceId] IS NULL;

		--defaultni zdroj
		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @kontrakty b
        LEFT JOIN dbo.dimSource s ON s.SourceName = 'default'
        WHERE b.[SourceId] IS NULL;

		select * from @kontrakty

        -- Odstranění záznamů s neplatnými cizími klíči (PartnerId, CostCenterId, CountryId, CurrencyId, ReferentId)
        DELETE FROM @kontrakty
        WHERE PartnerId IS NULL OR CostCenterId IS NULL OR CountryId IS NULL OR CurrencyId IS NULL OR ReferentId IS NULL;

        -- Vložení/aktualizace záznamů do factContracts pomocí MERGE
        MERGE INTO dbo.factContracts AS tgt
        USING @kontrakty AS src
        ON tgt.DateID = src.DateID AND tgt.PartnerId = src.PartnerId AND tgt.CostCenterId = src.CostCenterId AND tgt.ReferenceNumber = src.ReferencniCislo and tgt.SourceId=src.SourceId
        WHEN MATCHED THEN
            UPDATE SET tgt.Amount = src.Castka, tgt.Costs1 = src.Naklady1, tgt.PK = src.PK, tgt.Costs2 = src.Naklady2, tgt.Margin = src.Marze
        WHEN NOT MATCHED THEN
            INSERT ([DateID], [PartnerId], [CostCenterId], [CountryId], [CurrencyId], [ReferenceNumber], [Amount], [ReferentId], [Costs1], [PK], [Costs2], [Margin], [SourceId])
            VALUES (src.DateID, src.PartnerId, src.CostCenterId, src.CountryId, src.CurrencyId, src.ReferencniCislo, src.Castka, src.ReferentId, src.Naklady1, src.PK, src.Naklady2, src.Marze, src.SourceId);

        -- Aktualizace statusu ve stgKontrakt na základě záznamů vložených do factContracts
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgKontrakt s
        JOIN @kontrakty k
        ON s.ICO = k.ICO
        AND s.ReferencniCislo = k.ReferencniCislo
		and isnull(s.Zdroj,'')=isnull(k.Zdroj,'')
        
        WHERE s.Datum = @Datum AND s.Status = 0;

        -- Odstranění zpracovaných záznamů ze stgKontrakt
        DELETE FROM [dbo].[stgKontrakt] WHERE Datum = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgKontrakt] SET [Status] = 9 WHERE Datum = @Datum AND [Status] = 0;
    END
END
GO
