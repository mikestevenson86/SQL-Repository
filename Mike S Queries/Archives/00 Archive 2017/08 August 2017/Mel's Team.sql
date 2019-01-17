	exec Salesforce..SF_Refresh 'Salesforce','ContactHistory'

	SELECT 
	ch.CreatedDate, a.Name Client, c.Name Contact, u.Name, Field, OldValue, NewValue

	FROM 
	Salesforce..ContactHistory ch
	inner join Salesforce..Contact c ON ch.ContactId = c.Id
	inner join Salesforce..Account a ON c.AccountID = a.Id
	inner join Salesforce..[User] u ON ch.CreatedById = u.Id
	inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id

	WHERE 
	Field in 
	(
	'Shorthorn_Id__c',
	'FirstName',
	'LastName',
	'Email',
	'Phone',
	'MobilePhone',
	'Position',
	'Salutation',
	'Active__c'
	)
	and 
	DATEPART(week, ch.CreatedDate) = DATEPART(week, GETDATE()) and YEAR(ch.CreatedDate) = YEAR(GETDATE())
	and 
	uMan.Name = 'Melanie Johnston'

	ORDER BY ch.CreatedDate

	SELECT 
	u.Name, COUNT(distinct c.AccountId) Accounts, COUNT(distinct c.Id) Contacts, COUNT(ch.Id) Fields

	FROM 
	Salesforce..ContactHistory ch
	inner join Salesforce..Contact c ON ch.ContactId = c.Id
	inner join Salesforce..Account a ON c.AccountID = a.Id
	inner join Salesforce..[User] u ON ch.CreatedById = u.Id
	inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id

	WHERE 
	Field in 
	(
	'Shorthorn_Id__c',
	'FirstName',
	'LastName',
	'Email',
	'Phone',
	'MobilePhone',
	'Position',
	'Salutation',
	'Active__c'
	)
	and 
	DATEPART(week, ch.CreatedDate) = DATEPART(week, GETDATE()) and YEAR(ch.CreatedDate) = YEAR(GETDATE())
	and 
	uMan.Name = 'Melanie Johnston'

	GROUP BY 
	u.Name

	ORDER BY
	Accounts desc, Contacts desc, Fields desc