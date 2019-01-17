SELECT dl.clientId, 
case when dhr.dealID is null and dhs.dealID is not null then 'Health & Safety'
when dhr.dealID is not null and dhs.dealID is null then 'EL & HR'
when dhr.dealID is not null and dhs.dealID is not null then 'Combined' end DealType
INTO #ClientTypes
FROM Shorthorn..cit_sh_deals dl
left outer join Shorthorn..cit_sh_dealsHS dhs ON dl.clientID = dhs.clientID
left outer join Shorthorn..cit_sh_dealsPEL dhr ON dl.clientID = dhr.clientID
WHERE dl.clientID in (SELECT clientID FROM Shorthorn..cit_sh_dealsPEL)
and dl.signDate <= GETDATE() and dl.renewDate >= GETDATE() and dl.dealStatus not in (2,5,10,18)
GROUP BY dl.clientId, 
case when dhr.dealID is null and dhs.dealID is not null then 'Health & Safety'
when dhr.dealID is not null and dhs.dealID is null then 'EL & HR'
when dhr.dealID is not null and dhs.dealID is not null then 'Combined' end

SELECT cl.clientID, companyName, s.postcode, clt.DealType
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_sites s ON dhr.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
inner join Shorthorn..cit_sh_deals dl ON dhr.dealID = dl.dealID
inner join #ClientTypes clt ON cl.clientID = clt.clientID
WHERE pelDealServiceType = 0 and s.HeadOffice = 1 and dl.signDate <= GETDATE() and dl.renewDate >= GETDATE() and dl.dealStatus not in (2,5,10,18)
ORDER BY companyName