SELECT FullName Consultant, COUNT(clientId) LiveClients
FROM
(
	SELECT u.FullName, dhr.clientId
	FROM Shorthorn..cit_sh_deals ds
	inner join Shorthorn..cit_sh_dealsPEL dhr ON ds.dealID = dhr.dealID
	inner join Shorthorn..cit_sh_users u ON dhr.mainConsul = u.userID
	WHERE ds.dealType in (2,3,12) and ds.dealStatus not in (2,5,10,18) and ds.renewDate > GETDATE()
	GROUP BY u.FullName, dhr.clientID
) detail
GROUP BY FullName
ORDER BY FullName