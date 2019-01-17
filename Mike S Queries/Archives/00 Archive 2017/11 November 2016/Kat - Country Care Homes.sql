SELECT ta.Id, s.Name SiteName, sv.Contact, u.firstName + ' ' + u.secondName AssignedTo, sv.[Date]/*sv.InspectionDate*/, ta.DueDate, Priority, Status
FROM TaskActivities ta
INNER JOIN SiteVisits sv ON ta.RegardingObjectId = sv.ID
INNER JOIN Sites s ON sv.siteID = s.Id
INNER JOIN Citation.Companies c ON sv.CompanyId = c.Id
INNER JOIN Shared.Users u ON ta.AssignedTo = u.Id
WHERE c.Id = 'B86BBA19-F332-4AFC-9A65-CE5A02AF7301'

/*

All tasks generated from all site visits on the Country Court Care Homes Ltd account. I want to see the following columns:

Task ID
Site name
Contact person
Assigned to person
Finished date of the site visit
Deadline date of the task
Task priority
Task status

*/