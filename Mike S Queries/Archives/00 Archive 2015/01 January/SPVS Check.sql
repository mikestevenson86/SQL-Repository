SELECT ROW_NUMBER () OVER (ORDER BY Telephone) RecordId, s.*
INTO #NoClients
FROM SalesforceReporting..[SPVS Client Check] s
left outer join Salesforce..Account a1 ON (s.Practice like '%'+a1.Name+'%' or a1.Name like '%'+s.Practice+'%') and a1.Type = 'Client'
left outer join Salesforce..Account a2 ON s.Postcode = a2.BillingPostalCode and a2.Type = 'Client'
left outer join Salesforce..Account a3 ON REPLACE(s.Telephone,' ','') = REPLACE(a3.Phone,' ','') and a3.Type = 'Client'
left outer join Salesforce..Contact c ON s.Email = c.Email
left outer join Salesforce..Account a4 ON c.AccountId = a4.Id and a4.Type = 'Client'
WHERE a1.Id is null and a2.Id is null and a3.Id is null and a4.Id is null

SELECT *
FROM #NoClients

SELECT 
nc.RecordId,
nc.[First Name], 
nc.[Last Name], 
nc.[Job Title], 
nc.Practice,
nc.County, 
nc.Postcode, 
REPLACE(nc.Telephone,' ','') Telephone, 
nc.Email, 
l.Id, 
l.Status, 
l.Company,
REPLACE(l.Phone,' ','') Phone,
REPLACE(l.MobilePhone,' ','') MobilePhone,
REPLACE(l.Other_Phone__c, ' ','') OtherPhone,
l.PostalCode, 
l.Email
FROM #NoClients nc
left outer join Salesforce..Lead l ON
nc.Practice = l.Company
or
nc.Postcode = l.PostalCode
or
REPLACE(nc.Telephone,' ','') = REPLACE(l.Phone,' ','')
or
REPLACE(nc.Telephone,' ','') = REPLACE(l.MobilePhone,' ','')
or
REPLACE(nc.Telephone,' ','') = REPLACE(l.Other_Phone__c,' ','')
or
nc.Email = l.Email

DROP TABLE #NoClients