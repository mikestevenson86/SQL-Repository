SELECT Id, Company, 'Prospect' Type, FirstName + ' ' + LastName Contact, Position__c, Phone, Email,
case when SIC2007_Code3__c in ('69201','69202','69203') then 'Accountancy' else 'Recruitment' end Sector,
case when LEFT(PostalCode,2) in ('LU','AL','HP','SL') then 'Home Counties' else 'London' end Region
FROM Salesforce..Lead
WHERE Status not in ('Approved','Suspended','Closed') and SIC2007_Code3__c in ('69201','69202','69203','78109','78200','78300')
and LEFT(PostalCode, 2) in ('N1','N2','N3','N4','N5','N6','N7','N8','N9','E1','E2','E3','E4','E5','E6','E7','E8','E9',
'W1','W2','W3','W4','W5','W6','W7','W8','W9','SW','SE','NW','EC','WC','LU','AL','HP','SL')
UNION
SELECT a.ID, a.Name Company, 'Client' Type, c.FirstName + ' ' + c.LastName, c.Position__c, c.Phone, c.Email,
case when SIC2007_Code3__c in ('69201','69202','69203') then 'Accountancy' else 'Recruitment' end Sector,
case when LEFT(BillingPostalCode,2) in ('LU','AL','HP','SL') then 'Home Counties' else 'London' end Region
FROM Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountId
WHERE IsActive__c = 'true' and SIC2007_Code3__c in ('69201','69202','69203','78109','78200','78300')
and LEFT(BillingPostalCode, 2) in ('N1','N2','N3','N4','N5','N6','N7','N8','N9','E1','E2','E3','E4','E5','E6','E7','E8','E9',
'W1','W2','W3','W4','W5','W6','W7','W8','W9','SW','SE','NW','EC','WC','LU','AL','HP','SL')