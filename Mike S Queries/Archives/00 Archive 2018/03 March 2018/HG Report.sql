IF OBJECT_ID('tempdb..#Accs') IS NOT NULL
	BEGIN
		DROP TABLE #Accs
	END

IF OBJECT_ID('tempdb..#HGLeads') IS NOT NULL
	BEGIN
		DROP TABLE #HGLeads
	END

	SELECT l.Id, AccountId
	INTO #Accs
	FROM Salesforce..Task t
	inner join Salesforce..Account a ON t.AccountId = a.Id
	inner join Salesforce..Lead l ON a.Id = l.ConvertedAccountId
	WHERE NVMConnect__DialList__c = 'a35D00000004dfBIAQ' and a.Id is not null
	GROUP BY l.Id, AccountId

	SELECT WhoId, a.AccountId
	INTO #HGLeads
	FROM Salesforce..Task t
	left outer join #Accs a ON t.WhoId = a.Id
	WHERE NVMConnect__DialList__c = 'a35D00000004dfBIAQ' and WhoId like '00QD%'
	GROUP BY WhoId, a.AccountId
	UNION
	SELECT Id WhoId, AccountId FROM #Accs WHERE Id not in 
	(
		SELECT WhoId 
		FROM Salesforce..Task 
		WHERE NVMConnect__DialList__c = 'a35D00000004dfBIAQ' and WhoId like '00QD%'
	)

	SELECT 
	'Outbound' Direction
	,BDCGroup
	,BDC
	,CallType
	,BDM
	,CitationSector__c 
	
	,COUNT(Calls) Calls, 
	COUNT(distinct UniqueProspects) UniqueProspectsCalledByBDC,
	SUM(case when Connects <> '' then 1 else 0 end) Connects,
	COUNT(distinct CallbacksFromDialler) CallbacksFromDialler,
	COUNT(distinct CurrentCallbacks)  CurrentCallbacks,
	COUNT(distinct Apps) Apps,
	COUNT(distinct Diallable) Diallable,
	COUNT(distinct Diallable_OnList) Diallable_OnList
	FROM
	(
		SELECT 
		case when bdc.Name in ('Adam Magee','Andy Burgess','Billy Spence','Keith Morrow','Michael Burnett') then 'Trial' else 'Non-Trial' end BDCGroup,
		bdc.Name BDC,
		case when t.NVMConnect__DialList__c = 'a35D00000004dfBIAQ' then 'HG Calls'
		when t.NVMConnect__DialList__c is null and hg.WhoId is not null/* hg.FirstCall < t.ActivityDate*/ then 'Callbacks HG'
		when ISNULL(t.NVMConnect__DialList__c, '') not in ('','a35D00000004dfBIAQ') then 'Dialler Calls'
		else 'Other Calls' end CallType,
		bdm.Name BDM,
		l.CitationSector__c,
		t.Id Calls,
		l.Id UniqueProspects,
		case when t.CallDurationInSeconds > 0 then t.Id else NULL end Connects,
		case when NVMConnect__DialList__c is not null and t.Status__c = 'Callback Requested' then t.Id else NULL end CallbacksFromDialler,
		case when NVMConnect__DialList__c is not null and t.Status__c = 'Callback Requested'
		and l.Status = 'Callback Requested' and l.BDC__c = t.OwnerId then l.Id else NULL end CurrentCallbacks,
		case when l.Date_Made__c is not null or o.DateMade__c is not null then l.Id else NULL end Apps,
		hgd.Lead_Id Diallable,
		hgl.Lead_Id Diallable_OnList

		FROM 
		Salesforce..Task t
		left outer join Salesforce..[User] bdc ON t.OwnerId = bdc.Id
		left outer join Salesforce..Lead l ON t.WhoId = l.Id
		left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
		left outer join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
		left outer join #HGLeads hg ON t.WhoId = hg.WhoId
		left outer join SalesforceReporting..HGDiallable hgd ON CONVERT(date, t.ActivityDate) = CONVERT(date, hgd.DialDate)
																and l.Id = hgd.Lead_Id
		left outer join SalesforceReporting..HGDiallable hgl ON CONVERT(date, t.ActivityDate) = CONVERT(date, hgl.DialDate)
																and l.Id = hgl.Lead_Id
																and ISNULL(t.NVMConnect__DialList__c, '') = ''

		WHERE 
		bdc.Name in 
		(
			'Adam Magee',
			'Andy Burgess',
			'Billy Spence',
			'Keith Morrow',
			'Michael Burnett',
			'Annabelle Matheson',
			'Conor Chambers',
			'Geraldine McManus',
			'Glen Schlechte-Bond',
			'Julian Hinchcliffe'
		)
		and
		t.ActivityDate >= '2018-03-19'
		and
		t.CallObject is not null
		and 
		t.CallType = 'Outbound'
		--and
		--l.Id is not null
	) detail
	
	GROUP BY 
	BDCGroup
	,BDC
	,CallType
	,BDM
	,CitationSector__c
	
	UNION ALL
	
	SELECT 
	'Inbound'
	,BDCGroup
	,BDC
	,CallType
	,BDM
	,CitationSector__c 
	
	,COUNT(Calls) Calls, 
	COUNT(distinct UniqueProspects) UniqueProspects,
	SUM(case when Connects <> '' then 1 else 0 end) Connects,
	COUNT(distinct CallbacksFromDialler) CallbacksFromDialler,
	COUNT(distinct CurrentCallbacks)  CurrentCallbacks,
	COUNT(distinct Apps) Apps,
	COUNT(distinct Diallable) Diallable,
	COUNT(distinct Diallable_OnList) Diallable_OnList
	FROM
	(
		SELECT 
		case when bdc.Name in ('Adam Magee','Andy Burgess','Billy Spence','Keith Morrow','Michael Burnett') then 'Trial' else 'Non-Trial' end BDCGroup,
		bdc.Name BDC,
		case when t.NVMConnect__DialList__c = 'a35D00000004dfBIAQ' then 'HG Calls'
		when t.NVMConnect__DialList__c is null and hg.WhoId is not null/* hg.FirstCall < t.ActivityDate*/ then 'Callbacks HG'
		when ISNULL(t.NVMConnect__DialList__c, '') not in ('','a35D00000004dfBIAQ') then 'Dialler Calls'
		else 'Other Calls' end CallType,
		bdm.Name BDM,
		l.CitationSector__c,
		t.Id Calls,
		l.Id UniqueProspects,
		case when t.CallDurationInSeconds > 0 then t.Id else NULL end Connects,
		case when NVMConnect__DialList__c is not null and t.Status__c = 'Callback Requested' then t.Id else NULL end CallbacksFromDialler,
		case when NVMConnect__DialList__c is not null and t.Status__c = 'Callback Requested'
		and l.Status = 'Callback Requested' and l.BDC__c = t.OwnerId then t.Id else NULL end CurrentCallbacks,
		case when l.Date_Made__c is not null or o.DateMade__c is not null then l.Id else NULL end Apps,
		hgd.Lead_Id Diallable,
		hgl.Lead_Id Diallable_OnList

		FROM 
		Salesforce..Task t
		left outer join Salesforce..[User] bdc ON t.OwnerId = bdc.Id
		left outer join Salesforce..Lead l ON t.WhoId = l.Id
		left outer join Salesforce..Opportunity o ON l.ConvertedOpportunityId = o.Id
		left outer join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
		left outer join #HGLeads hg ON t.WhoId = hg.WhoId
		left outer join SalesforceReporting..HGDiallable hgd ON CONVERT(date, t.ActivityDate) = CONVERT(date, hgd.DialDate)
																and l.Id = hgd.Lead_Id
		left outer join SalesforceReporting..HGDiallable hgl ON CONVERT(date, t.ActivityDate) = CONVERT(date, hgl.DialDate)
																and l.Id = hgl.Lead_Id
																and ISNULL(t.NVMConnect__DialList__c, '') = ''

		WHERE 
		bdc.Name in 
		(
			'Adam Magee',
			'Andy Burgess',
			'Billy Spence',
			'Keith Morrow',
			'Michael Burnett',
			'Annabelle Matheson',
			'Conor Chambers',
			'Geraldine McManus',
			'Glen Schlechte-Bond',
			'Julian Hinchcliffe'
		)
		and
		t.ActivityDate >= '2018-03-19'
		and
		t.CallObject is not null
		and 
		t.CallType = 'Inbound'
		and
		(
			(bdc.Name in ('Adam Magee','Andy Burgess','Billy Spence','Keith Morrow','Michael Burnett') and hg.WhoId is not null)
			or
			(bdc.Name not in ('Adam Magee','Andy Burgess','Billy Spence','Keith Morrow','Michael Burnett') and 1 = 1)
		)
		--and
		--l.Id is not null
	) detail
	
	GROUP BY 
	BDCGroup
	,BDC
	,CallType
	,BDM
	,CitationSector__c
		
	ORDER BY 
	Direction
	,BDCGroup
	,BDC
	,CallType
	,BDM
	,CitationSector__c