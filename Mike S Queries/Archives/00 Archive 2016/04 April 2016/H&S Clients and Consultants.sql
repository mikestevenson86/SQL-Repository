SELECT cl.clientId [Shorthorn ID], cl.companyname [Company Name], s.sitename [Site Name], s.postcode [Post Code], 
u1.FullName [Main Consultant], u2.FullName [Subsidiary Consultant]
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_deals dl ON dhs.dealID = dl.dealID
inner join Shorthorn..cit_sh_dealTypes dt ON dl.dealType = dt.dealTypeID
inner join Shorthorn..cit_sh_sites s ON dhs.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u1 ON dhs.mainConsul = u1.userID
left outer join Shorthorn..cit_sh_users u2 ON dhs.subConsul = u2.userID
WHERE dl.signDate <= GETDATE() and dl.renewDate >= GETDATE() and dl.dealStatus not in (2,5,10,18) and dt.dealType in ('Health & Safety','Combined')