SELECT 
'https://eu1.salesforce.com/' + a.Id [Account ID (Link)], 
a.Name [Company Name], 
'https://eu1.salesforce.com/' + c.Id [Contract ID (Link)], 
'https://eu1.salesforce.com/' + o.Id [Opportunity ID (Link)], 
o.StageName [Opportunity Stage], 
CONVERT(date, c.StartDate) [Contract Start],
CONVERT(date, c.EndDate) [Contract End]
 
FROM Salesforce..Account a
inner join Salesforce..[Contract] c ON a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
inner join Salesforce..Opportunity o ON a.Id collate latin1_general_CS_AS = o.AccountId collate latin1_general_CS_AS

WHERE
c.StartDate <=GETDATE() 
and 
c.EndDate > GETDATE() 
and 
c.Cancellation_Date__c is null 
and 
o.StageName not in ('Closed Lost','Closed Won')