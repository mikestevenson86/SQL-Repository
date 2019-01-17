SELECT
		'Appraisal'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		appraisal = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Capability/Suitability'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		capability = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Compromise Agreement'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		cit_sh_advice.compromiseAgreement = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'CYJ'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		cyj = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Disciplinary Procedure'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		disProc = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Disciplinary Appeal'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		disAppeal = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Discrimination'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		discrimination = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Flexible Working'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		flexWork = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Grievance Procedure'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		grievance = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Holiday Entitlement'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		holiday = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Lay Off/Short Time'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		layOff = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Letter of Concern'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		letterOfConcern = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Maternity/Adoption Leave'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		maternity = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Medical Reports/Records'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		medical = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'National Minimum Wage'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		minWage = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Notice Periods'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		noticePeriod = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Parental Leave'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		paternity = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Part Time Working'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		partTime = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Paternity Leave'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		paternity = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Performance'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		domestic = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Pregnancy'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		pregnancy = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
		
	UNION ALL
	SELECT
		'Probation'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		termination = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Recruitment'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		recruitment = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Redundancy'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		redundancy = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Resignation'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		resignation = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Retirement'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		retirement = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Pay/Wage'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		salary = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Sickness Absence'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id 
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		sickness = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'SMP/SAP/SPP'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		SMP = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'SOSR'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		SOSR = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'SSP'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		SSP = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Terms & Conditions'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		termsAndConditions = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'TUPE'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		TUPE = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'TU Recognition'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		TURec = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Unauthorised Absence'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		unauthAbsc = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Working Time Regs'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		workTimeRegs = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Whistle Blowing'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		whistleBlowing = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'
	UNION ALL
	SELECT
		'Other'
		, cit_sh_clients.clientID [Shorthorn ID]
		, cit_sh_clients.companyName [Company Name]
		, cit_sh_contacts.fName + ' ' + cit_sh_contacts.sName [Contact Name]
		, CASE WHEN cit_sh_clients.vip = 1 THEN 'Yes' ELSE 'No' END VIP
		, cit_sh_SectorType.title [Sector Type]
		, cit_sh_businessSectors.title [Business Sector]
		, cit_sh_busType.busType [Business Type]
		, cit_sh_affinity.Title [Affinity Type]
		, cit_sh_users.FullName [Advisor]
		, cit_sh_clients.clienttype [Client Type]
		, cit_sh_advice.dateOfCall [Call Start]
		, cit_sh_advice.endOfCall [Call End]
		, DATEDIFF(second,cit_sh_advice.dateOfCall,cit_sh_advice.endOfCall) [Call Length (secs)]
		, CASE WHEN cit_sh_advice.adviceTypeID = 1 THEN 'Incoming Call'
		WHEN cit_sh_advice.adviceTypeID = 2 THEN 'Outgoing Call'
		WHEN cit_sh_advice.adviceTypeID = 3 THEN 'Email'
		WHEN cit_sh_advice.adviceTypeID = 4 THEN 'CallBack Message'
		WHEN cit_sh_advice.adviceTypeID = 5 THEN 'Internal Note'
		WHEN cit_sh_advice.adviceTypeID IS NULL THEN 'Not Set' END [Advice Type]
		, a.s__c Segment
	FROM
		cit_sh_advice
		INNER JOIN cit_sh_users ON cit_sh_advice.consultant = cit_sh_users.userID
		INNER JOIN cit_sh_sites ON cit_sh_advice.siteID = cit_sh_sites.siteID
		INNER JOIN cit_sh_clients ON cit_sh_sites.clientID = cit_sh_clients.clientID 
		LEFT JOIN cit_sh_busType ON cit_sh_clients.busType = cit_sh_busType.busTypeID
		LEFT JOIN cit_sh_businessSectors ON cit_sh_busType.businessSectorID = cit_sh_businessSectors.id
		LEFT JOIN cit_sh_SectorType ON cit_sh_clients.SectorTypeID = cit_sh_SectorType.ID
		LEFT JOIN cit_sh_affinity ON cit_sh_clients.affinity = cit_sh_affinity.affinityID
		LEFT JOIN cit_sh_contacts ON cit_sh_advice.contactID = cit_sh_contacts.contactID
		LEFT JOIN [DB01].Salesforce.dbo.Account a ON cit_sh_clients.clientID = a.Shorthorn_Id__c
	WHERE
		other = 1
		AND
		cit_sh_advice.dateOfCall >= '2016-01-01'
		AND
		cit_sh_advice.dateOfCall < DATEADD(d , 1, '2016-12-31') -- Incremrement by a day
		AND
		cit_sh_advice.del <> 1 and cit_sh_busType.busType = 'Care'