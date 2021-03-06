SELECT ds.clientId, renewDate, cost, dealLength
INTO #Temp
FROM Shorthorn..cit_sh_deals ds
inner join
(
SELECT clientId, MAX(renewDate) LastRenew
FROM Shorthorn..cit_sh_deals
GROUP BY clientId
) detail ON ds.clientID = detail.clientID and ds.renewDate = detail.LastRenew

SELECT ct.coName, COUNT(appUsageID) Total,
SUM(case when au.appID = 1 then 1 else 0 end) Citassess,
SUM(case when au.appID = 2 then 1 else 0 end) Citmanager,
SUM(case when au.appID = 3 then 1 else 0 end) Citnet,
SUM(case when au.appID = 4 then 1 else 0 end) [H&S Checklists],
SUM(case when au.appID = 5 then 1 else 0 end) [Annual Inspection Reports],
SUM(case when au.appID = 6 then 1 else 0 end) [Client Documents],
SUM(case when au.appID = 7 then 1 else 0 end) PreTender,
SUM(case when au.appID = 8 then 1 else 0 end) CitDocs,
SUM(case when au.appID = 9 then 1 else 0 end) CQC,
SUM(case when au.appID = 10 then 1 else 0 end) Cittrainer,
MAX(whenUsed) LastLogin,
ct.postcode,
ct.sageAC,
ct.contactName,
ct.contactEmail,
ct.contactPhone,
t.cost,
t.renewDate,
t.dealLength
FROM [CitationMain].[dbo].[citation_appUsage] au
inner join CitationMain..citation_CompanyTable2 ct ON au.compID = ct.uid
inner join Shorthorn..cit_sh_clients cl ON ct.sageAC collate latin1_general_CI_AS = cl.sageCode collate latin1_general_CI_AS
inner join #Temp t ON cl.clientID = t.clientID
GROUP BY ct.coName,
ct.postcode,
ct.sageAC,
ct.contactName,
ct.contactEmail,
ct.contactPhone,
t.cost,
t.renewDate,
t.dealLength

DROP TABLE #Temp
