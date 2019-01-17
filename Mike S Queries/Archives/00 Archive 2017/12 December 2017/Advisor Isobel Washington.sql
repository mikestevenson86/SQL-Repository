IF OBJECT_ID('tempdb..#Advice') IS NOT NULL
	BEGIN
		DROP TABLE #Advice
	END

SELECT cl.clientId, COUNT(adviceId) Advice, MIN(dateOfCall) [First Call], MAX(dateOfCall) [Last Call]
INTO #Advice
FROM Shorthorn..cit_sh_advice a
left outer join Shorthorn..cit_sh_sites s ON a.siteID = s.siteId
left outer join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
left outer join Shorthorn..cit_sh_users u ON a.consultant = u.userID
WHERE u.fName = 'Isobel' and sName = 'Washington' and a.dateOfCall >= DATEADD(month,-6,GETDATE())
GROUP BY cl.clientID

SELECT cl.clientID, cl.companyName, ad.Advice, ad.[First Call], ad.[Last Call]
FROM Shorthorn..cit_sh_advicePreferredAdvisors pa
left outer join Shorthorn..cit_sh_users u ON pa.advisorID = u.userID and u.fName = 'Isobel' and u.sName = 'Washington'
left outer join Shorthorn..cit_sh_clients cl ON pa.clientID = cl.clientID
left outer join #Advice ad ON pa.clientID = ad.clientID
WHERE u.userID is not null

SELECT cl.clientID, cl.companyName, Advice, [First Call], [Last Call]
FROM Shorthorn..cit_sh_clients cl
left outer join #Advice ad ON cl.clientID = ad.clientID and ad.Advice > 5
WHERE ad.clientID is not null