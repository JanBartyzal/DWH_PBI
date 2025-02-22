USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessSales]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessSales]
@DateID INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum DATE;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgTrzby
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgTrzby] where Status=0  ORDER BY Datum ASC);
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

        -- Nastavení defaultního statusu ve stgTrzby
        UPDATE [dbo].[stgTrzby]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum;

        -- Vložení záznamů do temp tabulky @trzby
        DECLARE @trzby TABLE (
            [ICO] NVARCHAR(50),
            [Nazev] NVARCHAR(250),
            [KodUsek] NVARCHAR(50),
            [KodNS] NVARCHAR(50),
            [KodStat] NVARCHAR(3),
            [Datum] DATE,
            [Mena] NVARCHAR(3),
            [ReferencniCislo] NVARCHAR(50),
            [Castka] FLOAT,
            [Status] INT,
            [DateID] INT,
            [PartnerId] INT,
            [CostCenterId] INT,
            [CountryId] INT,
            [CurrencyId] INT,
            [Amount] FLOAT,
			[Zdroj] NVARCHAR(50),
			[SourceId] int
        );

        -- Naplnění temp tabulky daty ze stgTrzby
        INSERT INTO @trzby ([ICO], [Nazev], [KodUsek], [KodNS], [KodStat], [Datum], [Mena], [ReferencniCislo], [Castka], [DateID], Zdroj)
        SELECT DISTINCT [ICO], [Nazev], [KodUsek], [KodNS], [KodStat], [Datum], [Mena], [ReferencniCislo], [Castka], @DateID, Zdroj
        FROM [dbo].[stgTrzby]
        WHERE Datum = @Datum AND [Status] = 0;

        -- Aktualizace PartnerId na základě ICO
        UPDATE t
        SET t.PartnerId = p.PartnerId
        FROM @trzby t
        LEFT JOIN dbo.dimPartners p ON p.PartnerICO = t.ICO
        WHERE t.PartnerId IS NULL;

        -- Aktualizace CostCenterId na základě Kodu úseku
        UPDATE t
        SET t.CostCenterId = cc.CostCenterId
        FROM @trzby t
        left join dbo.dimSection s on s.SectionNumber=t.KodUsek
		LEFT JOIN dbo.dimCostCenter cc ON cc.SectionId = s.SectionId
        WHERE t.CostCenterId IS NULL
		and cc.CostCenterNumber=t.KodNS
        

        -- Aktualizace CountryId na základě KodStat
        UPDATE t
        SET t.CountryId = c.CountryId
        FROM @trzby t
        LEFT JOIN dbo.dimCountry c ON c.CountryCode = t.KodStat
        WHERE t.CountryId IS NULL;

        -- Aktualizace CurrencyId na základě Měny
        UPDATE t
        SET t.CurrencyId = cu.CurrencyId
        FROM @trzby t
        LEFT JOIN dbo.dimCurrency cu ON cu.CurrencyShort = t.Mena
        WHERE t.CurrencyId IS NULL;

		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @trzby b
        LEFT JOIN dbo.dimSource s ON s.SourceName = b.Zdroj
        WHERE b.[SourceId] IS NULL;

		--defaultni zdroj
		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @trzby b
        LEFT JOIN dbo.dimSource s ON s.SourceName = 'default'
        WHERE b.[SourceId] IS NULL;

		select * from @trzby

        -- Odstranění záznamů s neplatnými cizími klíči (PartnerId, CostCenterId, CountryId, CurrencyId)
        DELETE FROM @trzby
        WHERE PartnerId IS NULL OR CostCenterId IS NULL OR CountryId IS NULL OR CurrencyId IS NULL;

        -- Vložení/aktualizace záznamů do factSales pomocí MERGE
        MERGE INTO dbo.factSales AS tgt
        USING @trzby AS src
        ON tgt.DateId = src.DateID AND tgt.PartnerId = src.PartnerId AND tgt.CostCenterId = src.CostCenterId AND tgt.ReferenceNumber = src.ReferencniCislo and tgt.SourceId=src.SourceId
        WHEN MATCHED THEN
            UPDATE SET tgt.Amount = src.Castka
        WHEN NOT MATCHED THEN
            INSERT ([DateId], [PartnerId], [CostCenterId], [CountryId], [CurrencyId], [ReferenceNumber], [Amount], [SourceId])
            VALUES (src.DateID, src.PartnerId, src.CostCenterId, src.CountryId, src.CurrencyId, src.ReferencniCislo, src.Castka,src.SourceId);

        -- Aktualizace statusu ve stgTrzby na základě záznamů vložených do factSales
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgTrzby s
        JOIN @trzby t
        ON s.ICO = t.ICO
        AND s.ReferencniCislo = t.ReferencniCislo
        --AND s.Castka = t.Castka
		and isnull(s.Zdroj,'')=isnull(t.Zdroj,'')
        WHERE s.Datum = @Datum AND s.Status = 0;

        -- Odstranění zpracovaných záznamů ze stgTrzby
        DELETE FROM [dbo].[stgTrzby] WHERE Datum = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgTrzby] SET [Status] = 9 WHERE Datum = @Datum AND [Status] = 0;
    END
END
GO
