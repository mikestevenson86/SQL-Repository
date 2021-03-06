SELECT sva.*
FROM [SynchHubReporting].[dbo].[SiteVisitAnswers] sva
left outer join [AtlasSiteVisitData]..[SiteVisitBlockQuestionAnswer] svb ON sva.Id = svb.Id
left outer join SynchHubReporting..SiteVisits sv ON svb.SiteVisitId = sv.Id
left outer join SynchHubReporting.Citation.Companies c ON sv.CompanyId = c.Id
WHERE c.ParentCompanyId = '512FE40C-77ED-4A2A-ADF2-B3A778F0FDF6' or c.Id = '512FE40C-77ED-4A2A-ADF2-B3A778F0FDF6'