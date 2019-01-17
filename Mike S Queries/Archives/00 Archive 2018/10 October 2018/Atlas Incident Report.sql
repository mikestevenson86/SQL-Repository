SELECT ai.Id,
it.Name,
ai.SiteId,
ai.IncidentDetails,
SUBSTRING(ai.IncidentDetails,0,CHARINDEX('","InjuryTypes',ai.IncidentDetails)),
SUBSTRING(ai.IncidentDetails,0,CHARINDEX('","InjuredParts',ai.IncidentDetails,CHARINDEX('","',ai.IncidentDetails))),
ai.CreatedOn
FROM [AboutIncident] ai
inner join Shared.IncidentType it ON ai.IncidentTypeId = it.ID
WHERE CompanyID =  'A98D26ED-2845-4FAA-B442-7CBBDE44216D' 