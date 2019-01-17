SELECT u.Name,
SUM(case when l.SIC2007_Code3__c = 0 or l.SIC2007_Code3__c is null then 1 else 0 end)*0.15 ZeroSIC,
SUM(case when l.FT_Employees__c = 0 or l.FT_Employees__c is null then 1 else 0 end)*0.15 ZeroFTE,
SUM(case when (l.FT_Employees__c = 0 or l.FT_Employees__c is null) and (l.SIC2007_Code3__c = 0 or l.SIC2007_Code3__c is null) then 1 else 0 end)*0.15 ZeroSICandFTE
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE u.ProfileId = '00eD0000001IyheIAC' and u.IsActive = 'true' and


		Status = 'open' 
		
		and
		Website not like '%.gov.uk%' and Website not like '%.nhs.uk%'
		
		and
		l.Email not like '%gov.uk%' and l.Email not like '%nhs.uk%'
		
		and
		Company not in (SELECT Company FROM SalesforceReporting..BadCompanies)

		and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
		and LEFT(l.PostalCode,4) not between 'NP21' and 'NP24'
		and LEFT(l.PostalCode,4) not between 'SA16' and 'SA99'
		and LEFT(l.PostalCode,4) not between 'IV10' and 'IV39'
		and LEFT(l.PostalCode,4) not between 'PO30' and 'PO41'
		and l.Area_Code__c not in ('KW','BT','LD','ZE','GY','JE','IM','HS')

		and
		(l.Phone <> '' or l.Phone is not null)
		
		and
		
		(IsTPS__c is null or IsTPS__c <> 'Yes')
		
GROUP BY u.Name