INSERT INTO
SalesforceReporting..Batch
(
[BatchID],[Run],[Source],[CreatedDate],[InitialCount],[Updates],[Inserts],[Deletes],[ActualUpdates],[ActualInserts],[ActualDeletes],[Dupe_Lead]
,[Dupe_Toxic],[Dupe_Account],[Dupe_Site],[ToxicSIC],[ToxicSIC_Events],[BadCompany_Exact],[BadCompany_Near],[BadCompany_Events],[BadDomain]
,[BadDomain_NHS],[BadPosition_Events],[BadSector_Events],[Status]
)

SELECT
SUM(BatchID) BatchID,
1 Run,
'ML_' + CONVERT(VarChar, DATEPART(Year, GETDATE())) + CONVERT(VarChar, DATEPART(Month, GETDATE())) + CONVERT(VarChar, DATEPART(day, GETDATE())) [Source],
GETDATE() CreatedDate,
SUM(InitialCount) InitialCount,
SUM(Updates) Updates,
SUM(Inserts) Inserts,
SUM(Deletes) Deletes,
0 ActualUpdates,
0 ActualInserts,
0 ActualDeletes,
SUM([Dupe_Lead]) [Dupe_Lead], 
SUM([Dupe_Toxic]) [Dupe_Toxic], 
SUM([Dupe_Account]) [Dupe_Account],
SUM([Dupe_Site]) [Dupe_Site], 
SUM([ToxicSIC]) [ToxicSIC], 
SUM([ToxicSIC_Events]) [ToxicSIC_Events], 
SUM([BadCompany_Exact]) [BadCompany_Exact], 
SUM([BadCompany_Near]) [BadCompany_Near], 
SUM([BadCompany_Events]) [BadCompany_Events], 
SUM([BadDomain]) [BadDomain], 
SUM([BadDomain_NHS]) [BadDomain_NHS], 
SUM([BadPosition_Events]) [BadPosition_Events], 
SUM([BadSector_Events]) [BadSector_Events],
'In Progress' [Status]
FROM
(
SELECT '1' gb, MAX(BatchID)+1 BatchId, 0 InitialCount, 0 Updates, 0 Inserts, 0 Deletes, 0 [Dupe_Lead], 0 [Dupe_Toxic], 0 [Dupe_Account]
, 0 [Dupe_Site], 0 [ToxicSIC], 0 [ToxicSIC_Events], 0 [BadCompany_Exact], 0 [BadCompany_Near], 0 [BadCompany_Events], 0 [BadDomain]
, 0 [BadDomain_NHS], 0 [BadPosition_Events], 0 [BadSector_Events]
FROM SalesforceReporting..Batch
UNION
SELECT '1' gb, 0 BatchId, COUNT(*) InitialCount, 0 Updates, 0 Inserts, 0 Deletes, 0 [Dupe_Lead], 0 [Dupe_Toxic], 0 [Dupe_Account]
, 0 [Dupe_Site], 0 [ToxicSIC], 0 [ToxicSIC_Events], 0 [BadCompany_Exact], 0 [BadCompany_Near], 0 [BadCompany_Events], 0 [BadDomain]
, 0 [BadDomain_NHS], 0 [BadPosition_Events], 0 [BadSector_Events]
FROM SalesforceReporting..ML_Daily
UNION
SELECT '1' gb, 0 BatchId, 0 InitialCount, COUNT(*) Updates, 0 Inserts, 0 Deletes, 0 [Dupe_Lead], 0 [Dupe_Toxic], 0 [Dupe_Account]
, 0 [Dupe_Site], 0 [ToxicSIC], 0 [ToxicSIC_Events], 0 [BadCompany_Exact], 0 [BadCompany_Near], 0 [BadCompany_Events], 0 [BadDomain]
, 0 [BadDomain_NHS], 0 [BadPosition_Events], 0 [BadSector_Events]
FROM MarketLocation..ML_Amends_Filtered
UNION
SELECT '1' gb, 0 BatchId, 0 InitialCount, 0 Updates, COUNT(*) Inserts, 0 Deletes, 0 [Dupe_Lead], 0 [Dupe_Toxic], 0 [Dupe_Account]
, 0 [Dupe_Site], 0 [ToxicSIC], 0 [ToxicSIC_Events], 0 [BadCompany_Exact], 0 [BadCompany_Near], 0 [BadCompany_Events], 0 [BadDomain]
, 0 [BadDomain_NHS], 0 [BadPosition_Events], 0 [BadSector_Events]
FROM MarketLocation..ML_News_Filtered
UNION
SELECT '1' gb, 0 BatchId, 0 InitialCount, 0 Updates, 0 Inserts, COUNT(*) Deletes, 0 [Dupe_Lead], 0 [Dupe_Toxic], 0 [Dupe_Account]
, 0 [Dupe_Site], 0 [ToxicSIC], 0 [ToxicSIC_Events], 0 [BadCompany_Exact], 0 [BadCompany_Near], 0 [BadCompany_Events], 0 [BadDomain]
, 0 [BadDomain_NHS], 0 [BadPosition_Events], 0 [BadSector_Events]
FROM MarketLocation..Citation_MLDB_Extract_Deletes
UNION
SELECT '1' gb, 0 BatchId, 0 InitialCount, 0 Updates, COUNT(*) Inserts, 0 Deletes, 0 [Dupe_Lead], 0 [Dupe_Toxic], 0 [Dupe_Account]
, 0 [Dupe_Site], 0 [ToxicSIC], 0 [ToxicSIC_Events], 0 [BadCompany_Exact], 0 [BadCompany_Near], 0 [BadCompany_Events], 0 [BadDomain]
, 0 [BadDomain_NHS], 0 [BadPosition_Events], 0 [BadSector_Events]
FROM MarketLocation..ML_News_Filtered
UNION
SELECT '1' gb, 0 BatchId, 0 InitialCount, 0 Updates, 0 Inserts, 0 Deletes, 
COUNT(CONVERT(int, Dupe_Lead)) Dupe_Lead,
COUNT(CONVERT(int, Dupe_Account)) Dupe_Account,
COUNT(CONVERT(int, Dupe_Site)) Dupe_Site,
COUNT(CONVERT(int, Dupe_Toxic)) Dupe_Toxic,
COUNT(CONVERT(int, BadCompany_Events)) BadCompany_Events,
COUNT(CONVERT(int, BadCompany_Exact)) BadCompany_Exact,
COUNT(CONVERT(int, BadCompany_Near)) BadCompany_Near,
COUNT(CONVERT(int, BadDomain)) BadDomain,
COUNT(CONVERT(int, BadDomain_NHS)) BadDomain_NHS,
COUNT(CONVERT(int, BadPosition_Events)) BadPosition_Events,
COUNT(CONVERT(int, BadSector_Events)) BadSector_Events,
COUNT(CONVERT(int, ToxicSIC)) ToxicSIC,
COUNT(CONVERT(int, ToxicSIC_Events)) ToxicSIC_Events
FROM SalesforceReporting..ML_Daily
) detail

GROUP BY gb