USE [PBI]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBankID]    Script Date: 22.12.2024 18:08:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetBankID]
(
	@AccountNum nvarchar(100)
)
RETURNS int
AS
BEGIN
declare @BankID int
	set @BankID=(Select BankAccountId from dbo.dimBankAccount where BankAccountNumber=@AccountNum)
	if isnull(@BankID,0)=0
	begin
		set @BankID=(Select BankAccountId from dbo.dimBankAccount where BankAccountIban=@AccountNum)
	end

	RETURN @BankID

END
GO
