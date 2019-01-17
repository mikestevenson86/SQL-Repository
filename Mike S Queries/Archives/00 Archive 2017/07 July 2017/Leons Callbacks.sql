SELECT LeadId
FROM Salesforce..LeadHistory lh
inner join Salesforce..Lead l ON lh.LeadId = l.Id
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
WHERE CONVERT(date,lh.CreatedDate) in ('2017-07-03','2017-07-04') and OldValue = 'leon Weate' and NewValue = 'Katie cullen' 
and u.Name = 'Salesforce Admin' and l.Status = 'Callback Requested' and BDC__c = '005D0000007W4W4IAK'
GROUP BY LeadId