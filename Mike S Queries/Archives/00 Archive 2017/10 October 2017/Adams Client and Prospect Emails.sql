SELECT 
'Accounts' [SFDC Object],
a.Id,
a.Name [Company Name],
a.[Type] [Status],
a.IsActive__c [Active / Closed Reason],
c.Name Contact,
c.Email,
c.HasOptedOutOfEmail [Email Opt Out]
FROM 
Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
WHERE 
a.[Type] in ('Client','Past Client')
	UNION ALL
SELECT
'Prospects',
l.Id,
l.Company,
l.[Status],
l.Suspended_Closed_Reason__c,
l.Name,
l.Email,
l.HasOptedOutOfEmail
FROM 
Salesforce..Lead l
WHERE 
l.[Status] = 'Closed' and Suspended_Closed_Reason__c <> 'Duplicate'