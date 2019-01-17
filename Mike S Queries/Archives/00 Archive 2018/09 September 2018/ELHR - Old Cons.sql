SELECT cl.clientId, cl.companyName, u.FullName [Main Consultant]
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_deals dl ON dhr.dealID = dl.dealID
inner join Shorthorn..cit_sh_clients cl ON dl.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userID
WHERE dl.enabled = 1 and dl.signDate < GETDATE() and dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18) and mainConsul in
(
128238,
128739,
128888
)
GROUP BY cl.clientId, cl.companyName, u.FullName