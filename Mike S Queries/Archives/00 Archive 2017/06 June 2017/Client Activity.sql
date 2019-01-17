-- Clear temporary tables

IF OBJECT_ID ('tempdb..#ActiveDeals') IS NOT NULL
BEGIN
	DROP TABLE #ActiveDeals
END

IF OBJECT_ID ('tempdb..#Calls') IS NOT NULL
BEGIN
	DROP TABLE #Calls
END

IF OBJECT_ID ('tempdb..#Visits') IS NOT NULL
BEGIN
	DROP TABLE #Visits
END

-- Find Active Clients

	SELECT clientId, signDate
	INTO #ActiveDeals
	FROM Shorthorn..cit_sh_deals
	WHERE renewDate > GETDATE() and dealStatus not in (2,5,10,18)

-- Get Calls for Active Clients

	SELECT cl.clientId,
	 
	SUM(case when ad.dateOfCall >= acd.signDate then 1 else 0 end) Calls
	
	INTO #Calls
	FROM Shorthorn..cit_sh_clients cl
	left outer join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
	left outer join Shorthorn..cit_sh_advice ad ON s.siteId = ad.siteID
	left outer join #ActiveDeals acd ON cl.clientID = acd.clientID
	WHERE acd.clientID is not null
	GROUP BY cl.clientID, cl.SFDC_AccountId, acd.signDate

-- Get Visits for Active Clients

	SELECT cl.clientId,
	
	SUM(
	case when ISNULL(dhs.dateInstalled,'') <> '' then 1
	when ISNULL(dhs.firstVisit,'') <> '' then 1
	when ISNULL(dhs.secVisit,'') <> '' then 1
	when ISNULL(dhs.thirVisit,'') <> '' then 1
	when ISNULL(dhs.fourthVisit,'') <> '' then 1
	when ISNULL(dhs.fifthVisit,'') <> '' then 1
	when ISNULL(dhs.sixthVisit,'') <> '' then 1
	when ISNULL(dhr.installed,'') <> '' then 1
	when ISNULL(dhr.firstVisit,'') <> '' then 1 else 0 end) Visits
	
	INTO #Visits
	FROM Shorthorn..cit_sh_clients cl
	left outer join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
	left outer join Shorthorn..cit_sh_dealsHS dhs ON ds.dealId = dhs.dealId
	left outer join Shorthorn..cit_sh_dealsPEL dhr ON ds.dealId = dhr.dealId
	left outer join #ActiveDeals ad ON cl.clientID = ad.clientID
	WHERE ad.clientID is not null
	GROUP BY cl.clientID, cl.SFDC_AccountId, ad.signDate

-- Final resultset

	SELECT
	cl.clientID,
	cl.SFDC_AccountId,
	cls.Calls,
	vst.Visits,
	DATEDIFF(day,ad.signDate,GETDATE()) DaysActive

	FROM
	Shorthorn..cit_sh_clients cl
	left outer join #ActiveDeals ad ON cl.clientID = ad.clientID
	left outer join #Calls cls ON cl.clientID = cls.clientID
	left outer join #Visits vst ON cl.clientID = vst.clientID

	WHERE
	ISNULL(ad.clientID,'') <> ''

	ORDER BY 
	Calls, 
	Visits, 
	DaysActive desc