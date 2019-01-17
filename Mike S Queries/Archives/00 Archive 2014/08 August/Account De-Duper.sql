SELECT Id, Company
FROM Salesforce..Lead
WHERE 
Status = 'open' 
and 
(
	REPLACE(company,'Ltd','Limited') in
	(
	SELECT Name
	FROM Salesforce..Account
	)
	or 
	REPLACE(phone,' ','') in
	(
	SELECT REPLACE(phone,' ','')
	FROM Salesforce..Account
	)
	or
	REPLACE(Company,'Limited','Ltd') in
	(
	SELECT Name
	FROM Salesforce..Account
	)
)