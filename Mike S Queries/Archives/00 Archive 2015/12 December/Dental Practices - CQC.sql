SELECT clientId, MAX(dealId) dealID
INTO #LastDeals
FROM Shorthorn..cit_sh_deals
GROUP BY clientId

SELECT a.Name [Company Name], a.Id [Salesforce ID], cl.clientId [Shorthorn ID], ds.renewDate [Renew Date],
case when ct.CQCDocs_Dental = 'Y' then 'Yes' else 'No' end CQC,
case when a.IsActive__c = 'true' then 'Yes' else 'No' end Active
FROM [DB01].Salesforce.dbo.Account a
left outer join Shorthorn..cit_sh_clients cl ON a.Shorthorn_Id__c = cl.clientID
left outer join CitationMain..citation_CompanyTable2 ct ON cl.sageCode COLLATE Latin1_General_CI_AS = ct.sageAC
left outer join #LastDeals ld ON cl.clientId = ld.clientId
left outer join Shorthorn..cit_sh_deals ds ON ld.dealID = ds.dealID
WHERE a.CitationSector__c = 'dental practice'

DROP TABLE #LastDeals