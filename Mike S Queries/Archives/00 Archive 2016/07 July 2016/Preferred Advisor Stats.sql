SELECT clientId
INTO #MarksClients
FROM Shorthorn..cit_sh_advicePreferredAdvisors pa
inner join Shorthorn..cit_sh_users u ON pa.advisorID = u.userID
WHERE u.FullName = 'Mark Nolan'

SELECT s.clientID, ad.consultant, COUNT(ad.adviceId) Advice
INTO #Advice
FROM Shorthorn..cit_sh_advice ad
inner join Shorthorn..cit_sh_sites s ON ad.siteID = s.siteId
inner join #MarksClients mc ON s.clientID = mc.clientId
WHERE ad.dateOfCall >= '2015-07-01'
GROUP BY s.clientID, ad.consultant

SELECT cl.companyName, u.FullName, ISNULL(ad.Advice, 0) Advice
FROM Shorthorn..cit_sh_advicePreferredAdvisors pa
inner join #MarksClients mc ON pa.clientID = mc.clientID
inner join Shorthorn..cit_sh_clients cl ON pa.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON pa.advisorID = u.userID
left outer join #Advice ad ON cl.clientID = ad.clientID and u.userID = ad.consultant

ORDER BY cl.companyName, u.FullName

DROP TABLE #MarksClients
DROP TABLE #Advice