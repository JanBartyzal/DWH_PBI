--- Create Currency
DECLARE @RC int
EXEC @RC = [dbo].[dimNewCurrency] @CurrencyShort='CZK'  ,@CurrencyName='Èeská koruna',@CurrencyRatio=1
EXEC @RC = [dbo].[dimNewCurrency] @CurrencyShort='EUR'  ,@CurrencyName='Euro',@CurrencyRatio=1
EXEC @RC = [dbo].[dimNewCurrency] @CurrencyShort='USD'  ,@CurrencyName='Americký dolar',@CurrencyRatio=1
EXEC @RC = [dbo].[dimNewCurrency] @CurrencyShort='GBP'  ,@CurrencyName='Britská libra',@CurrencyRatio=1
EXEC @RC = [dbo].[dimNewCurrency] @CurrencyShort='RUB'  ,@CurrencyName='Rubl',@CurrencyRatio=1

-- Create Continents
EXECUTE @RC = [dbo].[dimNewCountryContinent] @ContinentName='Evropa'
EXECUTE @RC = [dbo].[dimNewCountryContinent] @ContinentName='Afrika'
EXECUTE @RC = [dbo].[dimNewCountryContinent] @ContinentName='Asie'
EXECUTE @RC = [dbo].[dimNewCountryContinent] @ContinentName='Severni Amerika'
EXECUTE @RC = [dbo].[dimNewCountryContinent] @ContinentName='Jizni Amerika'
EXECUTE @RC = [dbo].[dimNewCountryContinent] @ContinentName='Australie'

--Create Regions
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='EU'
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='Evropa'
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='Severni Afrika'
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='SevAmerika'
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='StredAmerika'
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='JihAmerika'
EXECUTE @RC = [dbo].[dimNewCountryRegion] @RegionName='Pacifik'

--- Create Countries

EXECUTE @RC = [dbo].[dimNewCountry] @CountryCode='CZ' ,@CountryName='Czech' ,@ContinentName='Evropa' ,@RegionName='EU' ,@CurrencyCode='CZK'
EXECUTE @RC = [dbo].[dimNewCountry] @CountryCode='DE' ,@CountryName='Germany' ,@ContinentName='Evropa' ,@RegionName='EU' ,@CurrencyCode='EUR'
EXECUTE @RC = [dbo].[dimNewCountry] @CountryCode='FR' ,@CountryName='France' ,@ContinentName='Evropa' ,@RegionName='EU' ,@CurrencyCode='EUR'
EXECUTE @RC = [dbo].[dimNewCountry] @CountryCode='US' ,@CountryName='USA' ,@ContinentName='Severni Amerika' ,@RegionName='SevAmerika' ,@CurrencyCode='USD'
EXECUTE @RC = [dbo].[dimNewCountry] @CountryCode='RF' ,@CountryName='RussianFed' ,@ContinentName='Evropa' ,@RegionName='Evropa' ,@CurrencyCode='EUR'

-- Create Month desc
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=1  ,@MonthName='Leden' ,@QuartalName='Q1'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=2  ,@MonthName='Unor' ,@QuartalName='Q1'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=3  ,@MonthName='Brezen' ,@QuartalName='Q1'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=4  ,@MonthName='Duben' ,@QuartalName='Q2'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=5  ,@MonthName='Kveten' ,@QuartalName='Q2'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=6  ,@MonthName='Cerven' ,@QuartalName='Q2'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=7  ,@MonthName='Cervenec' ,@QuartalName='Q3'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=8  ,@MonthName='Srpen' ,@QuartalName='Q3'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=9  ,@MonthName='Zari' ,@QuartalName='Q3'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=10  ,@MonthName='Rijen' ,@QuartalName='Q4'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=11  ,@MonthName='Listopad' ,@QuartalName='Q4'  ,@BusinessName=NULL  ,@ClosingName=NULL
EXECUTE @RC = [dbo].[dimNewMonthTable] @MonthNum=12  ,@MonthName='Prosinec' ,@QuartalName='Q4'  ,@BusinessName=NULL  ,@ClosingName=NULL


--Create Sections
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=20  ,@SectionName='Strojírny'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=40  ,@SectionName='Metalurgie'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=90  ,@SectionName='Energetické projekty'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=50  ,@SectionName='Generální øeditel'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=99  ,@SectionName='Úsek kvality'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=80  ,@SectionName='Úsek Finance'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=14  ,@SectionName='Úsek Nákup'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=11  ,@SectionName='Úsek Služby'
EXECUTE @RC = [dbo].[dimNewSection] @SectionNumber=12  ,@SectionName='Banka'


EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=20
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=20  ,@CostCenterName='Vedeni', @SectionNumber=20
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Repre', @SectionNumber=20

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=40
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=20  ,@CostCenterName='Vedeni', @SectionNumber=40
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Repre', @SectionNumber=40

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=90
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Repre', @SectionNumber=90

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=50

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=99
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Repre', @SectionNumber=99

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=80
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Repre', @SectionNumber=80

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=11
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Repre', @SectionNumber=11

EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=10  ,@CostCenterName='Provoz', @SectionNumber=12
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=20  ,@CostCenterName='Kurzova rizika', @SectionNumber=12
EXECUTE @RC = [dbo].[dimNewCostCenter] @CostCenterNumber=99  ,@CostCenterName='Uroky', @SectionNumber=12



