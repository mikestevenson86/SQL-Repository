SELECT svt.*
FROM [SynchHubReporting].[dbo].[SiteVisitTasks] svt
inner join SynchHubReporting..SiteVisits sv ON svt.SiteVisitId = sv.Id
inner join SynchHubReporting.Citation.Companies c ON sv.CompanyId = c.Id
WHERE c.ParentCompanyId = '512FE40C-77ED-4A2A-ADF2-B3A778F0FDF6' or c.Id = '512FE40C-77ED-4A2A-ADF2-B3A778F0FDF6'