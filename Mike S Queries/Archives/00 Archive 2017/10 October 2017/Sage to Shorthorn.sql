SELECT dl.clientID, sfs.Id AccountID, sfs.CIT001ContractID [SageContractID], c.Id [SFDCContractID], dl.dealID [ShorthornContractID]
INTO SalesforceReporting..Sage_Shorthorn_SignDate
FROM SalesforceReporting..Sage_SFDC sfs
left outer join Salesforce..Account a ON sfs.Id = a.Id
left outer join [database].shorthorn.dbo.cit_sh_deals dl ON a.Shorthorn_Id__c = dl.clientId
left outer join Salesforce..Contract c ON dl.dealID = c.Shorthorn_Deal_Id__c
left outer join SalesforceReporting..CIT001Contract sc ON sfs.CIT001ContractID = sc.CIT001ContractID and sc.Signed = dl.signDate
WHERE dl.clientId is not null and sc.CIT001ContractID is not null
GROUP BY dl.clientID, sfs.Id, sfs.CIT001ContractID, c.Id, dl.dealID 
ORDER BY dl.clientId

SELECT dl.clientID, sfs.Id AccountID, sfs.CIT001ContractID [SageContractID], c.Id [SFDCContractID], dl.dealID [ShorthornContractID]
INTO SalesforceReporting..Sage_Shorthorn_FortnightSignDate
FROM SalesforceReporting..Sage_SFDC sfs
left outer join Salesforce..Account a ON sfs.Id = a.Id
left outer join [database].shorthorn.dbo.cit_sh_deals dl ON a.Shorthorn_Id__c = dl.clientId
left outer join Salesforce..Contract c ON dl.dealID = c.Shorthorn_Deal_Id__c
left outer join SalesforceReporting..CIT001Contract sc ON sfs.CIT001ContractID = sc.CIT001ContractID and sc.Signed between DATEADD(day,-7,dl.signDate) and DATEADD(day,7,dl.signDate)
WHERE dl.clientId is not null and sc.CIT001ContractID is not null
GROUP BY dl.clientID, sfs.Id, sfs.CIT001ContractID, c.Id, dl.dealID
ORDER BY dl.clientId

SELECT dl.clientID, sfs.Id AccountID, sfs.CIT001ContractID [SageContractID], c.Id [SFDCContractID], dl.dealID [ShorthornContractID]
INTO SalesforceReporting..Sage_Shorthorn_ContractNumber
FROM SalesforceReporting..Sage_SFDC sfs
left outer join Salesforce..Account a ON sfs.Id = a.Id
left outer join SalesforceReporting..CIT001Contract sc ON sfs.CIT001ContractID = sc.CIT001ContractID
left outer join [database].shorthorn.dbo.cit_sh_deals dl ON a.Shorthorn_Id__c = dl.clientId and sc.ContractNo = dl.SAGE_ContractId
left outer join Salesforce..Contract c ON c.Sage_Contract_Number__c = dl.SAGE_ContractId
WHERE dl.clientId is not null and sc.CIT001ContractID is not null and SAGE_ContractID is not null
GROUP BY dl.clientID, sfs.Id , sfs.CIT001ContractID, c.Id, dl.dealID
ORDER BY dl.clientId