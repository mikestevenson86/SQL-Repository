IF OBJECT_ID('tempdb..#List') IS NOT NULL
	BEGIN
		DROP TABLE #List
	END

DECLARE @ProspectNo as Int
DECLARE @Lno as VarChar(10)
DECLARE @Region as VarChar(100)
DECLARE @NewTable as VarChar(30)

CREATE TABLE #List
(
ID int identity,
BuildID int,
Region VarChar(100),
BDM VarChar(255),
ListNo VarChar(10),
LeadID NCHAR(18)
)

DECLARE @Int as int
SET @Int = 1

WHILE @Int <=	(
				SELECT MAX(ID) 
				FROM NewVoiceMedia..Build_20170907
				)
	BEGIN
	
		SET @ProspectNo =	(
							SELECT ProspectNo 
							FROM NewVoiceMedia..Build_20170907 
							WHERE ID = @Int
							)

		SELECT @Lno = ListNo FROM NewVoiceMedia..Build_20170907 WHERE ID = @Int
		SELECT @Region = Region FROM NewVoiceMedia..Build_20170907 WHERE ID = @Int
	
		INSERT INTO #List 
		(BuildID, Region, BDM, ListNo, LeadID)
		
		SELECT
		TOP (@ProspectNo)
		
		@Int,
		@Region,
		u.Name BDM,
		@Lno,
		--ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY ISNULL(l.Last_Call_Date__c,'1899-01-01')) BDMID,
		l.Id
		
		FROM
		Salesforce..Lead l
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		
		WHERE
		u.Name = (SELECT BDM FROM NewVoiceMedia..Build_20170907 WHERE ID = @Int)
		and
		case
		when CitationSector__c in ('CARE','MANUFACTURING','ARCHITECTURAL & ENGINEERING')
		then 'List 1a'
		when CitationSector__c in ('GLASS & GLAZING','CONSTRUCTION','WATER SUPPLY ACTIVITIES','TRANSPORTATION AND STORAGE','SPORTS & ENTERTAINMENT','INFORMATION AND COMMUNICATION','DAY NURSERY')
		then 'List 1b'
		when CitationSector__c in ('ACCOMMODATION','ADMINISTRATIVE AND SUPPORT SERVICE ACTIVITIES','RENTING & LEASING','VETERINARY ACTIVITIES','CLEANING','WHOLESALE EXCLUDING MOTOR','SECURITY','AGRICULTURE','FINANCIAL AND INSURANCE ACTIVITIES','FOOD & BEVERAGE','HUMAN HEALTH ACTIVITIES')
		then 'List 2'
		when CitationSector__c in ('HORTICULTURE','MOTORTRADE','RETAIL EXCLUDING MOTOR','PROFESSIONAL ACTIVITIES','B2C SERVICES','REAL ESTATE ACTIVITIES','FUNERAL SERVICES')
		then 'List 3'
		end  = (SELECT CONVERT(VarChar, ListNo) FROM NewVoiceMedia..Build_20170907 WHERE ID = @Int)
		/*
		and
		List_ID = (SELECT CONVERT(VarChar, ListNo) FROM #Builds WHERE ID = @Int)
		(
		NVM_next_eligible < GETDATE() or ISNULL(NVM_Next_Eligible,'') = ''
		)
		*/
		and
		Status = 'Open'
		and
		IsTPS__c <> 'Yes'
		and
		RecordTypeId = '012D0000000NbJsIAK'
		and
		l.Phone <> ''
		and
		Toxic_SIC__c <> 'TRUE'
		and
		BDC__c is null
		and
		(
			CitationSector__c = 'Care'
			or
			(
				(
					FT_Employees__c between 6 and 225 
					or 
					(
						FT_Employees__c = 5 and TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Angela Prior','Cormac McGreevey')
					)
				)
				or
				(
					CitationSector__c = 'CLEANING' and FT_Employees__c between 4 and 225
				)
				or
				(
					CitationSector__c = 'DENTAL PRACTICE' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c = 'HORTICULTURE' and FT_Employees__c between 4 and 225
				)
				or
				(
					CitationSector__c = 'DAY NURSERY' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c like '%FUNERAL%' and FT_Employees__c between 3 and 225
				)
				or
				(
					CitationSector__c = 'PHARMACY' and FT_Employees__c between 3 and 225
				)
			)
		)
		and 
		CitationSector__c <> 'EDUCATION'
		and
		Source__c not like '%Closed Lost%'
		and
		Source__c not like '%Marketing Lost%'
		
		ORDER BY
		ISNULL(Last_Call_Date__c, GETDATE()) DESC,l.CreatedDate
		
		SET @Int = @Int + 1
	
	END

SET @NewTable = 'DiallerList_' + REPLACE(CONVERT(VarChar,(CONVERT(date,GETDATE()))),'-','')

IF OBJECT_ID('Salesforce..' + @NewTable) IS NOT NULL
	BEGIN
		EXECUTE('DROP TABLE Salesforce..' + @NewTable)
	END

EXECUTE(	
'SELECT 
li.*, 
Status,
CitationSector__c, 
Last_Call_Date__c, 
CreatedDate,
Source__c,
FT_Employees__c, 
Toxic_SIC__c,
IsTPS__c, 
RecordTypeId, 
Phone,
ROW_NUMBER () OVER (PARTITION BY Region, ListNo ORDER BY BuildID, ISNULL(Last_Call_Date__c, ''1899-01-01''),l.CreatedDate) ListID

INTO 
NewVoiceMedia..' + @NewTable + '

FROM 
#List li 
inner join Salesforce..Lead l ON li.LeadID = l.Id

ORDER BY 
li.ID'
)