SELECT cl.SFDC_AccountId, u.FullName, sfu.Name, case when s.HeadOffice = 1 then 'Primary' else 'Site' end ConsultantType
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
inner join Shorthorn..cit_sh_dealsHS dhs ON ds.dealID = dhs.dealID
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteId
inner join Shorthorn..cit_sh_users u ON dhs.mainConsul = u.userID
left outer join [db01].Salesforce.dbo.[User] sfu ON u.FullName = sfu.Name
WHERE cl.SFDC_AccountId is not null and cl.SFDC_AccountId <> ''
UNION
SELECT cl.SFDC_AccountId, u.FullName, sfu.Name, case when s.HeadOffice = 1 then 'Primary' else 'Site' end ConsultantType
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
inner join Shorthorn..cit_sh_dealsPEL dhr ON ds.dealID = dhr.dealID
inner join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteId
inner join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userID
left outer join [db01].Salesforce.dbo.[User] sfu ON u.FullName = sfu.Name
WHERE cl.SFDC_AccountId is not null and cl.SFDC_AccountId <> ''