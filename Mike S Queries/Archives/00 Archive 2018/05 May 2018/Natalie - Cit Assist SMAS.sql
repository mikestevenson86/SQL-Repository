SELECT commentDate [Advice Date], cl.CompanyName [Company Name], u.FullName Advisor, Comments,
case when a.CitationSector__c like '%construction%' then 'Yes' else 'No' end ConstructionClient
FROM Shorthorn..cit_sh_HSCitassist hca
left outer join Shorthorn..cit_sh_dealsHS dhs ON hca.HSID = dhs.hsID
left outer join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON hca.citUser = u.userID
left outer join [DB01].Salesforce.dbo.Account a ON cl.clientID = a.Shorthorn_Id__c
WHERE hca.disposition = 70 and CONVERT(date, commentDate) >= '2017-01-01' and a.Shorthorn_Id__c is not null
ORDER BY commentDate