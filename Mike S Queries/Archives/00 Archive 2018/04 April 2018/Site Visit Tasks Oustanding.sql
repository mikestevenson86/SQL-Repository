SELECT 
svt.SiteVisitId, 
svt.InspectionDate,
u.FirstName + ' ' + u.SecondName SiteConsultant, 
u.Email ConEmail,
ISNULL(sfu.MobilePhone, sfu.Phone) ConPhone,
u2.FirstName + ' ' + u2.SecondName TaskAssignedTo,
u2.Email AssigneeEmail,
svt.Name, 
svt.Title, 
svt.Affilication, 
svt.Cluster_Start_Date__c, 
svt.MigratedOnboarded, 
svt.Priority, 
svt.Status, 
ta.PercentageCompleted

FROM 
[SynchHubReporting].[dbo].[SiteVisitTasks] svt
left outer join SynchHubReporting..TaskActivities ta ON svt.TaskId = ta.Id
left outer join SynchHubReporting..SiteVisits sv ON svt.SiteVisitId = sv.Id
left outer join SynchHubReporting..Sites s ON sv.SiteId = s.Id
left outer join SynchHubReporting.Shared.SiteAssignments sa ON s.Id = sa.SiteId
left outer join SynchHubReporting.Shared.Users u ON sa.UserId = u.Id
left outer join SynchHubReporting.Shared.Users u2 ON ta.AssignedTo = u2.Id
left outer join [DB01].Salesforce.dbo.[User] sfu ON u.Email = sfu.Email and u.IsActive = 'true'

WHERE 
svt.InspectionDate <= DATEADD(month,-6,GETDATE()) 
and 
ta.PercentageCompleted <= 50