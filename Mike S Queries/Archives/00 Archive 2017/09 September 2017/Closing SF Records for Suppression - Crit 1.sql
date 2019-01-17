-- Clear temporary tables

IF OBJECT_ID('tempdb..#Clients') IS NOT NULL
	BEGIN
		DROP TABLE #Clients
	END
	
IF OBJECT_ID('tempdb..#ToxicTable') IS NOT NULL
	BEGIN
		DROP TABLE #ToxicTable
	END

-- Load temporary tables

SELECT Id
INTO #Clients
FROM
(
	SELECT l.Id
	FROM Salesforce..Lead l
	inner join Salesforce..Account a ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = 
										REPLACE(case when a.Phone like '0%' then a.Phone else '0'+a.Phone end,' ','')
	WHERE a.Citation_Client__c = 'true' and a.IsActive__c = 'true' and ISNULL(a.Phone,'') <> ''
	UNION
	SELECT l.Id
	FROM Salesforce..Lead l
	inner join Salesforce..Account a ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(a.Name,'Ltd',''),'Limited','')
										and REPLACE(l.PostalCode,' ','') = REPLACE(a.BillingPostalCode,' ','')
	WHERE a.Citation_Client__c = 'true' and a.IsActive__c = 'true' and ISNULL(a.Name,'') <> '' and ISNULL(a.BillingPostalcode,'') <> ''
) detail
GROUP BY Id

SELECT Id
INTO #ToxicTable
FROM
(
	SELECT l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..toxicdata t ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = 
													REPLACE(case when t.Phone like '0%' then t.Phone else '0'+t.Phone end,' ','')
	WHERE ISNULL(t.Phone,'') <> ''
	UNION
	SELECT l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..toxicdata t ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = 
													REPLACE(case when t.Mobile like '0%' then t.Mobile else '0'+t.Mobile end,' ','')
	WHERE ISNULL(t.Mobile,'') <> ''
	UNION
	SELECT l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..toxicdata t ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = 
													REPLACE(case when t.[Other Phone] like '0%' then t.[Other Phone] else '0'+t.[Other Phone] end,' ','')
	WHERE ISNULL(t.[Other Phone],'') <> ''
	UNION
	SELECT l.Id
	FROM Salesforce..Lead l
	inner join SalesforceReporting..toxicdata t ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(t.[Company   Account],'Ltd',''),'Limited','')
													and REPLACE(l.PostalCode,' ','') = REPLACE(t.[Post Code],' ','')
	WHERE ISNULL(t.[Company   Account],'') <> '' and ISNULL(t.[Post Code],'') <> ''
) detail
GROUP BY Id

-- Clear Crit 1 close tables

IF OBJECT_ID('NewVoiceMedia..Close_Clients_Crit1') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..Close_Clients_Crit1
	END

IF OBJECT_ID('NewVoiceMedia..Close_ToxicSIC_Crit1') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..Close_ToxicSIC_Crit1
	END

IF OBJECT_ID('NewVoiceMedia..Close_BadCompany_Crit1') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..Close_BadCompany_Crit1
	END

IF OBJECT_ID('NewVoiceMedia..Close_BadDomain_Crit1') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..Close_BadDomain_Crit1
	END

IF OBJECT_ID('NewVoiceMedia..Close_ToxicList_Crit1') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..Close_ToxicList_Crit1
	END

IF OBJECT_ID('NewVoiceMedia..Close_MLBranch_Crit1') IS NOT NULL
	BEGIN
		DROP TABLE NewVoiceMedia..Close_MLBranch_Crit1
	END

-- Load Crit 1 close tables

