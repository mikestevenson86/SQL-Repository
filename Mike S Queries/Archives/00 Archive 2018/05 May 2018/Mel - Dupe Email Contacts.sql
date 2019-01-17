SELECT c.Id, c.Email, LastDate
FROM
Salesforce..Contact c
inner join (
				SELECT c.Email, MAX(c.CreatedDate) LastDate
				FROM Salesforce..Contact c
				inner join Salesforce..Account a ON c.AccountId = a.Id
				WHERE c.Active__c = 'true' and a.IsActive__c = 'true' and ISNULL(c.Email, '') in
				(
					SELECT Email
					FROM
					(
						SELECT c.Id, c.Email, ROW_NUMBER () OVER (PARTITION BY Email ORDER BY c.CreatedDate) rn
						FROM Salesforce..Contact c
						inner join Salesforce..Account a ON c.AccountId = a.Id
						WHERE c.Active__c = 'true' and a.IsActive__c = 'true' and ISNULL(c.Email, '') <> ''
					) detail
					WHERE detail.rn > 1
					GROUP BY Email
				)
				GROUP BY c.Email
			) LastEmails ON c.Email = LastEmails.Email and c.CreatedDate = LastEmails.LastDate
ORDER BY LastDate desc