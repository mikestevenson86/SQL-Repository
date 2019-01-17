SELECT cl.clientId, companyName, u.FullName [Main HR Consultant], u2.FullName [Install Consultant], dhr.pelID
FROM Shorthorn..cit_sh_clients cl
left outer join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
left outer join Shorthorn..cit_sh_dealsPEL dhr ON ds.dealID = dhr.dealID
left outer join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userID
left outer join Shorthorn..cit_sh_users u2 ON dhr.installConsul = u2.userID
left outer join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteID
WHERE 
dhr.installed is null 
and ds.signDate < GETDATE() 
and ds.renewDate > GETDATE() 
and ds.dealStatus not in (2,5,10,18) 
and dhr.dealID is not null
and dhr.enabled = 1
and dhr.sysRequired = 1
and s.active = 1
and ISNULL(ds.onHold, 0) = 0
and pelDealServiceType in (1,2)

ORDER BY companyName
/*
SELECT dhr.installed, ds.signDate, ds.renewDate, ds.dealStatus, dhr.dealID, dhr.enabled, dhr.sysRequired, s.active, pelDealServiceType, u.FullName,
dhr.docReview
FROM Shorthorn..cit_sh_clients cl
left outer join Shorthorn..cit_sh_deals ds ON cl.clientID = ds.clientID
left outer join Shorthorn..cit_sh_dealsPEL dhr ON ds.dealID = dhr.dealID
left outer join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userID
left outer join Shorthorn..cit_sh_users u2 ON dhr.installConsul = u2.userID
left outer join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteID
WHERE cl.companyName = 'C W Fletcher & Sons Ltd'*/