SELECT clientID, COUNT(siteId) sites
INTO #Sites
FROM Shorthorn..cit_sh_sites
GROUP BY clientID

SELECT 
cl.clientID, 
cl.companyName Company,
dhr.dealID, 
signDate, 
u.FullName Consultant,
case when dhr.pelDealServiceType = 1 then 'Phase 1 - Installation Deal' else 'Phase 2 - Review Deal' end Phase

FROM Shorthorn..cit_sh_dealsPEL dhr
left outer join Shorthorn..cit_sh_deals dl ON dhr.dealID = dl.dealID
left outer join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteID
left outer join #Sites st ON s.clientID = st.clientID
left outer join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userId

WHERE (st.sites = 1 or HeadOffice = 1) and dhr.sysRequired = 0 and dl.signDate < GETDATE() and dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18)

DROP TABLE #Sites