SELECT OutCode__c, SIC2007_Code__c Sector, 'Cold' ColdAffinity, COUNT(Id) Prospects

FROM Salesforce..Lead l
WHERE Affinity_Cold__c = 'Cold'
and
(
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%'
) and
		Status = 'open' 
		
		and
		l.Website not like '%.gov.uk%' and l.Email not like '%gov.uk%'
		
		and
		l.Website not like '%.nhs.uk%' and l.Email not like '%nhs.uk%'
		
		and
		l.Website not like '%.royalmail.co%' and l.Email not like '%royalmail.co%'
		
		and
		Company not in (SELECT Company FROM SalesforceReporting..BadCompanies)

		and
		l.SIC2007_Code__c not in ('D','E','K','R')
		and l.SIC2007_Code3__c not in ('01629','09100','20150','20160','20200','20301','20412','35110','43110','47300')
		and l.SIC2007_Code3__c not in ('49100','49200','49311','49319','49320','50100','50200','50300','50400','51211')
		and l.SIC2007_Code3__c not in ('51210','55100','55201','55202','55209','55300','55900','56101','56102','56103')
		and l.SIC2007_Code3__c not in ('56210','56290','56301','56302','64110','64191','69101','69102','69109','82200')
		and l.SIC2007_Code3__c not in ('86101','86210','86220','80200','90010','90020','90030','90040','91011','91012')
		and l.SIC2007_Code3__c not in ('91020','91030','91040','92000','93110','93120','93130','93191','93199','93210','94910','99999')
	
		and
		l.FT_Employees__c between 6 and 225
		
		and
		(l.Phone <> '' or l.Phone is not null)
		
		and
		IsTPS__c is null
		
		and
		(RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null)
GROUP BY OutCode__c, SIC2007_Code__c 
UNION
SELECT OutCode__c, af.Sector, 'Affinity' ColdAffinity, COUNT(Id) Prospects

FROM Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE Affinity_Cold__c like 'Affinity%'
and
(
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%'
) and
		Status = 'open' 
		
		and
		l.Website not like '%.gov.uk%' and l.Email not like '%gov.uk%'
		
		and
		l.Website not like '%.nhs.uk%' and l.Email not like '%nhs.uk%'
		
		and
		l.Website not like '%.royalmail.co%' and l.Email not like '%royalmail.co%'
		
		and
		Company not in (SELECT Company FROM SalesforceReporting..BadCompanies)

		and
		l.SIC2007_Code__c not in ('D','E','K','R')
		and l.SIC2007_Code3__c not in ('01629','09100','20150','20160','20200','20301','20412','35110','43110','47300')
		and l.SIC2007_Code3__c not in ('49100','49200','49311','49319','49320','50100','50200','50300','50400','51211')
		and l.SIC2007_Code3__c not in ('51210','55100','55201','55202','55209','55300','55900','56101','56102','56103')
		and l.SIC2007_Code3__c not in ('56210','56290','56301','56302','64110','64191','69101','69102','69109','82200')
		and l.SIC2007_Code3__c not in ('86101','86210','86220','80200','90010','90020','90030','90040','91011','91012')
		and l.SIC2007_Code3__c not in ('91020','91030','91040','92000','93110','93120','93130','93191','93199','93210','94910','99999')
		
		and
		l.FT_Employees__c between 6 and 225
		
		and
		(l.Phone <> '' or l.Phone is not null)
		
		and
		IsTPS__c is null
		
		and
		(RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null)
GROUP BY OutCode__c, af.Sector

ORDER BY ColdAffinity, OutCode__c, Sector