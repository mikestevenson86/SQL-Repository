SELECt MAX(CIT001ContractID) ID, ContractNo
INTO #Contracts
FROM [SAGE].[Citation PLC].dbo.CIT001Contract
GROUP BY ContractNo

SELECT c.Id, c.Status,

case when con.ContractNo is null and d.dealID is null then 'Both'
when con.ContractNo is null then 'Sage' 
when d.dealID is null then 'Shorthorn' end Missing

FROM Salesforce..Contract c
left outer join #Contracts con ON c.Sage_Contract_Number__c = con.ContractNo
left outer join [database].shorthorn.dbo.cit_sh_Deals d ON c.Shorthorn_Deal_Id__c = d.dealID
WHERE c.StartDate <= GETDATE() and c.EndDate >= GETDATE() and c.Cancellation_Date__c is null
and (con.ContractNo is null or d.dealID is null)
ORDER BY c.Status

SELECT d.ClientId, d.dealID, ds.dealStatus,

case when (con.ContractNo is null or con.ContractNo = '') and c.ID is null then 'Both'
when c.ID is null then 'Salesforce' 
when con.ContractNo is null then 'Sage' end Missing

FROM [database].Shorthorn.dbo.cit_sh_deals d
inner join [database].Shorthorn.dbo.cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID
left outer join Salesforce..Contract c ON LEFT(d.SFDC_ContractId, 15) collate latin1_general_CS_AS = LEFT(c.Id, 15) collate latin1_general_CS_AS
left outer join #Contracts con ON d.Sage_ContractID = con.ContractNo
WHERE d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() 
and (con.ContractNo is null or con.ContractNo = '' or c.ID is null)

DROP TABLE #Contracts