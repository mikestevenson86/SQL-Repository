SELECT Id, Company, 'Prospect' Type, FirstName + ' ' + LastName Contact, Position__c, Phone, Email,
case when SIC2007_Code3__c in ('69201','69202','69203') then 'Accountancy' else 'Recruitment' end Sector
FROM Salesforce..Lead
WHERE Status not in ('Approved','Suspended','Closed') and SIC2007_Code3__c in ('69201','69202','69203','78109','78200','78300')
UNION
SELECT a.ID, a.Name Company, 'Client' Type, c.FirstName + ' ' + c.LastName, c.Position__c, c.Phone, c.Email,
case when SIC2007_Code3__c in ('69201','69202','69203') then 'Accountancy' else 'Recruitment' end Sector
FROM Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountId
WHERE IsActive__c = 'true' and SIC2007_Code3__c in ('69201','69202','69203','78109','78200','78300')