--Create test bank account
EXECUTE @RC = [dbo].[dimNewBankAccount] @BankAccountName='KB Provoz CZK' ,@BankAccountNumber='123456789' ,@BankAccountIban=''  ,@Currency='CZK'
EXECUTE @RC = [dbo].[dimNewBankAccount] @BankAccountName='KB Provoz EUR' ,@BankAccountNumber='987654321' ,@BankAccountIban=''  ,@Currency='EUR'
EXECUTE @RC = [dbo].[dimNewBankAccount] @BankAccountName='KB Provoz USD' ,@BankAccountNumber='555555555' ,@BankAccountIban=''  ,@Currency='USD'

-- Create Source name
EXECUTE @RC = [dbo].[dimNewSource] @SourceName='default'
EXECUTE @RC = [dbo].[dimNewSource] @SourceName='Pokladna'
EXECUTE @RC = [dbo].[dimNewSource] @SourceName='DataSklad'

-- Create new Commitments Type
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Pohledávky', @CommitmentTypeCode='POH'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Závazky', @CommitmentTypeCode='ZAV'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Inkaso', @CommitmentTypeCode='INK'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Výdaj', @CommitmentTypeCode='VYD'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='rizikové', @CommitmentTypeCode='POHR'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Pohledávky', @CommitmentTypeCode='POHLEDAVKA'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Závazky', @CommitmentTypeCode='ZAVAZEK'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Inkaso', @CommitmentTypeCode='INKASO'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Výdaj', @CommitmentTypeCode='VYDEJ'
EXECUTE @RC = [dbo].[dimNewCommitmentType] @CommitmentTypeName='Faktury', @CommitmentTypeCode='FAKTURA'


-- Test Partners---
EXECUTE	@RC = [dbo].[dimNewPartner] @PartnerICO = N'12345678', @PartnerName = N'Test s.r.o.', @PartnerAdress1 = N'Pøíèná 5',@PartnerAdress2 = null,
						@PartnerCity = N'Praha',@PartnerPostCode = N'14800',@PartnerCountryCode = N'CZ'
EXECUTE	@RC = [dbo].[dimNewPartner] @PartnerICO = N'87654321', @PartnerName = N'Železná koule s.r.o.', @PartnerAdress1 = N'Hrdinù 25',@PartnerAdress2 = null,
						@PartnerCity = N'Praha',@PartnerPostCode = N'14200',@PartnerCountryCode = N'CZ'
EXECUTE	@RC = [dbo].[dimNewPartner] @PartnerICO = N'52585456', @PartnerName = N'Vodní dìla a.s.', @PartnerAdress1 = N'Na rybníèku 1',@PartnerAdress2 = null,
						@PartnerCity = N'Praha',@PartnerPostCode = N'14900',@PartnerCountryCode = N'CZ'
EXECUTE	@RC = [dbo].[dimNewPartner] @PartnerICO = N'22222222', @PartnerName = N'WoodHouse a.s.', @PartnerAdress1 = N'V lese 2',@PartnerAdress2 = null,
						@PartnerCity = N'Praha',@PartnerPostCode = N'14100',@PartnerCountryCode = N'CZ'

EXECUTE	@RC = [dbo].[dimNewReferent]	@ReferentCode = N'JN01',@ReferentName = N'Jiri Novák',@CostCenterNumber = 0,	@SectionNumber = 50,@SupervisorCode = 'JN01'
EXECUTE	@RC = [dbo].[dimNewReferent]	@ReferentCode = N'PS02',@ReferentName = N'Petra Silná',@CostCenterNumber = 0,	@SectionNumber = 40,@SupervisorCode = 'JN01'
EXECUTE	@RC = [dbo].[dimNewReferent]	@ReferentCode = N'DK01',@ReferentName = N'Daniela Eva Krátká',@CostCenterNumber = 0,	@SectionNumber = 40,@SupervisorCode = 'JN01'


EXECUTE @RC = [dbo].[dimNewStatusEnforcment] @StatusEnforcmentName='AKTIVNI', @StatusEnforcmentCode='AKTIVNI'
EXECUTE @RC = [dbo].[dimNewStatusEnforcment] @StatusEnforcmentName='PASIVNI', @StatusEnforcmentCode='PASIVNI'


EXECUTE @RC = [dbo].[dimNewSpeciesType] @SpeciesTypeName='FAKTURA', @SpeciesTypeCode='FAKTURA'
EXECUTE @RC = [dbo].[dimNewSpeciesType] @SpeciesTypeName='SMLOUVA', @SpeciesTypeCode='SMLOUVA'

EXECUTE @RC = [dbo].[dimNewCategory] @CategoryName='KAT1', @CategoryCode='KAT1'
EXECUTE @RC = [dbo].[dimNewCategory] @CategoryName='KAT2', @CategoryCode='KAT2'
EXECUTE @RC = [dbo].[dimNewCategory] @CategoryName='KAT3', @CategoryCode='KAT3'
EXECUTE @RC = [dbo].[dimNewCategory] @CategoryName='KAT4', @CategoryCode='KAT4'
