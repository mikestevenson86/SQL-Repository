IF OBJECT_ID('tempdb..#Main') IS NOT NULL
	BEGIN
		DROP TABLE #Main
	END
	
IF OBJECT_ID('tempdb..#NotMain') IS NOT NULL
	BEGIN
		DROP TABLE #NotMain
	END

IF OBJECT_ID('tempdb..#LatestContract') IS NOT NULL
	BEGIN
		DROP TABLE #LatestContract
	END

SELECT AccountId
INTO #Main
FROM Salesforce..Contact c
--left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
WHERE c.Email not like '%citation%' and Main_User__c = 'Yes'-- or sj.Main_Site_Contact__c = 'true' or sj.Secondary_Site_Contact__c = 'true'
GROUP BY AccountId

SELECT AccountId
INTO #NotMain
FROM Salesforce..Contact c
--left outer join Salesforce..Site_Junction__c sj ON c.Id = sj.Contact_Junction__c
WHERE c.Email not like '%citation%' and ISNULL(c.Main_User__c, 'No') = 'No'-- and sj.Main_Site_Contact__c = 'false' and sj.Secondary_Site_Contact__c = 'false'
GROUP BY AccountId

SELECT c.Id, c.AccountId, c.CustomerSignedId, c.StartDate, c.EndDate
INTO #LatestContract
FROM Salesforce..Contract c
inner join	(
				SELECT AccountId, MAX(StartDate) Start
				FROM Salesforce..Contract
				WHERE CustomerSignedId is not null
				and
				StartDate < GETDATE() and EndDate > GETDATE() and Cancellation_Date__c is null
				GROUP BY AccountId
			) lc ON c.AccountId = lc.AccountId
					and c.StartDate = lc.Start
			
SELECT nm.AccountId, c.CustomerSignedId, c.StartDate, sj.Id, s.Site_Type__c, con.Main_User__c
FROM #NotMain nm
left outer join #Main m ON nm.AccountId = m.AccountId
left outer join Salesforce..Account a ON nm.AccountId = a.Id
left outer join #LatestContract c ON nm.AccountId = c.AccountId 
left outer join Salesforce..Site_Junction__c sj ON c.CustomerSignedID = sj.Contact_Junction__c
left outer join Salesforce..Site__c s ON sj.Site_Junction__c = s.Id
left outer join Salesforce..Contact con ON c.CustomerSignedId = con.Id
WHERE m.AccountId is null and Citation_Client__c = 'true' and Cluster_End_Date__c > '2018-02-02' 
and a.IsActive__c = 'true' and ISNULL(con.Main_User__c, 'No') = 'No'