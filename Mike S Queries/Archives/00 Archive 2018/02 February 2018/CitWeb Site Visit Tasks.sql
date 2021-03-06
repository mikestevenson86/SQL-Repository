SELECT 
visitdate InspectionDate,
case when cdo.percentcomp = 100 then 3 else 2 end [State],
cdo.sitename [Site Name],
cdo.priorityInt [Priority],
a.Cluster_Start_Date__c,
case when cdo.percentcomp = 100 then 2 when cdo.percentcomp = 0 then 0 else 1 end [Status],
cdo.Observation

FROM 
[CitationMain].[dbo].[citdocsobservations] cdo
left outer join CitationMain..citation_CompanyTable2 ct ON cdo.companyuid = ct.uid
left outer join [DB01].Salesforce.dbo.Account a ON ct.uid = a.[CitWeb_ID__c]

WHERE 
ct.[uid] = 21147 or ct.parentUID = 21147