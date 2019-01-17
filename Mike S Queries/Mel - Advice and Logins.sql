-- Atlas Logins

SELECT 
COUNT(t.SubjectId) Logins,
a.Id, 
a.Name

FROM 
Salesforce..Account a
left outer join Salesforce..ATLAS_User__c au ON LEFT(a.Id, 15) collate latin1_general_CS_AS = LEFT(au.Account__c, 15) collate latin1_general_CS_AS
left outer join [SYNCHUB].[SynchHubReporting].[identity].tokens t ON CONVERT(VarChar, au.Email__c) = CONVERT(VarChar, t.SubjectId)

WHERE
( 
	a.Cluster_Start_Date__c >= '2015-11-09'
	or
	MigrationStatus__c = 'Complete'
)
and
(
	Profile__c like '%Service Owner%'
	or
	Profile__c like '%HR Manager%'
	or
	Profile__c like '%HS Co-ordinator%'
)
and
Test_Account__c = 'false'
and
a.IsActive__c = 'true'
and
Citation_Client__c = 'true'
and 
a.Cluster_End_Date__c > CONVERT(date, GETDATE())
and
au.IsActive__c = 'true'
and
ISNULL(CONVERT(VarChar, Email__c), '') <> ''

GROUP BY
a.Id, a.Name

HAVING
COUNT(t.SubjectId) <= 6

ORDER BY
a.Name

-- HR Advice

SELECT 
MAX(CONVERT(date, dateOfCall)) CallDate, 
a.Id,
a.Name

FROM [database].Shorthorn.dbo.cit_sh_advice ad
left outer join [database].Shorthorn.dbo.cit_sh_contacts con ON ad.contactID = con.contactID
left outer join [database].Shorthorn.dbo.cit_sh_sites s ON con.siteID = s.siteID
left outer join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Salesforce..Account a ON cl.clientID = a.Shorthorn_Id__c

WHERE
a.IsActive__c = 'true'
and
a.Citation_Client__c = 'true'

GROUP BY
a.Id,
a.Name

HAVING
MAX(CONVERT(date, dateOfCall)) < CONVERT(date, DATEADD(dd, -90, GETDATE()))

ORDER BY
a.Name

-- H&S Advice

SELECT 
MAX(CONVERT(date, commentDate)) LastCallDate,
a.ID,
a.Name

FROM 
[database].[Shorthorn].[dbo].[cit_sh_HSCitassist] hsa
inner join [database].[Shorthorn].[dbo].cit_sh_HSDispositions hsd ON hsa.disposition = hsd.dispositionID
left outer join [database].[Shorthorn].[dbo].cit_sh_contacts con ON hsa.contactID = con.contactID
left outer join [database].[Shorthorn].[dbo].cit_sh_sites s ON con.siteID = s.siteID
left outer join [database].[Shorthorn].[dbo].cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Salesforce..Account a ON cl.clientID = a.Shorthorn_Id__c

WHERE
a.IsActive__c = 'true'
and
a.Citation_Client__c = 'true'

GROUP BY
a.Id, a.Name

HAVING
MAX(CONVERT(date, commentDate)) < CONVERT(date, DATEADD(dd, -180, GETDATE()))

ORDER BY a.Name

