INSERT INTO SalesforceReporting..Backlog_PEL_Overdue
(
[DateStamp]
,[Company Name]
,[Sage Code]
,[SF Account Id]
,[Pel Deal Service Type]
,[Deal Length]
,[Full Name]
,[Title]
,[First Name]
,[Last Name]
,[PostCode]
,[Gen Tel]
,[Gen Email]
,[Sign Date]
,[Renew Date]
,[Agree To Consul]
,[Installed]
,[In Make Up]
,[First Draft To Client]
,[Sec Draft To Client]
,[Thir Draft To Client]
,[Call Type]
,[Deal Value]
,[Sector]
,[Segment]
)

SELECT CONVERT(date, GETDATE()) DateStamp, *
FROM
(
SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fName, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,d1.renewDate,
p1.agreeToConsul, p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, 'Initial Contact' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID and s1.HeadOffice = 1			
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 	
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
		LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1)
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND ((DATEADD(dd,10,d1.signDate) < GETDATE()) AND (p1.initialContact IS NULL)) 
	--order by companyName 

UNION ALL

SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength,  u.FullName, t.title, c.fName, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
d1.renewDate,p1.agreeToConsul, p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '1st Visit' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID and s1.HeadOffice = 1			
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1	
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
		LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1)
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND (p1.pelDealServiceType = 1) AND ((DATEADD(dd,28,d1.signDate) < GETDATE()) AND (p1.firstVisit IS NULL and (p1.firstVisitBooked is null OR firstVisitBooked < GETDATE()) )) 
--order by companyName 
		
UNION ALL

                                     
SELECT c1.companyName,c1.sageCode, a.Id, p1.pelDealServiceType, d1.dealLength, u.FullName,  t.title,c.fName, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
d1.renewDate,p1.agreeToConsul, p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient,'Draft with Client' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID and s1.HeadOffice = 1			
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1	
	LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
	LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul 
	LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	((p1.firstDraftToClient is not null AND p1.firstDraftReturned is null AND firstDraftToClient < = DATEADD(dd,-2,GETDATE()) and (p1.[firstDraftRetrievalBooked] < GETDATE() or [firstDraftRetrievalBooked] is null)) OR
	(p1.secDraftToClient is not null AND p1.secDraftReturned is null AND secDraftToClient < = DATEADD(dd,-2,GETDATE()) and (p1.[secondDraftRetrievalBooked] < GETDATE() or [secondDraftRetrievalBooked] is null)) OR
	(p1.thirDraftToClient is not null AND p1.thirDraftReturned is null AND thirDraftToClient < = DATEADD(dd,-2,GETDATE()) and ( p1.[thirdDraftRetrievalBooked] < GETDATE() or [thirdDraftRetrievalBooked] is null)))
	 --order by companyName 
	
UNION ALL

	
SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fName, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
d1.renewDate,p1.agreeToConsul, p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, 'Installation Required' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID and s1.HeadOffice = 1			
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul 
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 	
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1)
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND  ((DATEADD(dd,2,p1.inMakeUp) < GETDATE()) AND (p1.installed IS NULL and (p1.installBooked is null OR p1.installBooked < GETDATE()))) 
	--order by companyName 
	
UNION ALL

SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fName, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
d1.renewDate,p1.agreeToConsul, p1.installed, p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '3 Months' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID and s1.HeadOffice = 1			
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 	
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND (p1.pelDealServiceType = 1) 
	AND ((DATEADD(mm,3,p1.installed) < GETDATE()) AND (p1.followUp3 IS NULL)) 
	--order by companyName 
	
UNION ALL
	
	
SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName,t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '12 Months' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  --and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	(((((p1.pelDealServiceType = 1 AND d1.dealLength >=24)) OR (p1.pelDealServiceType = 2 AND d1.dealLength >=60)) AND (installed is not null AND (installBooked is null OR installBooked < GETDATE())))
	AND ((DATEADD(mm,12,p1.installed) < GETDATE()) AND (p1.followUp12 IS NULL))) 
	--order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '24 Months' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	(((((p1.pelDealServiceType = 1 AND d1.dealLength >=36)) OR (p1.pelDealServiceType = 2 AND d1.dealLength >=60)) AND (installed is not null AND (installBooked is null OR installBooked < GETDATE()))) 
	AND ((DATEADD(mm,24,p1.installed) < GETDATE()) AND (p1.followUp24 IS NULL))) 
	--order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName,t.title, c.fName, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '36 Months' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment	
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	((p1.pelDealServiceType = 1 AND d1.dealLength >=48 AND d1.dealLength < 60 AND (installed is not null) and (installBooked is null OR installBooked < GETDATE())) AND ((DATEADD(mm,36,p1.installed) < GETDATE()) AND (p1.followUp36 IS NULL)))
	--order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname , c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, 'Mid Term Review' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	((d1.dealLength >= 60 AND DATEADD(mm,36,d1.signDate) < GETDATE()) AND (p1.midTermReview IS NULL)) 
	--order by companyName
	