SELECT l.Id, Phone
INTO NewVoiceMedia..Close_Clients_Crit1
FROM Salesforce..Lead l
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
inner join #Clients cl ON l.Id = cl.Id
WHERE l.Status = 'Open' and rt.name = 'Default Citation Record Type'
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(Phone,'') <> ' ' and isnull(Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 

SELECT COUNT(Id) Clients
FROM NewVoiceMedia..Close_Clients_Crit1

SELECT l.Id, l.Phone
INTO NewVoiceMedia..Close_ToxicSIC_Crit1
FROM Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join NewVoiceMedia..Close_Clients_Crit1 cl ON l.Id = cl.Id
WHERE SIC2007_Code3__c in
(
'1629',
'38120',
'38220',
'43110',
'47300',
'49100',
'49200',
'49311',
'49319',
'49320',
'50100',
'50200',
'50300',
'50400',
'51220',
'52211',
'55300',
'64110',
'64191',
'64192',
'69101',
'69102',
'69109',
'80300',
'84210',
'84220',
'84230',
'84240',
'84250',
'84300',
'86101',
'86210',
'90040',
'91011',
'91012',
'91020',
'91030',
'91040',
'99999'
) and Status = 'Open' and rt.name = 'Default Citation Record Type'
and cl.Id is null
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(l.Phone,'') <> ' ' and isnull(l.Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 


SELECT COUNT(Id) Toxic
FROM NewVoiceMedia..Close_ToxicSIC_Crit1

SELECT l.Id, l.Phone
INTO NewVoiceMedia..Close_BadCompany_Crit1
FROM Salesforce..Lead l 
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join NewVoiceMedia..Close_Clients_Crit1 cc ON l.Id = cc.Id
left outer join NewVoiceMedia..Close_ToxicSIC_Crit1 t ON l.Id = t.Id
left outer join SalesforceReporting..BadCompanies bc ON REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(l.Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','') = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(bc.Company,'Ltd',''),'Limited',''),'&',''),'and',''),'plc','')
left outer join SalesforceReporting..BadCompanies_WildCards wc ON l.Company  collate latin1_general_CI_AS like wc.WildCard  collate latin1_general_CI_AS
WHERE Status = 'Open' and rt.Name = 'Default Citation Record Type' and (bc.Company is not null or wc.Wildcard is not null)
and cc.Id is null
and t.Id is null
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(l.Phone,'') <> ' ' and isnull(l.Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 


SELECT COUNT(Id) BadCompanies
FROM NewVoiceMedia..Close_BadCompany_Crit1

SELECT l.Id, l.Phone
INTO NewVoiceMedia..Close_BadDomain_Crit1
FROM Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join NewVoiceMedia..Close_Clients_Crit1 cc ON l.Id = cc.Id
left outer join NewVoiceMedia..Close_ToxicSIC_Crit1 t ON l.Id = t.Id
left outer join NewVoiceMedia..Close_BadCompany_Crit1 bc ON l.Id = bc.Id
left outer join SalesforceReporting..BadDomains_WildCards wc1 ON l.Email collate latin1_general_CI_AS like wc1.WildCard collate latin1_general_CI_AS
left outer join SalesforceReporting..BadDomains_WildCards wc3 ON l.Website collate latin1_general_CI_AS like wc3.WildCard collate latin1_general_CI_AS
WHERE Status = 'Open' and rt.Name = 'Default Citation Record Type' and (wc1.WildCard is not null or wc3.WildCard is not null)
and cc.Id is null
and t.Id is null
and bc.Id is null 
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(l.Phone,'') <> ' ' and isnull(l.Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 


SELECT COUNT(Id) BadDomains
FROM NewVoiceMedia..Close_BadDomain_Crit1

SELECT l.Id, l.Phone
INTO NewVoiceMedia..Close_ToxicList_Crit1
FROM Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join NewVoiceMedia..Close_Clients_Crit1 cc ON l.Id = cc.Id
left outer join NewVoiceMedia..Close_ToxicSIC_Crit1 t ON l.Id = t.Id
left outer join NewVoiceMedia..Close_BadCompany_Crit1 bc ON l.Id = bc.Id
left outer join NewVoiceMedia..Close_BadDomain_Crit1 bd ON l.Id = bd.Id
left outer join #ToxicTable tt ON l.Id  = tt.Id
WHERE Status = 'Open' and rt.Name = 'Default Citation Record Type' and tt.Id is not null
and cc.Id is null
and t.Id is null
and bc.Id is null
and bd.Id is null
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(l.Phone,'') <> ' ' and isnull(l.Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 


SELECT COUNT(Id) ToxicList
FROM NewVoiceMedia..Close_ToxicList_Crit1

SELECT l.ID, l.Phone
INTO NewVoiceMedia..Close_MLBranch_Crit1
FROM Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join NewVoiceMedia..Close_Clients_Crit1 cc ON l.Id = cc.Id
left outer join NewVoiceMedia..Close_ToxicSIC_Crit1 t ON l.Id = t.Id
left outer join NewVoiceMedia..Close_BadCompany_Crit1 bc ON l.Id = bc.Id
left outer join NewVoiceMedia..Close_BadDomain_Crit1 bd ON l.Id = bd.Id
left outer join NewVoiceMedia..Close_ToxicList_Crit1 tt ON l.Id  = tt.Id
left outer join MarketLocation..MainDataSet ml ON l.Market_Location_URN__c = ml.URN
WHERE Status = 'Open' and rt.Name = 'Default Citation Record Type' and ml.location_type = 'b'
and cc.Id is null
and t.Id is null
and bc.Id is null
and bd.Id is null
and tt.Id is null
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(l.Phone,'') <> ' ' and isnull(l.Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 


SELECT COUNT(Id) MLBranches
FROM NewVoiceMedia..Close_MLBranch_Crit1

SELECT *
FROM NewVoiceMedia..Close_Clients_Crit1

SELECT *
FROM NewVoiceMedia..Close_ToxicSIC_Crit1

SELECT *
FROM NewVoiceMedia..Close_BadCompany_Crit1

SELECT *
FROM NewVoiceMedia..Close_BadDomain_Crit1

SELECT *
FROM NewVoiceMedia..Close_ToxicList_Crit1

SELECT *
FROM NewVoiceMedia..Close_MLBranch_Crit1

SELECT COUNT(l.Id)
FROM Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join	(
			SELECT Id
			FROM
			(
			SELECT Id
			FROM NewVoiceMedia..Close_Clients_Crit1
			UNION
			SELECT Id
			FROM NewVoiceMedia..Close_ToxicSIC_Crit1
			UNION
			SELECT Id
			FROM NewVoiceMedia..Close_BadCompany_Crit1
			UNION
			SELECT Id
			FROM NewVoiceMedia..Close_BadDomain_Crit1
			UNION
			SELECT Id
			FROM NewVoiceMedia..Close_ToxicList_Crit1
			UNION
			SELECT Id
			FROM NewVoiceMedia..Close_MLBranch_Crit1
			) detail
			GROUP BY Id
			) detail ON l.Id = detail.Id
WHERE Status = 'Open' and rt.Name = 'Default Citation Record Type'
and Toxic_SIC__c <> 'true'
and ((FT_Employees__c between 6 and 225) or (FT_Employees__c < 225 and CitationSector__c = 'Care'))
and isnull(SIC2007_Code3__c,0) <> 0
and (isnull(l.Phone,'') <> ' ' and isnull(l.Phone,'') <> '')
and isnull(IsTPS__c,'') <> 'yes'
and TEXT_BDM__c <> 'Unassigned BDM'
and TEXT_BDM__c <> 'Salesforce Admin'
and isnull(TEXT_BDM__c,'') <> '' 
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'
and isnull(CitationSector__c,'') <> 'EDUCATION' 
and detail.Id is null