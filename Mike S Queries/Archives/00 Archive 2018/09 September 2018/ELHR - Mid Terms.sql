SELECT cl.clientID, cl.companyName, midTermReview, midTermLength, u.FullName [Main Consultant], 
case when ds.signDate < GETDATE() and ds.renewDate > GETDATE() and ds.dealStatus not in (2,5,10,18) then 'Yes' else 'No' end ActiveClient
FROM Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_deals ds ON dhr.dealID = ds.dealID
inner join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
inner join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userID
WHERE midTermReview >= DATEADD(year,-1,GETDATE())
ORDER BY midTermReview