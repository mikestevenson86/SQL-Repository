SELECT CitationSector__c [Citation Sector], Id, Company, Name, Position__c Position, Status, Suspended_Closed_Reason__c [Suspended/Closed Reason],
Street, City, PostalCode, Phone, Email, Website, FT_Employees__c FTE
FROM Salesforce..Lead
WHERE Status <> 'Approved' and CitationSector__c like '%construct%' and (RecordTypeId not in ('012D0000000NbJtIAK','012D0000000KKTvIAO') or RecordTypeId is null)

SELECT CitationSector__c [Citation Sector], a.Id [Account ID], a.Name [Company Name], c.Id [Contact ID], c.Name [Contact Name], Position__c Position,
a.BillingStreet, a.BillingCity, a.BillingPostalCode, a.Phone, c.Email, a.Website, a.FT_employees__c
FROM Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountID
WHERE IsActive__c = 'true' and CitationSector__c like '%construct%' and c.Online_Super_User__c = 'yes'