SELECT ds.dealId Shorthorn_Deal_Id__c, a.Id AccountId, ds.signDate startDate, renewDate endDate, dealLength ContractTerm, cost ContractValue,
SAGE_ContractID Sage_Contract_Number__c, noticeDate notice_date__c,
case when dealType in (1,13,17) then 'H&S' when dealType in (2,12,14) then 'PEL' when dealType in (3,7,15) then 'Combined' end Agreement_Template_Type__c,
case when dealStatus in (7,14,15) then 'Non' when dealStatus in (12,13) then 'Auto' end Renewal_Type__c,
case when dealType in (1,3) then 'true' else 'false' end Services_Taken_HS__c,
case when dealType in (2,3) then 'true' else 'false' end Services_Taken_EL__c,
case when dealType in (7,14) then 'true' else 'false' end Services_Taken_Advice_Only__c,
case when dealType in (7,13) then 'true' else 'false' end Services_Taken_Advice_Only_HS__c,
case when dealType in (15,12) then 'true' else 'false' end Services_Take_AI_Only__c,
case when dealType in (15,17) then 'true' else 'false' end Services_Take_AI_Only_HS__c
INTO #Deals
FROM [database].shorthorn.dbo.cit_sh_deals ds
inner join [database].shorthorn.dbo.cit_sh_clients cl ON ds.clientId = cl.clientId
inner join Salesforce..Account a ON cl.clientID = a.Shorthorn_Id__c
left outer join Salesforce..Contract c ON ds.dealId = c.Shorthorn_Deal_Id__c
WHERE c.Shorthorn_Deal_Id__c is null and a.Id is not null

SELECT ds.*
FROM #Deals ds
left outer join Salesforce..Contract c ON ds.AccountId = c.AccountId and ds.startDate = c.StartDate and ds.endDate = c.EndDate
WHERE c.Id is null

DROP TABLE #Deals