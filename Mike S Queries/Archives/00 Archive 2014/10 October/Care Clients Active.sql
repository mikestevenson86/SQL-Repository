SELECT 
a.Id [Salesforce ID],
a.Name [Company Name],
c.Name [Contact Name],
c.Position__c [Contact Position],
a.BillingStreet + ' ' + a.BillingCity + ' ' + a.BillingPostalCode [Address],
a.Phone,
c.Email [Contact Email],
a.SIC2007_Code3__c [SIC Code 3],
a.SIC2007_Description3__c [SIC Code 3 Description],
con.EndDate [Renew Date/End Date],
a.Shorthorn_Id__c [Shorthorn ID]
FROM
Salesforce..Account a
left outer join Salesforce..Contact c ON a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
left outer join Salesforce..Contract con ON a.Id collate latin1_general_CS_AS = con.AccountId collate latin1_general_CS_AS
WHERE a.Type = 'Client' and con.StartDate <= GETDATE() and con.EndDate >= GETDATE() and con.Cancellation_Date__c is null and 
(a.SIC2007_Code3__c in
(
84120,
87100,
88990,
87300,
87900,
88100,
86102,
86220
) or a.Sector__c like '%care%')
ORDER BY a.Id