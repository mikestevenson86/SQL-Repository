SELECT 
a.Id, 
a.Name Client, 
c.Name Contact, 
c.Email, 
ISNULL(c.Helpline_H_S__c,'No') HelplineHS,
ISNULL(c.Helpline_PEL__c,'No') HelplineHR,
ISNULL(c.Online_Super_User__c,'No') SuperUser, 
ISNULL(c.Main_User__c,'No') MainUser, 
c.AdviceCard__c AdviceCard
FROM
Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
WHERE AccountID in
(
	SELECT Id
	FROM
	(
		SELECT a.Id, c.Email, ROW_NUMBER () OVER (PARTITION BY a.Id, c.Email ORDER BY (SELECT NULL)) rn
		FROM Salesforce..Contact c
		inner join Salesforce..Account a ON c.AccountId = a.Id
		WHERE Email like '%@%' and Citation_Client__c = 'true'
	) detail
	WHERE rn > 1
)
ORDER BY a.Name, c.Name