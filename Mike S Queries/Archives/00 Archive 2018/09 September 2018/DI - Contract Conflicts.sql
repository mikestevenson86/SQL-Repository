SELECT Id, Shorthorn_Deal_Id__c, c.Renewal_Type__c, ds.dealStatus, c.Renewal_Date__c
FROM Salesforce..Contract c
inner join [database].shorthorn.dbo.cit_sh_deals dl ON c.Shorthorn_Deal_Id__c = dl.dealId
inner join [database].shorthorn.dbo.cit_sh_dealStatus ds ON dl.dealStatus = ds.dealStatusId
WHERE c.Renewal_Type__c = 'Non-Auto' and dl.dealStatus in (12,13)