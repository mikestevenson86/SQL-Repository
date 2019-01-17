SELECT 
c.ClientId, 
c.companyName, 
shr.PostCode,
shr.GenTel Telephone,
shr.GenEmail Email,
uhr.Fullname HSConsultant,
case when d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() then 'Active' else 'InActive' end Active

FROM SalesforceReporting..CareClientData cqc
left outer join [database].shorthorn.dbo.cit_sh_clients c ON cqc.company = c.companyName
left outer join [database].shorthorn.dbo.cit_sh_deals d ON c.clientID = d.clientID
inner join [database].shorthorn.dbo.cit_sh_dealsHS hr ON d.dealID = hr.dealID
left outer join [database].shorthorn.dbo.cit_sh_sites shr ON hr.siteID = shr.siteID
left outer join [database].shorthorn.dbo.cit_sh_users uhr ON hr.mainConsul = uhr.userID

WHERE shr.headoffice = 1
ORDER BY c.ClientID