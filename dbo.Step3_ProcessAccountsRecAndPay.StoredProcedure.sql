USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessAccountsRecAndPay]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessAccountsRecAndPay]
@DateID INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum DATE;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgPohledavkyZavazky
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgPohledavkyZavazky] where Status=0  ORDER BY Datum ASC);
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

        -- Nastavení defaultního statusu ve stgPohledavkyZavazky
        UPDATE [dbo].[stgPohledavkyZavazky]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum;

        -- Vložení záznamů do temp tabulky @pohledavkyZavazky
        DECLARE @pohledavkyZavazky TABLE (
            [Datum] DATE,
            [Typ] NVARCHAR(50),
            [Stav] NVARCHAR(50),
            [Druh] NVARCHAR(50),
            [KodUsek] NVARCHAR(50),
            [KodNS] NVARCHAR(50),
            [ReferencniCislo] NVARCHAR(50),
            [Kategorie1] NVARCHAR(50),
            [Kategorie2] NVARCHAR(50),
            [Castka] FLOAT,
            [Status] INT,
            [DateID] INT,
            [CommitmentTypeId] INT,
            [CostCenterId] INT,
            [SpeciesTypeId] INT,
			[StatusEnforcmentId] INT,
            [CategoryId1] INT,
            [CategoryId2] INT,
            [Amount] FLOAT,
			[Zdroj] NVARCHAR(50),
			[SourceId] int
        );

        -- Naplnění temp tabulky daty ze stgPohledavkyZavazky
        INSERT INTO @pohledavkyZavazky ([Datum], [Typ], [Stav], [Druh], [KodUsek], [KodNS], [ReferencniCislo], [Kategorie1], [Kategorie2], [Castka], [DateID], Zdroj)
        SELECT DISTINCT [Datum], [Typ], [Stav], [Druh], [KodUsek], [KodNS], [ReferencniCislo], [Kategorie1], [Kategorie2], [Castka], @DateID, Zdroj
        FROM [dbo].[stgPohledavkyZavazky]
        WHERE Datum = @Datum AND [Status] = 0;

        -- Aktualizace CommitmentTypeId na základě Typu pohledávky/závazku
        UPDATE pz
        SET pz.CommitmentTypeId = ct.CommitmentTypeId
        FROM @pohledavkyZavazky pz
        LEFT JOIN dbo.dimCommitmentType ct ON ct.CommitmentTypeCode = pz.Typ
        WHERE pz.CommitmentTypeId IS NULL;

        -- Aktualizace CostCenterId na základě Kodu úseku
        UPDATE pz
        SET pz.CostCenterId = cc.CostCenterId
        FROM @pohledavkyZavazky pz
        left join dbo.dimSection s on s.SectionNumber=pz.KodUsek
		LEFT JOIN dbo.dimCostCenter cc ON cc.SectionId = s.SectionId
        WHERE pz.CostCenterId IS NULL
		and cc.CostCenterNumber=pz.KodNS

        -- Aktualizace SpeciesTypeId na základě Druhu
        UPDATE pz
        SET pz.SpeciesTypeId = st.SpeciesTypeId
        FROM @pohledavkyZavazky pz
        LEFT JOIN dbo.dimSpeciesType st ON st.SpeciesTypeCode = pz.Druh
        WHERE pz.SpeciesTypeId IS NULL;


		-- Aktualizace StatusEnforcmentId na základě Stavu
        UPDATE pz
        SET pz.StatusEnforcmentId = st.StatusEnforcmentId
        FROM @pohledavkyZavazky pz
        LEFT JOIN dbo.dimStatusEnforcment st ON st.StatusEnforcmentCode = pz.Stav
        WHERE pz.StatusEnforcmentId IS NULL;


        -- Aktualizace CategoryId1 a CategoryId2 na základě Kategorie1 a Kategorie2
        UPDATE pz
        SET pz.CategoryId1 = c1.CategoryId
        FROM @pohledavkyZavazky pz
        LEFT JOIN dbo.dimCategory c1 ON c1.CategoryCode = pz.Kategorie1
        WHERE pz.CategoryId1 IS NULL;

        UPDATE pz
        SET pz.CategoryId2 = c2.CategoryId
        FROM @pohledavkyZavazky pz
        LEFT JOIN dbo.dimCategory c2 ON c2.CategoryCode = pz.Kategorie2
        WHERE pz.CategoryId2 IS NULL;

		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @pohledavkyZavazky b
        LEFT JOIN dbo.dimSource s ON s.SourceName = b.Zdroj
        WHERE b.[SourceId] IS NULL;

		--defaultni zdroj
		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @pohledavkyZavazky b
        LEFT JOIN dbo.dimSource s ON s.SourceName = 'default'
        WHERE b.[SourceId] IS NULL;
		
		select * from @pohledavkyZavazky

        -- Odstranění záznamů s neplatnými cizími klíči (CommitmentTypeId, CostCenterId, SpeciesTypeId, CategoryId1, CategoryId2)
        DELETE FROM @pohledavkyZavazky
        WHERE CommitmentTypeId IS NULL OR CostCenterId IS NULL OR SpeciesTypeId IS NULL OR StatusEnforcmentId IS NULL OR CategoryId1 IS NULL OR CategoryId2 IS NULL;

        -- Vložení/aktualizace záznamů do factAccountsRecAndPay pomocí MERGE
        MERGE INTO dbo.factAccountsRecAndPay AS tgt
        USING @pohledavkyZavazky AS src
        ON tgt.DateId = src.DateID  and tgt.SourceId=src.SourceId
        AND tgt.TypId = src.CommitmentTypeId 
        AND tgt.SpeciesTypeId = src.SpeciesTypeId
        AND tgt.CostCenterId = src.CostCenterId
        AND tgt.ReferenceNumber = src.ReferencniCislo
        WHEN MATCHED THEN
            UPDATE SET tgt.Amount = src.Castka
        WHEN NOT MATCHED THEN
            INSERT ([DateId], [TypId], [StatusEnforcmentId], [SpeciesTypeId], [CostCenterId], [ReferenceNumber], [CategoryId1], [CategoryId2], [Amount], [SourceId])
            VALUES (src.DateID, src.CommitmentTypeId, src.[StatusEnforcmentId], src.SpeciesTypeId, src.CostCenterId, src.ReferencniCislo, src.CategoryId1, src.CategoryId2, src.Castka,src.SourceId);

        -- Aktualizace statusu ve stgPohledavkyZavazky na základě záznamů vložených do factAccountsRecAndPay
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgPohledavkyZavazky s
        JOIN @pohledavkyZavazky pz
        ON s.Typ = pz.Typ
        AND s.ReferencniCislo = pz.ReferencniCislo
        --AND s.Castka = pz.Castka
		and isnull(s.Zdroj,'')=isnull(pz.Zdroj,'')
        WHERE s.Datum = @Datum AND s.Status = 0;

        -- Odstranění zpracovaných záznamů ze stgPohledavkyZavazky
        DELETE FROM [dbo].[stgPohledavkyZavazky] WHERE Datum = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgPohledavkyZavazky] SET [Status] = 9 WHERE Datum = @Datum AND [Status] = 0;
    END
END
GO
