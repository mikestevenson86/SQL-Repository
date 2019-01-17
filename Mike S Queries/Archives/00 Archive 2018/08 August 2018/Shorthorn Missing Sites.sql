SELECT cl.clientID, cl.companyName
FROM Shorthorn..cit_sh_clients cl
inner join Shorthorn..cit_sh_deals dl ON cl.clientID = dl.clientID
inner join	(
				SELECT cl.clientId, ISNULL(SUM(s.HeadOffice), 0) HeadOffices
				FROM Shorthorn..cit_sh_clients cl
				left outer join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
				GROUP BY cl.clientID
			) s ON cl.clientID = s.clientID
			
WHERE dl.signDate < GETDATE() and dl.renewDate > GETDATE() and dl.dealStatus not in (2,5,10,18) and s.HeadOffices = 0