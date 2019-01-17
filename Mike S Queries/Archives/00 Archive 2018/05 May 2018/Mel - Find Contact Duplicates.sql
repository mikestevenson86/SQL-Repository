SELECT c.Id, c.FirstName+c.LastName+c.AccountId ContactString, c.CreatedDate, u.Name,
ROW_NUMBER () OVER (PARTITION BY c.FirstName+c.LastName+c.AccountId ORDER BY c.CreatedDate) rn
FROM Salesforce..Contact c
left outer join Salesforce..[User] u ON c.CreatedById = u.Id
WHERE c.FirstName+c.LastName+c.AccountId in
(
	SELECT ContactString
	FROM
	(
		SELECT ID, FirstName+LastName+AccountId ContactString, CreatedDate, 
		ROW_NUMBER () OVER (PARTITION BY FirstName+LastName+AccountId ORDER BY CreatedDate) rn
		FROM Salesforce..Contact  
		WHERE FirstName+LastName+AccountId is not null --and CONVERT(date, CreatedDate) <> '2018-05-08'
	)detail
	WHERE rn > 1
)
and c.FirstName is not null and c.LastName is not null and c.AccountId is not null
ORDER BY ContactString, CreatedDate