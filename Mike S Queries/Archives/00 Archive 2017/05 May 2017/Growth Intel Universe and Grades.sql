IF OBJECT_ID('tempdb..#Calls') IS NOT NULL
	BEGIN
		DROP TABLE #Calls
	END

IF OBJECT_ID('tempdb..#Crit') IS NOT NULL
	BEGIN
		DROP TABLE #Calls
	END

SELECT l.Id, COUNT(seqno) Dials, SUM(case when call_type in (0,2,4) then 1 else 0 end) Connects
INTO #Calls
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
GROUP BY l.Id

SELECT l.Id
INTO #Crit
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
WHERE SIC2007_Code3__c is not null and 
ISNULL(l.Phone,'') <> '' and 
Source__c not like 'LB%' and
Source__c not like 'Closed%' and
Source__c not like 'marketing%' and
Source__c not like 'toxic%' and
Source__c not like 'welcome%' and
p.Name like '%BDM%' and 
l.RecordTypeId = '012D0000000NbJsIAK' and 
IsTPS__c = 'No' and 
Toxic_SIC__c = 'false' and
(
	CitationSector__c = 'CARE'
	or
	(
		l.FT_Employees__c between 6 and 225 
		or 
		(l.FT_Employees__c = 5 and l.Country in ('Scotland','Northern Ireland'))
		or
		(CitationSector__c in ('CLEANING','HORTICULTURE') and l.FT_Employees__c between 4 and 225)
		or
		(CitationSector__c in ('DENTAL PRACTICE','DAY NURSERY','PHARMACY','FUNERAL SERVICES') and l.FT_Employees__c between 3 and 225)
	)
) and 
ISNULL(CitationSector__c,'') <> 'EDUCATION' 

SELECT 
gi.Grade, l.Source__c, COUNT(l.Id), SUM(c.Connects)

FROM
Salesforce..Lead l
left outer join SalesforceReporting..GI_Bridge br ON l.Id = br.SFDC_Id
left outer join SalesforceReporting..GI_Universe gi ON br.GI_Id = gi.[Registration Number]
left outer join #Calls c ON l.Id = c.Id

WHERE
br.SFDC_Id is not null
and
Date_Made__c > '2016-01-01'
and 
(
LEFT(MADE_Criteria__c,7) = 'Inbound'
or
LEFT(MADE_Criteria__c,8) = 'Outbound'
or
MADE_Criteria__c like '%Seminar%Appointment%'
)

GROUP BY
gi.Grade, l.Source__c

SELECT 
gi.Grade, COUNT(l.Id)

FROM
Salesforce..Lead l
left outer join SalesforceReporting..GI_Bridge br ON l.Id = br.SFDC_Id
left outer join SalesforceReporting..GI_Universe gi ON br.GI_Id = gi.[Registration Number]
left outer join #Crit c ON l.Id = c.Id

WHERE
c.Id is not null

GROUP BY
gi.Grade

SELECT
u.Name BDM,
OutCode__c,
gi.Grade,
COUNT(l.Id) TotalSF,
SUM(case when 
IsTps__c = 'No' and
l.[Status] = 'Open' 
and l.FT_Employees__c between 6 and 225
and l.SIC2007_Code3__c not in ('1629','20130','20140','20150','20160','20200','35110','35120','35130','35140','35210','35220','35230',
'35300','36000','37000','38110','38120','38220','38310','38320','39000','42120','43110','47300','49100','49200','49311','49319',
'49320','50100','50200','50300','50400','51220','52211','55202','55209','55300','64110','64191','64192','69101','69102','69109',
'80300','84210','84220','84230','84240','84250','84300','86101','86210','90040','91011','91012','91020','91030','91040','94910',
'99999')		
and l.Phone is not NULL
then 1 else 0 end) Available

FROM
Salesforce..Lead l
left outer join SalesforceReporting..GI_Bridge br ON l.Id = br.SFDC_Id
left outer join SalesforceReporting..GI_Universe gi ON br.GI_Id = gi.[Registration Number]
left outer join Salesforce..[User] u ON l.OwnerId = u.Id

GROUP BY
u.Name,
OutCode__c,
gi.Grade

DROP TABLE #Calls
DROP TABLE #Crit