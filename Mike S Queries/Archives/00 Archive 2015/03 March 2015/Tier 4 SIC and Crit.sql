SELECT l.Id, Company, l.Phone, Status, SIC2007_Code__c, SIC2007_Description__c, SIC2007_Code2__c, SIC2007_Description2__c, 
SIC2007_Code3__c, SIC2007_Description3__c, u.Name BDM
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE Suspended_Closed_Reason__c = 'Tier 4 SIC Code' and
Company not in (SELECT Company FROM SalesforceReporting..BadCompanies) and 
Website not like '%.gov.uk%' and Website not like '%.nhs.uk%' and l.Email not like '%gov.uk%' and l.Email not like '%nhs.uk%'
and (l.Phone <> '0' or l.Phone <> '') and (IsTPS__c is null or IsTPS__c <> 'Yes') and
LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP21' and 'NP24'
and LEFT(l.PostalCode,4) not between 'SA16' and 'SA99'
and LEFT(l.PostalCode,4) not between 'IV10' and 'IV39'
and LEFT(l.PostalCode,4) not between 'PO30' and 'PO41'
and l.Area_Code__c not in ('KW','BT','LD','ZE','GY','JE','IM','HS') and FT_Employees__c between 10 and 500