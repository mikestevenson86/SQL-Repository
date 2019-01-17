SELECT a.Id AccountID, a.Name, c.Email
INTO #ClientEmails
FROM Salesforce..Contact c
inner join Salesforce..Account a on c.AccountId = a.Id
WHERE c.Email is not null and a.[Type] <> 'prospect'

SELECT 
'https://eu1.salesforce.com/' + l.id [Prospect Link], 
'https://eu1.salesforce.com/' + ce.AccountID [Account Link], 
l.email [Prospect Email], 
ce.Email [Client Email],l.Company [Prospect Name],
ce.Name [Account Name]

FROM Salesforce..Lead l
inner join #ClientEmails ce on l.Email = ce.Email 

WHERE l.[Status] = 'open'

DROP TABLE #ClientEmails