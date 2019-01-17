SELECT a.Name
FROM [DEV2].Shorthorn.dbo.cit_sh_contacts shc
inner join [DEV2].Shorthorn.dbo.cit_sh_sites shs ON shc.siteID = shs.siteID
inner join [DEV2].Shorthorn.dbo.cit_sh_clients cl ON shs.clientID = cl.clientID
inner join [SF_SANDBOX]...Account a ON cl.companyName = a.Name
inner join [SF_SANDBOX]...contact c ON a.Id = c.AccountId
WHERE a.IsActive__c = 'true' and c.Active__c = 'true'