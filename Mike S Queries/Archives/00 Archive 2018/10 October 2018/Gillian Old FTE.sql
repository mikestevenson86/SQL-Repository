IF OBJECT_ID('tempdb..#FT17') IS NOT NULL DROP TABLE #FT17
IF OBJECT_ID('tempdb..#PT17') IS NOT NULL DROP TABLE #PT17
IF OBJECT_ID('tempdb..#FT18') IS NOT NULL DROP TABLE #FT18
IF OBJECT_ID('tempdb..#PT18') IS NOT NULL DROP TABLE #PT18

SELECT ah.AccountId, OldValue
INTO #FT17
FROM
Salesforce..AccountHistory ah
inner join	(
				SELECT AccountID, MIN(CreatedDate) Created
				FROM Salesforce..AccountHistory
				WHERE Field = 'FT_Employees__c' and CreatedDate > '2017-10-01'
				GROUP BY AccountId
			) fte ON ah.AccountId = fte.AccountId
						and ah.CreatedDate = fte.Created
WHERE Field = 'FT_Employees__c'

SELECT ah.AccountId, OldValue
INTO #PT17
FROM
Salesforce..AccountHistory ah
inner join	(
				SELECT AccountID, MIN(CreatedDate) Created
				FROM Salesforce..AccountHistory
				WHERE Field = 'PT_Employees__c' and CreatedDate > '2017-10-01'
				GROUP BY AccountId
			) fte ON ah.AccountId = fte.AccountId
						and ah.CreatedDate = fte.Created
WHERE Field = 'PT_Employees__c'

SELECT ah.AccountId, OldValue
INTO #FT18
FROM
Salesforce..AccountHistory ah
inner join	(
				SELECT AccountID, MIN(CreatedDate) Created
				FROM Salesforce..AccountHistory
				WHERE Field = 'FT_Employees__c' and CreatedDate > '2018-10-01'
				GROUP BY AccountId
			) fte ON ah.AccountId = fte.AccountId
						and ah.CreatedDate = fte.Created
WHERE Field = 'FT_Employees__c'

SELECT ah.AccountId, OldValue
INTO #PT18
FROM
Salesforce..AccountHistory ah
inner join	(
				SELECT AccountID, MIN(CreatedDate) Created
				FROM Salesforce..AccountHistory
				WHERE Field = 'PT_Employees__c' and CreatedDate >= '2018-10-01'
				GROUP BY AccountId
			) fte ON ah.AccountId = fte.AccountId
						and ah.CreatedDate = fte.Created
WHERE Field = 'PT_Employees__c'

SELECT 
a.Id, 
a.CreatedDate,
a.FT_Employees__c FT_Now,
a.PT_Employees__c PT_Now,
ROUND(ISNULL(case when ft.AccountId is not null then ft.OldValue else CONVERT(VarChar, FT_Employees__c) end, 0), 0) FTE_Oct2016,
ROUND(ISNULL(case when pt.AccountId is not null then pt.OldValue else CONVERT(VarChar, PT_Employees__c) end, 0), 0) PTE_Oct2016,
ROUND(ISNULL(case when ft2.AccountId is not null then ft2.OldValue else CONVERT(VarChar, FT_Employees__c) end, 0), 0) FTE_Oct2017,
ROUND(ISNULL(case when pt2.AccountId is not null then pt2.OldValue else CONVERT(VarChar, PT_Employees__c) end, 0), 0) PTE_Oct2017
FROM Salesforce..Account a
left outer join	(
					SELECT a.Id 
					FROM Salesforce..Account a 
					inner join Salesforce..Contract c ON a.Id = c.AccountId
					WHERE c.Services_Taken_EL__c = 'true'
					GROUP BY a.Id
				) hr ON a.Id = hr.Id
left outer join #FT17 ft ON a.Id = ft.AccountId
left outer join #PT17 pt ON a.Id = pt.AccountId
left outer join #FT18 ft2 ON a.Id = ft2.AccountId
left outer join #PT18 pt2 ON a.Id = pt2.AccountId
WHERE a.IsActive__c = 'true' and a.Citation_Client__c = 'true'