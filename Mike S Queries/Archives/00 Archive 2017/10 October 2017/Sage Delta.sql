SELECT 
sfs.*, 
c.Status, 
case when c.StartDate < GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null then 'Active' else 'InActive' end Activity
FROM SalesforceReporting..Sage_SFDC sfs
inner join Salesforce..Contract c ON sfs.ContractId = c.Id

SELECT shs.*,
dl.SAGE_ContractId, 
ds.dealStatus,
case when dl.signDate < GETDATE() and dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18) then 'Active' else 'InActive' end Activity
FROM SalesforceReporting..Sage_Shorthorn shs
inner join [database].shorthorn.dbo.cit_sh_Deals dl ON shs.ContractId = dl.dealId
inner join [database].shorthorn.dbo.cit_sh_dealStatus ds ON dl.dealStatus = ds.dealStatusId

SELECT *
FROM SalesforceReporting..SageContracts_October2017