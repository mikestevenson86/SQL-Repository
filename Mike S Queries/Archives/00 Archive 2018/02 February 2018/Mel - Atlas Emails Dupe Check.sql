IF OBJECT_ID('tempdb..#AdminUsers') IS NOT NULL
	BEGIN
		DROP TABLE #AdminUsers
	END

SELECT c.Id, c.AccountId
INTO #AdminUsers
FROM Salesforce..Contact c
left outer join Salesforce..[User] u ON c.CreatedById = u.Id
WHERE u.Name in ('Salesforce Admin','Mike Stevenson')

SELECT c.Id, c.AccountId, Name, Email, CreatedDate, case when au.Id is not null then 'Yes' else 'No' end CreatedByAdmin
FROM Salesforce..Contact c
left outer join #AdminUsers au ON c.Id = au.Id
WHERE Email in
(
	SELECT Email
	FROM 
	(
		SELECT Email, ROW_NUMBER () OVER (PARTITION BY AccountId, Email ORDER BY AccountId, Email) MailCount
		FROM Salesforce..Contact
		WHERE 
		ISNULL(CONVERT(Varchar, Email), '') in
			(
				SELECT CONVERT(VarChar, Email__c)
				FROM Salesforce..Atlas_User__c
				WHERE ISNULL(CONVERT(VarChar, Email__c), '') <> ''
			)
	) detail
	WHERE MailCount > 1
)
and
c.AccountId is not null

ORDER BY 
AccountId, Email