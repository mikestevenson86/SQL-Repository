SELECT a.Id AccountID, a.Name, a.Phone
INTO #ClientPhones

FROM Salesforce..Account a

WHERE a.Phone is not null and a.[Type] <> 'prospect'

SELECT 
'https://eu1.salesforce.com/' + l.id [Prospect Link], 
'https://eu1.salesforce.com/' + cp.AccountID [Account Link], 
l.Phone [Prospect Phone], 
cp.Phone [Client Phone],
l.Company [Prospect Name],
cp.Name [Account Name]

FROM Salesforce..Lead l
inner join #ClientPhones cp on l.Phone = cp.Phone 

WHERE l.[Status] = 'open' and l.ConvertedAccountId is null

DROP TABLE #ClientPhones