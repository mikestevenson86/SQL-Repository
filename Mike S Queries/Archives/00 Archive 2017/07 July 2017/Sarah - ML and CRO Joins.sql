IF OBJECT_ID('SalesforceReporting..Lead_ML_CRO_July2017') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..Lead_ML_CRO_July2017
	END

CREATE TABLE SalesforceReporting..Lead_ML_CRO_July2017
(
Id NCHAR(18),
ML_URN VarChar(50),
CH_CRO VarChar(50),
JoinTable VarChar(50)
)

-- Load ML URN without CRO from Market Location

INSERT INTO SalesforceReporting..Lead_ML_CRO_July2017
SELECT l.Id, ml.URN, '', 'Market Location' JoinTable
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(REPLACE(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''),' ',''),'plc','')
											= REPLACE(REPLACE(REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited',''),' ',''),'plc','')
											and
											REPLACE(l.PostalCode,' ','')
											= REPLACE(ml.PostCode,' ','')
WHERE ISNULL(l.Market_Location_URN__c,'') = '' and ISNULL(l.Co_Reg__c,'') <> ''

-- Load ML URN with CRO from Market Location

INSERT INTO SalesforceReporting..Lead_ML_CRO_July2017
SELECT l.Id, ml.URN ML_URN, ml.cro_number CH_CRO, 'Market Location' JoinTable
FROM Salesforce..Lead l
inner join MarketLocation..MainDataSet ml ON REPLACE(REPLACE(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''),' ',''),'plc','')
											= REPLACE(REPLACE(REPLACE(REPLACE(ml.[Business Name],'Ltd',''),'Limited',''),' ',''),'plc','')
											and
											REPLACE(l.PostalCode,' ','')
											= REPLACE(ml.PostCode,' ','')
WHERE ISNULL(l.Market_Location_URN__c,'') = '' and ISNULL(l.Co_Reg__c,'') = '' 

-- Build Temporary Table with all Companies House CRO

SELECT l.Id, '' ML_URN, ch.[ CompanyNumber] CH_CRO, 'Companies House' JoinTable
INTO #Temp
FROM Salesforce..Lead l
inner join SalesforceReporting..CompaniesHouse ch ON REPLACE(REPLACE(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''),' ',''),'plc','')
													= REPLACE(REPLACE(REPLACE(REPLACE(ch.CompanyName,'Ltd',''),'Limited',''),' ',''),'plc','')
													and
													REPLACE(l.PostalCode,' ','')
													= REPLACE(ch.[RegAddress PostCode],' ','')
WHERE ISNULL(l.Co_Reg__c,'') = ''

-- Update Join Table where Companies House has joint with same prospect as Market Location

UPDATE j
SET CH_CRO = t.CH_CRO, JoinTable = j.JoinTable + '/Companies House'
FROM SalesforceReporting..Lead_ML_CRO_July2017 j
inner join #Temp t ON j.Id = t.Id

-- Insert remainder of Companies House CRO into Join table

INSERT INTO SalesforceReporting..Lead_ML_CRO_July2017
SELECT *
FROM #Temp
WHERE Id not in (SELECT Id FROM SalesforceReporting..Lead_ML_CRO_July2017)