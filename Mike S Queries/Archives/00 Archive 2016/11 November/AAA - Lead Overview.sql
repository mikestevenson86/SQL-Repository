SELECT lh.LeadId, MAX(lh.CreatedDate) LastDate
INTO #LastUpdate
FROM Salesforce..LeadHistory lh
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
inner join Salesforce..Lead l ON lh.LeadId = l.Id
WHERE u.Name = 'Salesforce Admin' and l.Source__c like 'ML_%'
GROUP BY lh.LeadId

SELECT 
l.Id, 
l.CreatedDate, 
lu.LastDate UpdatedDate, 
Data_Supplier__c OriginalSource,
Source__c LastUpdateSource,
l.[Status],
Suspended_Closed_Reason__c [Suspended/Closed Reason],
l.Market_Location_URN__c ML_URN, 
case when ws.Email is not null then 1 else 0 end WiredSup,
case when tps.Phone is not null then 1 else 0 end CTPS,
l.Sector__c Sector,
sc.CitationSector SICCitationSector,
sc.ToxicSIC

FROM 
Salesforce..Lead l
left outer join #LastUpdate lu ON l.Id = lu.LeadId
left outer join SalesforceReporting..WiredSuppressions ws ON l.Email = ws.Email
left outer join SalesforceReporting..ctps_ns tps ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
													= REPLACE(case when tps.Phone like '0%' then tps.Phone else '0'+tps.Phone end,' ','')
left outer join SalesforceReporting..SIC2007Codes sc ON l.SIC2007_Code3__c = sc.SIC3_Code
left outer join MarketLocation..MainDataSet ml ON l.Market_Location_URN__c = ml.URN

DROP TABLE #LastUpdate