UNION ALL
	
		SELECT c1.companyName, c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName,t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
		d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, 'Renewal Review' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND (((p1.pelDealServiceType = 2) AND d1.signDate < GETDATE())  AND (p1.docReview IS NULL)) 
	--order by companyName
	
UNION ALL

	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName,t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '12 Month After Review' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	((((p1.pelDealServiceType = 1 AND d1.dealLength >= 60) AND DATEADD(mm,48,d1.signDate) < GETDATE())  AND (p1.docReviewplus12 IS NULL)) OR 
	(((p1.pelDealServiceType = 2 AND d1.dealLength >= 24 AND d1.dealLength < 51) AND DATEADD(DD,10, DATEADD(mm,12,d1.signDate)) < GETDATE())  AND (p1.docReviewplus12 IS NULL)))  
	 --order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul, p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '24 Month After Review' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1)
	AND (onHold = 0)  AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	((((p1.pelDealServiceType = 1 AND d1.dealLength >= 72) AND DATEADD(mm,60,d1.signDate) < GETDATE())  AND (p1.docReviewplus24 IS NULL)) OR 
	(((p1.pelDealServiceType = 2 AND d1.dealLength >= 36 AND d1.dealLength < 60) AND DATEADD(DD,10, DATEADD(mm,24,d1.signDate)) < GETDATE())  AND (p1.docReviewplus24 IS NULL)))   
	--order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed, p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient,'36 Month After Review' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	(((p1.pelDealServiceType = 2 AND d1.dealLength >= 48 AND d1.dealLength < 60) AND DATEADD(dd,10, DATEADD(mm,36,d1.signDate)) < GETDATE())  AND (p1.docReviewplus36 IS NULL))
	 --order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname, c.sName , s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '12 Months Not Insatlled' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	(((p1.pelDealServiceType = 1) AND ((installed is null and (installBooked is null or installBooked < GETDATE())) AND followUp12 is null) AND (DATEADD(mm,12,d1.signDate) <= GETDATE())) AND (p1.installed is null and (installBooked is null or installBooked< GETDATE()))) 
	--order by companyName
	
UNION ALL
	
	SELECT c1.companyName,c1.sageCode, a.Id, p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul,p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '24 Months Not Installed' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 	
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	(((p1.pelDealServiceType = 1) AND ((installed is null and (installBooked is null or installBooked < GETDATE())) AND followUp24 is null) AND (DATEADD(mm,24,d1.signDate) <= GETDATE())) AND (p1.installed is null and (installBooked is null or installBooked< GETDATE()))) 
	--order by companyName
	
	
union all
	
	SELECT c1.companyName,c1.sageCode, a.Id,p1.pelDealServiceType, d1.dealLength, u.FullName, t.title, c.fname, c.sName, s1.postcode, s1.genTel,s1.genEmail,d1.signDate,
	d1.renewDate,p1.agreeToConsul, p1.installed,p1.inMakeUp, p1.firstDraftToClient, secDraftToClient,thirDraftToClient, '36 Months Not Installed' as [Call Type], d1.cost as DealValue, bs.title as Sector 
,a.S__c Segment
FROM [database].shorthorn.dbo.cit_sh_dealsPEL AS p1 	
	INNER JOIN [database].shorthorn.dbo.cit_sh_deals AS d1 ON p1.dealID = d1.dealID 				
	INNER JOIN [database].shorthorn.dbo.cit_sh_sites AS s1 ON p1.siteID = s1.siteID 		
	INNER JOIN [database].shorthorn.dbo.cit_sh_clients AS c1 ON p1.clientID = c1.clientID 
	LEFT JOIN Salesforce..Account a ON c1.clientId = a.Shorthorn_Id__c
	LEFT JOIN [database].shorthorn.dbo.cit_sh_contacts as c on s1.mainContactPEL = c.contactID  and c.enabled = 1	
		LEFT JOIN [database].shorthorn.dbo.cit_sh_titles as t on t.titleID = c.title 
		LEFT JOIN [database].shorthorn.dbo.cit_sh_users as u on u.userID = p1.mainConsul
			LEFT JOIN [database].shorthorn.dbo.cit_sh_busType as b on b.busTypeID = c1.busType
		LEFT JOIN [database].shorthorn.dbo.cit_sh_businessSectors as bs on bs.id = b.businessSectorID 
	WHERE (d1.dealType IN (2, 3, 6, 12, 15)) AND (c1.active = 1) AND (s1.active = 1) AND (d1.dealStatus IN (1, 6, 9, 11, 12, 13, 14, 15, 16, 17)) 	AND (d1.enabled = 1) 
	AND (onHold = 0) AND (d1.aiOnly IS NULL OR d1.aiOnly <= GETDATE()) 	AND (d1.renewDate >= GETDATE()) AND (d1.signDate <= GETDATE()) 	
	AND (p1.sysRequired = 1) AND 
	(((p1.pelDealServiceType = 1) AND ((installed is null and (installBooked is null or installBooked < GETDATE())) AND followUp36 is null) AND (DATEADD(mm,36,d1.signDate) <= GETDATE())) AND (p1.installed is null and (installBooked is null or installBooked< GETDATE()))) 
	) detail
	order by companyName