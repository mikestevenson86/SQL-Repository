SELECT case when af.[SIC Code 2007] is not null then af.Sector else sc.Description end Sector,
 l.OutCode__c OutCode, pa.Region, COUNT(l.Id) Total,
 SUM(case when 		Status = 'open' 
		
		and
		((
		l.Website not like '%.gov.uk%' and l.Email not like '%gov.uk%'
		
		and
		l.Website not like '%.nhs.uk%' and l.Email not like '%nhs.uk%'
		
		and
		l.Website not like '%.royalmail.co%' and l.Email not like '%royalmail.co%') or Website is null or l.Email is null)

		and
		l.SIC2007_Code__c not in ('D','E','K','R')
		and l.SIC2007_Code3__c not in ('01629','09100','20150','20160','20200','20301','20412','35110','43110','47300')
		and l.SIC2007_Code3__c not in ('49100','49200','49311','49319','49320','50100','50200','50300','50400','51211')
		and l.SIC2007_Code3__c not in ('51210','55100','55201','55202','55209','55300','55900','56101','56102','56103')
		and l.SIC2007_Code3__c not in ('56210','56290','56301','56302','64110','64191','69101','69102','69109','82200')
		and l.SIC2007_Code3__c not in ('86101','86210','86220','80200','90010','90020','90030','90040','91011','91012')
		and l.SIC2007_Code3__c not in ('91020','91030','91040','92000','93110','93120','93130','93191','93199','93210','94910','99999')

		and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
		and LEFT(l.PostalCode,4) not between 'NP21' and 'NP24'
		and LEFT(l.PostalCode,4) not between 'SA16' and 'SA99'
		and LEFT(l.PostalCode,4) not between 'IV10' and 'IV39'
		and LEFT(l.PostalCode,4) not between 'PO30' and 'PO41'
		and l.Area_Code__c not in ('KW','BT','LD','ZE','GY','JE','IM','HS')
		
		and
		l.FT_Employees__c between 6 and 225
		
		and
		(l.Phone <> '' or l.Phone is not null)
		
		and
		IsTPS__c is null
		
		and
		(RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null) then 1 else 0 end) Diallable
FROM Salesforce..Lead l
left outer join SalesforceReporting..PostCodeArea pa ON l.OutCode__c = pa.Postcode
left outer join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.[SIC Code 3]
GROUP BY case when af.[SIC Code 2007] is not null then af.Sector else sc.Description end,
 l.OutCode__c, pa.Region
 ORDER BY case when af.[SIC Code 2007] is not null then af.Sector else sc.Description end,
 l.OutCode__c, pa.Region