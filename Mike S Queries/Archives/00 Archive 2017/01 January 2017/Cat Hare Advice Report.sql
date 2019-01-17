SELECT u.FullName, cl.clientId, companyName, bs.title, COUNT(ad.adviceId) AdviceNo
FROM Shorthorn..cit_sh_advice ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID
inner join Shorthorn..cit_sh_sites s ON ad.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
WHERE u.FullName in ('Carrie Murphy','Isobel  Washington') and dateOfCall between '2016-11-01' and '2017-01-31'
GROUP BY u.FullName, cl.clientID, companyName, bs.title
ORDER BY u.FullName, companyName