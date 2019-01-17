SELECT CustomerAccountNumber 
INTO #Sage
FROM [sage].[Citation PLC].dbo.SLCustomerAccount

SELECT clientId
INTO #SH
FROM [database].shorthorn.dbo.cit_sh_clients

SELECT MAX(CIT001ContractID) ID, ContractNo
INTO #Contracts
FROM [SAGE].[Citation PLC].dbo.CIT001Contract
GROUP BY ContractNo

SELECT 
CONVERT(date, GETDATE()) RunDate,
'Account' Object,
Type Status,
SUM(case when sa.CustomerAccountNumber is null then 1 else 0 end) MissingSage,
SUM(case when sh.clientID is null then 1 else 0 end) MissingShorthorn,
SUM(case when sh.clientID is null and sa.CustomerAccountNumber is null then 1 else 0 end) MissingBoth
FROM
Salesforce..Account a
inner join Salesforce..Contract c ON a.Id = c.AccountId
left outer join #SH sh ON a.Shorthorn_Id__c = sh.clientId
left outer join #Sage sa ON a.Sage_Id__c = sa.CustomerAccountNumber
WHERE 
c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null 
and (c.RecordTypeId <> '012D0000000Nav7IAC' or c.RecordTypeId is null)
and (sa.CustomerAccountNumber is null or sh.clientID is null)
GROUP BY Type
UNION
SELECT
CONVERT(date, GETDATE()) RunDate,
'Contract' Object,
c.Status,
SUM(case when sc.ContractNo is null then 1 else 0 end) MissingSage,
SUM(case when d.DealID is null then 1 else 0 end) MissingShorthorn,
SUM(case when sc.ContractNo is null and d.DealID is null then 1 else 0 end) MissingBoth
FROM
Salesforce..Contract c
left outer join #Contracts sc ON c.Sage_Contract_Number__c = sc.ContractNo
left outer join [database].shorthorn.dbo.cit_sh_deals d ON c.Shorthorn_Deal_Id__c = d.dealID
WHERE 
c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null 
and (c.RecordTypeId <> '012D0000000Nav7IAC' or c.RecordTypeId is null)
and (sc.ContractNo is null or d.DealID is null)
GROUP BY Status

DROP TABLE #SH
DROP TABLE #Sage
DROP TABLE #Contracts