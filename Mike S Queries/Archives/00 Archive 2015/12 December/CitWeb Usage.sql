SELECT 
ct.coName CompanyName,
us.name UserName,
appName [Application],
[whenUsed] DateAccessed

FROM 
[CitationMain].[dbo].[citation_appUsage] ap
inner join CitationMain..citation_CompanyTable2 ct ON ap.compID = ct.uid
inner join CitationMain..citation_appList al ON ap.appID = al.appID
inner join CitationMain..citation_UserNew us ON ap.usUID = us.usUID
inner join Shorthorn..cit_sh_clients cl ON ct.sageAC collate latin1_general_CI_AS = cl.sageCode collate latin1_general_CI_AS
left outer join [DB01].Salesforce.dbo.Account a ON LEFT(cl.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
left outer join [DB01].Salesforce.dbo.Contract c ON a.ID = c.AccountId

WHERE
CONVERT(date, whenUsed) between '2015-09-01' and '2015-09-30' 
and 
c.StartDate between '2015-09-01' and '2015-09-30' 
and 
c.Business_Type__c = 'New Business'
and 
ct.coName not like '%banana moon%'
and 
c.LatestContract__c = 'true'

ORDER BY
whenUsed