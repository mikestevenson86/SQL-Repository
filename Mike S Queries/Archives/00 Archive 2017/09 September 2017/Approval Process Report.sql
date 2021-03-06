SELECT pri.CreatedDate
	  ,pri.CompletedDate
	  ,l.CitationSector__c
	  ,pri.Status
	  ,l.Id
	  --,lh.CreatedDate
	  --,lh.NewValue
      ,u.Name Submitter
      ,la.Name AdminAgent
      ,l.Status
FROM [Salesforce].[dbo].[ProcessInstance] pri
inner join Salesforce..[User] u ON pri.SubmittedById = u.Id
inner join Salesforce..[User] la ON pri.LastActorId = la.Id
inner join Salesforce..Lead l ON pri.TargetObjectId = l.Id
WHERE TargetObjectId like '00QD%'
ORDER BY pri.CreatedDate desc