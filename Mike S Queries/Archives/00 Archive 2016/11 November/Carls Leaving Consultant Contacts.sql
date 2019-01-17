SELECT c.Id, a.Id, c.FirstName, c.LastName, c.Position__c, c.Phone, c.Email, c.MailingStreet, c.MailingCity, c.MailingState, c.MailingPostalCode
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
WHERE c.Helpline_H_S__c = 'yes' and a.Shorthorn_Id__c in
(
	SELECT clientId
	FROM
	(
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.mainConsul = u.userID
		WHERE u.FullName = 'Graeme Collard'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.firstConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and firstVisit > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.secConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and secVisit > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.thirConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and thirVisit > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.fourthConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and fourthVisit > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.fifthConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and fifthVisit > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.sixthConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and sixthVisit > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_users u ON dhs.instConsul = u.userID
		WHERE u.FullName = 'Graeme Collard' and dateInstalled > '2015-11-30'
		UNION
		SELECT clientId
		FROM [database].Shorthorn.dbo.cit_sh_dealsHS dhs
		inner join [database].Shorthorn.dbo.cit_sh_HSExtraVisits ev ON dhs.HSID = ev.hsID
		inner join [database].Shorthorn.dbo.cit_sh_users u ON ev.consultant = u.userID
		WHERE u.FullName = 'Graeme Collard' and ev.visitDate > '2015-11-30'
		) detail
	GROUP BY clientID
)
