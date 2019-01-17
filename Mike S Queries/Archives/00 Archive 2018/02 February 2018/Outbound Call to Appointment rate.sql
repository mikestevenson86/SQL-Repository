		SELECT 
		pca.Region, 
		u.Name BDM, 
		l.List_Type__c ListType, 
		l.CitationSector__c CitationSector, 
		COUNT(c.Id) OutboundCalls,
		SUM(case when l.MADE_Criteria__c like '%outbound%' then 1 else 0 end) OutboundApps,
		CONVERT(decimal(18,2), (CONVERT(decimal(18,2), SUM(case when l.MADE_Criteria__c like '%outbound%' then 1 else 0 end)) / CONVERT(decimal(18,2), COUNT(c.Id))) * 100) OutboundCallsToApps
		FROM Salesforce..Lead l
		left outer join Salesforce..NVMStatsSF__NVM_Call_Summary__c c ON l.Id = c.NVMStatsSF__Related_Lead__c
		left outer join Salesforce..Task t ON c.NVMStatsSF__TaskID__c = t.Id
		left outer join Salesforce..[User] u ON l.OwnerId = u.Id
		left outer join	(
							SELECT BDM, Region
							FROM PostCodeAssignments
							GROUP BY BDM, Region
						) pca ON u.Name = pca.BDM
		WHERE t.CallType = 'Outbound'
		GROUP BY pca.Region, u.Name, l.List_Type__c, l.CitationSector__c
		ORDER BY Region, BDM, ListType, CitationSector