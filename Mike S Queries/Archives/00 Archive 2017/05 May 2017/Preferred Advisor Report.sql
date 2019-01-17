SELECT cl.clientID, cl.companyName,
SUM(cost) Total,
SUM(case when dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18) then cost else 0 end) TotalActive
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_advicePreferredAdvisors pa ON cl.clientID = pa.clientID
inner join Shorthorn..cit_sh_users u ON pa.advisorID = u.userID
inner join Shorthorn..cit_sh_deals dl ON cl.clientID = dl.clientID
WHERE u.FullName = 'Carrie Murphy' and dl.dealType in (2,3,7,12,14,15)
GROUP BY cl.clientID, cl.companyName