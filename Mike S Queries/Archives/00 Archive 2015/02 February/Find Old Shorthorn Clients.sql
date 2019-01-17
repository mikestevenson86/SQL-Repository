SELECT 
            c.clientID,
            c.companyName, 
            [Last Deal] = 
            (SELECT TOP (1) d.renewDate 
            FROM [database].shorthorn.dbo.cit_sh_deals d 
            WHERE (renewDate <= DATEADD(YEAR, - 4, GETDATE())) AND (d.clientID = c.clientID) AND (d.salesRep = 120104) 
            ORDER BY d.renewDate DESC),
            a.Id
FROM
            [database].shorthorn.dbo.cit_sh_clients c
            left outer join Salesforce..Account a ON c.clientID = a.Shorthorn_Id__c
WHERE
            (SELECT TOP (1) d.renewDate 
            FROM [database].shorthorn.dbo.cit_sh_deals d 
            WHERE (renewDate <= DATEADD(YEAR, - 4, GETDATE())) AND (d.clientID = c.clientID) AND (d.salesRep = 120104) 
            ORDER BY d.renewDate DESC) IS NOT NULL
