USE [PBI]
GO
/****** Object:  StoredProcedure [dbo].[Step2_CreateExchageRate]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Step2_CreateExchageRate]
@DateID int
AS
BEGIN
    SET NOCOUNT ON;

    declare @countInt int, @countErr int, @src nvarchar(50), @msg nvarchar(255), @Datum date
    set @src = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID)

    -- Pokud není zadán @DateID, zjisti nejstarší datum z tabulky stgCFBanky
    IF ISNULL(@DateID, 0) = 0
    BEGIN
        set @Datum = (SELECT TOP 1 Datum FROM [dbo].[stgCFBanky] ORDER BY Datum ASC)
        set @DateID = dbo.GetDateID(@Datum)

        set @msg = 'No DateID, found ' + convert(nvarchar(50), @DateID) + ' as oldest in table.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'I'
    END

    -- Zpracování dat, pokud je @DateID platný
    IF ISNULL(@DateID, 0) > 0
    BEGIN
        set @Datum = (SELECT TOP 1 FullDate FROM dbo.dimDate WHERE DateID = @DateID)

        -- Aktualizace statusu ve stgKurzovníListek pro aktuální datum
        UPDATE [dbo].[stgKurzovníListek]
        SET [Status] = 0
        WHERE [Status] IS NULL AND Datum = @Datum

        -- Kontrola, zda existují záznamy pro dané datum
        IF EXISTS (SELECT 1 FROM [dbo].[stgKurzovníListek] WHERE Datum = @Datum)
        BEGIN
            -- Odstranění starých záznamů v factExchangeRateCZK pro dané datum
            DELETE FROM [dbo].[factExchangeRateCZK] WHERE DateID = @DateID
            set @countErr = @@ROWCOUNT
            IF @countErr > 0
            BEGIN
                set @msg = 'Deleted ' + convert(nvarchar(50), @countErr) + ' records.'
                exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'W'
            END

            -- Aktualizace statusu pro validní měny v Kurzovní listek
            UPDATE kl
            SET [Status] = 1
            FROM [dbo].[stgKurzovníListek] kl
            INNER JOIN dbo.dimCurrency c ON c.CurrencyShort = kl.Mena
            WHERE kl.Datum = @Datum

            -- Vložení nových záznamů do factExchangeRateCZK
            INSERT INTO [dbo].[factExchangeRateCZK] ([DateId], [CurrencyToID], [Rate])
            SELECT @DateID, c.CurrencyID, kl.Kurz
            FROM [dbo].[stgKurzovníListek] kl
            INNER JOIN dbo.dimCurrency c ON c.CurrencyShort = kl.Mena
            WHERE kl.Datum = @Datum AND kl.[Status] = 1
            set @countInt = @@ROWCOUNT

            -- Log inserted values
            IF @countInt > 0
            BEGIN
                set @msg = 'Inserted ' + convert(nvarchar(50), @countInt) + ' new records.'
                exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'I'
            END

            -- Odstranění zpracovaných záznamů z Kurzovní listek
            DELETE FROM [dbo].[stgKurzovníListek] WHERE [Status] = 1
            set @countInt = @@ROWCOUNT

            -- Log removed values
            IF @countInt > 0
            BEGIN
                set @msg = 'Removed from Stage ' + convert(nvarchar(50), @countInt) + ' records.'
                exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'I'
            END
        END
        ELSE
        BEGIN
            -- Kopírování kurzů z předchozího dne, pokud pro daný den neexistují záznamy
            declare @DateID2 int
            set @DateID2 = (
                SELECT TOP 1 f.[DateId]
                FROM [factExchangeRateCZK] f
                INNER JOIN dbo.dimDate d ON d.DateID = f.DateId
                WHERE d.FullDate < @Datum
                ORDER BY d.FullDate DESC
            )

            INSERT INTO [dbo].[factExchangeRateCZK] ([DateId], [CurrencyToID], [Rate])
            SELECT @DateID, [CurrencyToID], [Rate]
            FROM [dbo].[factExchangeRateCZK]
            WHERE DateID = @DateID2
            set @countInt = @@ROWCOUNT

            -- Log copied records
            IF @countInt > 0
            BEGIN
                set @msg = 'Inserted ' + convert(nvarchar(50), @countInt) + ' copied records.'
                exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'I'
            END
        END
    END
    ELSE
    BEGIN
        -- Log invalid DateID
        set @msg = 'DateID ' + convert(nvarchar(50), @DateID) + ' is wrong.'
        exec dbo.LogStage @DateID = NULL, @Source = @src, @Message = @msg, @Status = 'F'
    END
END
GO
