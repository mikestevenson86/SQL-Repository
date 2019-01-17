SELECT a.Id, a.Type,

case when cl.clientID is null and ca.CustomerAccountNumber is null then 'Both'
when ca.CustomerAccountNumber is null then 'Sage' 
when cl.clientID is null then 'Shorthorn' end Missing

FROM Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
left outer join [SAGE].[Citation PLC].dbo.SLCustomerAccount ca ON a.Sage_Id__c = ca.CustomerAccountNumber
left outer join [database].shorthorn.dbo.cit_sh_clients cl ON a.Shorthorn_Id__c = cl.clientID
WHERE c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
and (cl.clientID is null or ca.CustomerAccountNumber is null)

GROUP BY a.Id, a.Type,

case when cl.clientID is null and ca.CustomerAccountNumber is null then 'Both'
when ca.CustomerAccountNumber is null then 'Sage' 
when cl.clientID is null then 'Shorthorn' end

ORDER BY a.Type

SELECT d.ClientId,

case when a.Id is null and ca.CustomerAccountNumber is null then 'Both'
when a.Id is null then 'Salesforce' 
when ca.CustomerAccountNumber is null then 'Sage' end Missing

FROM [database].Shorthorn.dbo.cit_sh_clients cl
inner join [database].Shorthorn.dbo.cit_sh_deals d ON cl.clientID = d.clientID
inner join [database].Shorthorn.dbo.cit_sh_dealStatus ds ON d.dealStatus = ds.DealStatusID
left outer join Salesforce..Account a ON LEFT(cl.SFDC_AccountID, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join [SAGE].[Citation PLC].dbo.SLCustomerAccount ca ON cl.SageCode = ca.CustomerAccountNumber
WHERE d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() 
and (a.Id is null or ca.CustomerAccountNumber is null)
GROUP BY d.ClientId,

case when a.Id is null and ca.CustomerAccountNumber is null then 'Both'
when a.Id is null then 'Salesforce' 
when ca.CustomerAccountNumber is null then 'Sage' end 