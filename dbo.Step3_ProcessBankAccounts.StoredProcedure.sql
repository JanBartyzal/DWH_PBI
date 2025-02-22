USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step3_ProcessBankAccounts]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step3_ProcessBankAccounts]
@DateID int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    --SET NOCOUNT ON;

    -- Deklarace proměnných
    DECLARE @Datum date;
    DECLARE @src NVARCHAR(50) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
    DECLARE @msg NVARCHAR(255);
	SET @msg = 'Process Step3_BankAccounts started.';
        EXEC dbo.LogStage @DateID = null, @Source = @src, @Message = @msg, @Status = 'I';

    -- Pokud @DateID není zadané, nastavíme nejstarší Datum ze stgCFBanky
    IF ISNULL(@DateID, 0) = 0 
    BEGIN
        SET @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgCFBanky] where Status=0 ORDER BY Datum ASC);
        SET @DateID = [dbo].[GetDateID](@Datum);

		IF ISNULL(@DateID, 0) > 0 
		BEGIN
        SET @msg = 'No DateID provided, found ' + CONVERT(NVARCHAR(50), @DateID) + ' as oldest in table.';
        EXEC dbo.LogStage @DateID = @DateID, @Source = @src, @Message = @msg, @Status = 'I';
		END
		ELSE BEGIN
		SET @msg = 'No DateID provided';
        EXEC dbo.LogStage @DateID = @DateID, @Source = @src, @Message = @msg, @Status = 'I';
		END

    END

    --PRINT @DateID;

    -- Pokud @DateID je validní, pokračujeme
    IF ISNULL(@DateID, 0) > 0 
    BEGIN
        -- Získání full date z dimDate
        SET @Datum = (SELECT TOP 1 FullDate FROM dbo.dimDate WHERE DateID = @DateID);

        -- Nastavení defaultního statusu ve stgCFBanky
        UPDATE [dbo].[stgCFBanky]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum;

        -- Vložení záznamů do temp tabulky @banka
        DECLARE @banka TABLE (
            [BankaUcet] NVARCHAR(50),
            [StavMena] FLOAT,
            [TotalPrijem] FLOAT,
            [TotalVydej] FLOAT,
            [DateID] INT,
            [BankAccountId] INT,
            [Balance] FLOAT,
            [TotIncome] FLOAT,
            [TotExpend] FLOAT,
			[Zdroj] NVARCHAR(50),
			[SourceId] int
        );

        INSERT INTO @banka ([BankaUcet], [StavMena], [TotalPrijem], [TotalVydej], [DateID], Zdroj)
        SELECT DISTINCT [BankaUcet], [StavMena], [TotalPrijem], [TotalVydej], @DateID, Zdroj
        FROM [dbo].[stgCFBanky]
        WHERE Datum = @Datum AND [Status] = 0;

        -- Aktualizace BankAccountId na základě BankAccountNumber a BankAccountIban
        UPDATE b
        SET b.BankAccountId = ba.BankAccountId
        FROM @banka b
        LEFT JOIN dbo.dimBankAccount ba ON ba.BankAccountNumber = b.BankaUcet
        WHERE b.BankAccountId IS NULL;

        UPDATE b
        SET b.BankAccountId = ba.BankAccountId
        FROM @banka b
        LEFT JOIN dbo.dimBankAccount ba ON ba.BankAccountIban = b.BankaUcet
        WHERE b.BankAccountId IS NULL;

		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @banka b
        LEFT JOIN dbo.dimSource s ON s.SourceName = b.Zdroj
        WHERE b.[SourceId] IS NULL;

		--defaultni zdroj
		UPDATE b
        SET b.[SourceId] = s.SourceId
        FROM @banka b
        LEFT JOIN dbo.dimSource s ON s.SourceName = 'default'
        WHERE b.[SourceId] IS NULL;

		select * from @banka
        -- Odstranění záznamů s neplatným BankAccountId
        DELETE FROM @banka WHERE BankAccountId IS NULL;
		set @msg = 'Unknown bank account. Rejected ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = @DateID, @Source = @src, @Message = @msg, @Status = 'R'

		DELETE FROM @banka WHERE SourceId IS NULL;
		set @msg = 'Unknown record source. Rejected ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = @DateID, @Source = @src, @Message = @msg, @Status = 'R'


        -- Vložení/aktualizace záznamů do factBankAccounts pomocí MERGE
        MERGE INTO dbo.factBankAccounts AS tgt
        USING @banka AS src
        ON tgt.DateID = src.DateID AND tgt.BankAccountId = src.BankAccountId and tgt.SourceId=src.SourceId
        WHEN MATCHED THEN
            UPDATE SET tgt.Balance = src.StavMena, tgt.TotIncome = src.TotalPrijem, tgt.TotExpend = src.TotalVydej
        WHEN NOT MATCHED THEN
            INSERT ([DateID], [BankAccountId], [Balance], [TotIncome], [TotExpend], [SourceId])
            VALUES (src.DateID, src.BankAccountId, src.StavMena, src.TotalPrijem, src.TotalVydej,src.SourceId);

        -- Aktualizace statusu ve stgCFBanky na základě záznamů vložených do factBankAccounts
        UPDATE s
        SET s.Status = 1
        FROM dbo.stgCFBanky s
        JOIN @banka b
        ON s.BankaUcet = b.BankaUcet
		and isnull(s.Zdroj,'')=isnull(b.Zdroj,'')
        WHERE s.Datum = @Datum AND s.Status = 0;

		set @msg = 'Inserted/updated ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'M'


		---select * from @banka




        -- Odstranění zpracovaných záznamů ze stgCFBanky
        DELETE FROM [dbo].[stgCFBanky] WHERE Datum = @Datum AND [Status] = 1;
        UPDATE [dbo].[stgCFBanky] SET [Status] = 9 WHERE Datum = @Datum AND [Status] = 0;
		set @msg = 'Rejected ' + convert(nvarchar(50), @@ROWCOUNT) + ' rows.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'R'


		
    END
	SET @msg = 'Process Step3_BankAccounts done.';
        EXEC dbo.LogStage @DateID = null, @Source = @src, @Message = @msg, @Status = 'I';
END
GO
