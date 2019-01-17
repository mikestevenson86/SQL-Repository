SELECT 
l.Id
FROM 
Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
WHERE 
SIC2007_Code3__c is not null and 
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