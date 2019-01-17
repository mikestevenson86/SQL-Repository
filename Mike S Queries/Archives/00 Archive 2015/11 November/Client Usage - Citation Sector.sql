DECLARE @DateStart Date = '2014-11-05'
DECLARE @DateEnd Date = '2015-11-05'

SELECT
a.Id,

(Shorthorn.dbo.GetHelplinePELCallCount(cl.sagecode, @DateStart, @DateEnd)) [PEL Helpline],
(Shorthorn.dbo.GetHelplineHSCallCount(cl.sagecode, @DateStart, @DateEnd)) [H&S Helpline],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 1, cl.sagecode)) [Citassess],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 2, cl.sagecode)) [Citmananger],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 3, cl.sagecode)) [Citnet],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 10, cl.sagecode)) [Cittrainer],
(SELECT AppUsageCount FROM Shorthorn.dbo.GetAppUsageStat(@DateStart, @DateEnd, 8, cl.sagecode)) [CitDocs]

INTO #Temp

FROM 
Shorthorn..cit_sh_clients cl
inner join [DB01].Salesforce.dbo.Account a ON LEFT(cl.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS

SELECT sc.CitationSector,
SUM(t.[H&S Helpline]) [H&S Helpline],
SUM(t.[PEL Helpline]) [PEL Helpline],
SUM(t.Citassess) Citassess,
SUM(t.Citmananger) Citmananger,
SUM(t.Citnet) Citnet,
SUM(t.Cittrainer) Cittrainer,
SUM(t.CitDocs) CitDocs
FROM #Temp t
inner join [DB01].Salesforce.dbo.Account a ON t.Id = a.Id
inner join [DB01].SalesforceReporting.dbo.SIC2007Codes sc ON a.SIC2007_Code3__c = sc.SIC3_Code
GROUP BY sc.CitationSector

DROP TABLE #Temp