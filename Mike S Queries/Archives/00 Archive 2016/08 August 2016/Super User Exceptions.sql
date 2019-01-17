	SELECT AccountId, SUM(case when Online_Super_user__c = 'Yes' then 1 else 0 end) SuperUsers
	INTO #Supers
	FROM [db01].Salesforce.dbo.Contact
	GROUP BY AccountId

	SELECT clientId, SUM(case when c.contactID is not null then 1 else 0 end) SuperUsers
	INTO #SHSupers
	FROM Shorthorn..cit_sh_sites s
	left outer join Shorthorn..cit_sh_contacts c ON s.citManSuper = c.contactId
	GROUP BY clientID
	
	SELECT case when c.parentUID = 0 then c.uid else c.parentUID end CitwebCompanyId, u.email, u.name, 
	SUM(case when u.accesslevel = 1 then 1 else 0 end) SuperUsers
	INTO #CWSupers
	FROM CitationMain..citation_CompanyTable2 c
	inner join CitationMain..citation_UserNew u ON	u.uid = case when c.parentUID = 0 then c.uid else c.parentUID end
	GROUP BY case when c.parentUID = 0 then c.uid else c.parentUID end, u.email, u.name
	
	--Missing in Salesforce

		SELECT 
		ct.coName collate latin1_general_CI_AS [Company Name], 
		'CitWeb' [Has System], 
		CONVERT(VarChar, ct.uid) collate latin1_general_CI_AS [Has ID], 
		cws.Name collate latin1_general_CI_AS [Contact Name], 
		cws.Email collate latin1_general_CI_AS [Contact Email], 
		'Salesforce' [Missing System], 
		CONVERT(VarChar, a.Id) collate latin1_general_CI_AS [Missing ID]

		FROM 
		CitationMain..citation_CompanyTable2 ct
		inner join #CWSupers cws ON ct.uid = cws.CitwebCompanyId
		left outer join [db01].Salesforce.dbo.Account a ON ct.uid = a.CitWeb_Id__c
		left outer join [db01].salesforce.dbo.Contact c ON a.Id = c.AccountId and ct.contactEmail collate latin1_general_CI_AS = c.Email collate latin1_general_CI_AS
		left outer join #Supers s ON a.Id = s.AccountId

		WHERE 
		s.SuperUsers = 0

		GROUP BY 
		ct.coName, ct.uid, cws.name, cws.email, a.Id

	UNION

		SELECT 
		cl.companyName collate latin1_general_CI_AS [Company Name], 
		'Shorthorn' [Has System], 
		CONVERT(VarChar, cl.clientID) collate latin1_general_CI_AS [Has ID], 
		con.fName + ' ' + con.sName collate latin1_general_CI_AS [Contact Name], 
		con.email collate latin1_general_CI_AS [Contact Email], 
		'Salesforce' [Missing System], 
		CONVERT(VarChar, a.Id) collate latin1_general_CI_AS [Missing ID]

		FROM 
		Shorthorn..cit_sh_clients cl
		inner join Shorthorn..cit_sh_sites s ON cl.clientID = s.siteID
		inner join Shorthorn..cit_sh_contacts con ON s.citManSuper = con.contactID
		left outer join [db01].Salesforce.dbo.Account a ON cl.SFDC_AccountId = a.Id
		left outer join #Supers su ON a.Id = su.AccountId

		WHERE 
		su.SuperUsers = 0

		GROUP BY 
		cl.companyName, cl.clientID , con.fName + ' ' + con.sName, con.email , a.Id 

	UNION

		-- Missing in Shorthorn

		SELECT 
		ct.coName collate latin1_general_CI_AS [Company Name], 
		'CitWeb' [Has System], 
		CONVERT(VarChar, ct.uid) collate latin1_general_CI_AS [Has ID], 
		cws.name collate latin1_general_CI_AS [Contact Name], 
		cws.Email collate latin1_general_CI_AS [Contact Email], 
		'Shorthorn' [Missing System], 
		CONVERT(VarChar, cl.clientID) collate latin1_general_CI_AS [Missing ID]

		FROM 
		CitationMain..citation_CompanyTable2 ct
		inner join #CWSupers cws ON ct.uid = cws.CitwebCompanyId
		left outer join Shorthorn..cit_sh_clients cl ON ct.sageAC collate latin1_general_CI_AS = cl.sageCode collate latin1_general_CI_AS
		left outer join #SHSupers su ON cl.clientID = su.clientID

		WHERE 
		su.SuperUsers = 0 and ct.sageAC <> ''

		GROUP BY 
		ct.coName, ct.uid, cws.name, cws.email, cl.clientID

	UNION

		SELECT 
		a.Name  collate latin1_general_CI_AS, 
		'Salesforce' [Has System],
		CONVERT(VarChar, a.Id) collate latin1_general_CI_AS [Has ID], 
		c.Name collate latin1_general_CI_AS [Contact Name], 
		c.Email collate latin1_general_CI_AS [Contact Email],
		'Shorthorn' [Missing System], 
		CONVERT(VarChar, cl.clientId) collate latin1_general_CI_AS [Missing ID]

		FROM 
		[db01].Salesforce.dbo.Account a
		inner join [db01].Salesforce.dbo.Contact c ON a.Id = c.AccountId
		left outer join Shorthorn..cit_sh_clients cl ON a.Shorthorn_Id__c = cl.clientID
		left outer join #SHSupers su ON cl.clientID = su.clientID

		WHERE 
		c.Online_Super_user__c = 'Yes' and su.SuperUsers = 0

		GROUP BY
		a.Name, a.Id, c.Name, c.Email, cl.clientID

	UNION
	
		-- Missing in CitWeb
	
		SELECT 
		cl.companyName collate latin1_general_CI_AS [Company Name], 
		'Shorthorn' [Has System], 
		CONVERT(VarChar, cl.clientID) collate latin1_general_CI_AS [Has ID], 
		con.fName + ' ' + con.sName collate latin1_general_CI_AS [Contact Name], 
		con.email collate latin1_general_CI_AS [Contact Email], 
		'CitWeb' [Missing System], 
		CONVERT(VarChar, cws.CitwebCompanyId) collate latin1_general_CI_AS [Missing ID]

		FROM 
		Shorthorn..cit_sh_clients cl
		inner join Shorthorn..cit_sh_sites s ON cl.clientID = s.siteID
		inner join Shorthorn..cit_sh_contacts con ON s.citManSuper = con.contactID
		left outer join CitationMain..citation_CompanyTable2 ct ON cl.sageCode collate latin1_general_CI_AS = ct.sageAC collate latin1_general_CI_AS 
		left outer join #CWSupers cws ON ct.uid = cws.CitwebCompanyId

		WHERE 
		cws.SuperUsers = 0

		GROUP BY 
		cl.companyName, cl.clientID , con.fName + ' ' + con.sName, con.email , cws.CitwebCompanyId
		
	UNION

		SELECT 
		a.Name  collate latin1_general_CI_AS, 
		'Salesforce' [Has System],
		CONVERT(VarChar, a.Id) collate latin1_general_CI_AS [Has ID], 
		c.Name collate latin1_general_CI_AS [Contact Name], 
		c.Email collate latin1_general_CI_AS [Contact Email],
		'CitWeb' [Missing System], 
		CONVERT(VarChar, cws.CitwebCompanyId) collate latin1_general_CI_AS  [Missing ID]

		FROM 
		[db01].Salesforce.dbo.Account a
		inner join [db01].Salesforce.dbo.Contact c ON a.Id = c.AccountId
		left outer join CitationMain..citation_CompanyTable2 ct ON a.CitWeb_Id__c = ct.uid 
		left outer join #CWSupers cws ON ct.uid = cws.CitwebCompanyId

		WHERE 
		c.Online_Super_user__c = 'Yes' and cws.SuperUsers = 0

		GROUP BY
		a.Name, a.Id, c.Name, c.Email, cws.CitwebCompanyId
	
	ORDER BY
	[Has System], [Missing System]

	DROP TABLE #Supers
	DROP TABLE #SHSupers
	DROP TABLE #CWSupers