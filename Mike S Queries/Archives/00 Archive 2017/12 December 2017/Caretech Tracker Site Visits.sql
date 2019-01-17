IF OBJECT_ID ('tempdb..#SiteVisitsClosed') IS NOT NULL
	BEGIN
		DROP TABLE #SiteVisitsClosed
	END
		
	CREATE TABLE #SiteVisitsClosed
	(
	ClientId VarChar(10),
	DealId VarChar(10),
	AccountSite__c VarChar(20),  
	VisitNumber__c VarChar(50), 
	VisitDate__c Datetime,
	Postcode VarChar(20)
	)


	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,  
	'Install' VisitNumber__c, 
	dateInstalled VisitDate__c,
	s.postcode Postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.instConsul = u.userID

	WHERE 
	dateInstalled is not null and cl.clientID = 90959
	
	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,
	'1st Visit' VisitNumber__c, 
	firstVisit VisitDate__c,
	s.postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.firstConsul = u.userID

	WHERE 
	firstvisit is not null and cl.clientID = 90959
	
	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,
	'2nd Visit' VisitNumber__c, 
	secVisit VisitDate__c,
	s.postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.secConsul = u.userID

	WHERE 
	secVisit is not null and cl.clientID = 90959

	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,
	'3rd Visit' VisitNumber__c, 
	thirVisit VisitDate__c,
	s.postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.thirConsul = u.userID
	
	WHERE 
	thirVisit is not null and cl.clientID = 90959

	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,
	'4th Visit' VisitNumber__c, 
	fourthVisit VisitDate__c,
	s.postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.fourthConsul = u.userID

	WHERE 
	fourthVisit is not null and cl.clientID = 90959

	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,
	'5th Visit' VisitNumber__c, 
	fifthVisit VisitDate__c,
	s.postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.fifthConsul = u.userID

	WHERE 
	fifthVisit is not null and cl.clientID = 90959

	INSERT INTO #SiteVisitsClosed
	(ClientId, DealId, AccountSite__c, VisitNumber__c, VisitDate__c, Postcode)
	
	SELECT 
	cl.clientId ClientId,
	dhs.dealId DealId, 
	s.siteId AccountSite__c,
	'6th Visit' VisitNumber__c, 
	SixthVisit VisitDate__c,
	s.postcode

	FROM 
	Shorthorn..cit_sh_dealsHS dhs
	inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
	inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
	inner join Shorthorn..cit_sh_users u ON dhs.sixthConsul = u.userID

	WHERE 
	sixthVisit is not null and cl.clientID = 90959
	
	SELECT * FROM #SiteVisitsClosed