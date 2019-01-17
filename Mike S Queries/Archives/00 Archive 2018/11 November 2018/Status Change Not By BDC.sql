IF OBJECT_ID('tempdb..#BDCHistory') IS NOT NULL
	BEGIN
		DROP TABLE #BDCHistory
	END

SELECT lh.LeadId, lh.NewValue BDC__c, lh.CreatedDate StartDate, MIN(ISNULL(lh2.CreatedDate, GETDATE())) EndDate
INTO #BDCHistory
FROM Salesforce..LeadHistory lh
left outer join Salesforce..LeadHistory lh2 ON lh.LeadId = lh2.LeadId
											and lh.CreatedDate < lh2.CreatedDate
											and lh2.Field = 'BDC__c'
											and lh2.OldValue like '005D%' 
WHERE lh.Field = 'BDC__c' and lh.NewValue like '005D%'
GROUP BY lh.LeadId, lh.NewValue, lh.CreatedDate
ORDER BY LeadId, lh.CreatedDate

SELECT lh.LeadId, lh.CreatedDate, l.Status_Changed_Date__c, u.Name Changer, lh.OldValue, lh.NewValue, u2.Name BDC
FROM Salesforce..LeadHistory lh
inner join Salesforce..Lead l ON lh.LeadId = l.ID
inner join #BDCHistory bdc ON lh.LeadId = bdc.LeadId
								and lh.CreatedDate between bdc.StartDate and bdc.EndDate
								and lh.CreatedById <> bdc.BDC__c
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
inner join Salesforce..[User] u2 ON bdc.BDC__c = u2.Id
WHERE OldValue = 'Callback Requested' and NewValue <> OldValue and lh.Field = 'Status' and p.Name like '%BDC%'