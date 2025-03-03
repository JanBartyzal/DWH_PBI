USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessDebitDeposit]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessDebitDeposit]
@DateID INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum DATE;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgCFInkasoVydej
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgCFInkasoVydej] where Status=0  ORDER BY Datum ASC);
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

        -- Nastavení defaultního statusu ve stgCFInkasoVydej
        UPDATE [dbo].[stgCFInkasoVydej]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum;

        -- Vložení záznamů do temp tabulky @inkasoVydej
        DECLARE @inkasoVydej TABLE (
            [Datum] DATE,
            [TypCF] NVARCHAR(50),
            [KodUsek] NVARCHAR(50),
            [KodNS] NVARCHAR(50),
            [Castka] FLOAT,
            [Status] INT,
            [DateID] INT,
            [CommitmentTypeId] INT,
            [CostCenterId] INT,
            [Amount] FLOAT,
			[Zdroj] NVARCHAR(50),
			[SourceId] int
        );

        -- Naplnění temp tabulky daty ze stgCFInkasoVydej
        INSERT INTO @inkasoVydej ([Datum], [TypCF], [KodUsek], [KodNS], [Castka], [DateID], Zdroj)
        SELECT DISTINCT [Datum], [TypCF], [KodUsek], [KodNS], [Castka], @DateID, Zdroj
        FROM [dbo].[stgCFInkasoVydej]
        WHERE Datum = @Datum AND [Status] = 0;

        -- Aktualizace CommitmentTypeId na základě Typu Cash Flow
        UPDATE iv
        SET iv.CommitmentTypeId = ct.CommitmentTypeId
        FROM @inkasoVydej iv
        LEFT JOIN dbo.dimCommitmentType ct ON ct.CommitmentTypeCode = iv.TypCF
        WHERE iv.CommitmentTypeId IS NULL;

		-- Aktualizace CostCenterId na základě Kodu úseku
        UPDATE iv
        SET iv.CostCenterId = cc.CostCenterId
        FROM @inkasoVydej iv
		left join dbo.dimSection s on s.SectionNumber=iv.KodUsek
		LEFT JOIN dbo.dimCostCenter cc ON cc.SectionId = s.SectionId
        WHERE iv.CostCenterId IS NULL
		and cc.CostCenterNumber=iv.KodNS

		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @inkasoVydej b
        LEFT JOIN dbo.dimSource s ON s.SourceName = b.Zdroj
        WHERE b.[SourceId] IS NULL;

		--defaultni zdroj
		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @inkasoVydej b
        LEFT JOIN dbo.dimSource s ON s.SourceName = 'default'
        WHERE b.[SourceId] IS NULL;

		select * from @inkasoVydej

        -- Odstranění záznamů s neplatným CommitmentTypeId nebo CostCenterId
        DELETE FROM @inkasoVydej WHERE CommitmentTypeId IS NULL OR CostCenterId IS NULL;

        -- Vložení/aktualizace záznamů do factInkasoVydej pomocí MERGE
        MERGE INTO dbo.factDebitDeposit AS tgt
        USING @inkasoVydej AS src
        ON tgt.DateID = src.DateID AND tgt.CommitmentTypeId = src.CommitmentTypeId AND tgt.CostCenterId = src.CostCenterId and tgt.SourceId=src.SourceId
        WHEN MATCHED THEN
            UPDATE SET tgt.Amount = src.Castka
        WHEN NOT MATCHED THEN
            INSERT ([DateID], [CommitmentTypeId], [CostCenterId], [Amount], [SourceId])
            VALUES (src.DateID, src.CommitmentTypeId, src.CostCenterId, src.Castka,src.SourceId);

        -- Aktualizace statusu ve stgCFInkasoVydej na základě záznamů vložených do factInkasoVydej
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgCFInkasoVydej s
        JOIN @inkasoVydej iv
        ON s.TypCF = iv.TypCF
        AND s.KodUsek = iv.KodUsek
        AND s.KodNS = iv.KodNS
        --AND s.Castka = iv.Castka
		and isnull(s.Zdroj,'')=isnull(iv.Zdroj,'')
        WHERE s.Datum = @Datum AND s.Status = 0;

		select * from @inkasoVydej



        -- Odstranění zpracovaných záznamů ze stgCFInkasoVydej
        DELETE FROM [dbo].[stgCFInkasoVydej] WHERE Datum = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgCFInkasoVydej] SET [Status] = 9 WHERE Datum = @Datum AND [Status] = 0;
    END
END
GO
