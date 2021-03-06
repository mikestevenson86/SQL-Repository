DECLARE @DateStart Date = '2015-08-17'
DECLARE @DateEnd Date = '2015-11-17'


SELECT clientId, dealId, ROW_NUMBER () OVER (PARTITION BY clientId ORDER BY dealId) ContractNo
INTO #Temp
FROM Shorthorn..cit_sh_deals

SELECT
cl.clientID ShorthornID,
a.Id SFDC_ID,
d.dealLength,
cl.companyName,
cl.totEmployees,
cl.sageCode,
s.postcode,
dt.dealType,
d.cost,
d.renewDate,
c.Account_segmentation__c,
c.Notice_Served_Date__c,
cl.ClientType,
a.Renewal_Type__c,
t.ContractNo,
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 1, cl.sagecode)) [Citassess],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 2, cl.sagecode)) [Citmananger],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 3, cl.sagecode)) [Citnet],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 10, cl.sagecode)) [Cittrainer],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 8, cl.sagecode)) [CitDocs]

FROM 
Shorthorn..cit_sh_clients cl
left outer join [DB01].Salesforce.dbo.Account a ON LEFT(cl.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID and s.HeadOffice = 1
left outer join Shorthorn..cit_sh_deals d ON cl.clientID = d.clientID
left outer join Shorthorn..cit_sh_dealtypes dt ON d.dealtype = dt.dealtypeId
left outer join #Temp t ON d.dealID = t.dealID
left outer join [DB01].Salesforce.dbo.Contract c ON LEFT(d.SFDC_ContractId, 15) collate latin1_general_CS_AS = LEFT(c.Id, 15) collate latin1_general_CS_AS

WHERE 
d.signDate <= GETDATE() and d.renewDate > GETDATE() and d.dealStatus not in (2,5,10,18) and
(
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 1, cl.sagecode)) > 0 or
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 2, cl.sagecode)) > 0 or
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 3, cl.sagecode)) > 0 or
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 10, cl.sagecode)) > 0 or
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 8, cl.sagecode))> 0
)

DROP TABLE #Temp