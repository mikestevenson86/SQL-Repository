/*
SELECT distinct Field
FROM
(
SELECT ContactId, Field, ROW_NUMBER () OVER (PARTITION BY ContactId, Field, NewValue ORDER BY CreatedDate desc) SC
FROM Salesforce..ContactHistory
WHERE CreatedDate >= DATEADD(day,-3,GETDATE())
) detail
*/

SELECT *, 
case when ISNULL(SFDC,'') <> ISNULL(Shorthorn,'') and ISNULL(SFDC,'') <> ISNULL(AtlasUser,'') and ISNULL(Shorthorn,'') <> ISNULL(AtlasUser,'') then 'No Match'
when (ISNULL(SFDC,'') <> ISNULL(Shorthorn,'') and ISNULL(SFDC,'') = ISNULL(AtlasUser,'')) or (ISNULL(SFDC,'') <> ISNULL(AtlasUser,'') and ISNULL(SFDC,'') = ISNULL(Shorthorn,'')) or (ISNULL(Shorthorn,'') <> ISNULL(SFDC,'') and ISNULL(Shorthorn,'') = ISNULL(AtlasUser,'')) then 'Two Match'
when ISNULL(SFDC,'') = ISNULL(Shorthorn,'') and ISNULL(SFDC,'') = ISNULL(AtlasUser,'') then 'All Match' end Matching
FROM
(
	SELECT detail.ContactId, Field, detail.NewValue, MAX(SC) Changes, MAX(detail.CreatedDate) MostRecentChange,
	case when detail.Field = 'Salutation' then CONVERT(VarChar(MAX), c.Salutation)
	when detail.Field = 'FirstName' then CONVERT(VarChar(MAX), c.FirstName)
	when detail.Field = 'LastName' then CONVERT(VarChar(MAX), c.LastName)
	when detail.Field = 'Email' then CONVERT(VarChar(MAX), c.Email)
	when detail.Field = 'Account' then CONVERT(VarChar(MAX), c.AccountId)
	when detail.Field = 'Active__c' then CONVERT(VarChar(MAX), c.Active__c)
	when detail.Field = 'MobilePhone' then CONVERT(VarChar(MAX), c.MobilePhone)
	when detail.Field = 'Phone' then CONVERT(VarChar(MAX), c.Phone)
	when detail.Field = 'Position__c' then CONVERT(VarChar(MAX), c.Position__c) end SFDC,
	case when detail.Field = 'Salutation' and shc.title = 1 then 'Mr'
	when detail.Field = 'Salutation' and shc.title = 2 then 'Mrs'
	when detail.Field = 'Salutation' and shc.title = 3 then 'Miss'
	when detail.Field = 'Salutation' and shc.title = 4 then 'Ms'
	when detail.Field = 'Salutation' and shc.title = 5 then 'Dr'
	when detail.Field = 'FirstName' then CONVERT(VarChar(MAX), shc.fName)
	when detail.Field = 'LastName' then CONVERT(VarChar(MAX), shc.sName)
	when detail.Field = 'Email' then CONVERT(VarChar(MAX), shc.email)
	when detail.Field = 'Active__c' then CONVERT(VarChar(MAX), shc.enabled)
	when detail.Field = 'MobilePhone' then CONVERT(VarChar(MAX), shc.mob)
	when detail.Field = 'Phone' then CONVERT(VarChar(MAX), shc.tel)
	when detail.Field = 'Position__c' then CONVERT(VarChar(MAX), shc.position) end Shorthorn,
	case when detail.Field = 'FirstName' then CONVERT(VarChar(MAX), au.FirstName__c)
	when detail.Field = 'LastName' then CONVERT(VarChar(MAX), au.SecondName__c)
	when detail.Field = 'Email' then CONVERT(VarChar(MAX), au.Email__c)
	when detail.Field = 'Account' then CONVERT(VarChar(MAX), au.Account__c)
	when detail.Field = 'Active__c' then CONVERT(VarChar(MAX), au.IsActive__c)
	when detail.Field = 'Position__c' then CONVERT(VarChar(MAX), au.Role__c) end AtlasUser
	FROM
	(
		SELECT ch.ContactId, Field, NewValue, ch.CreatedDate, ROW_NUMBER () OVER (PARTITION BY ch.ContactId, Field, NewValue ORDER BY ch.CreatedDate desc) SC
		FROM Salesforce..ContactHistory ch
		inner join Salesforce..[User] u ON ch.CreatedById = u.Id
		WHERE u.Name in ('Salesforce Admin','Mike Stevenson')
	) detail
	left outer join Salesforce..Contact c ON detail.ContactId = c.Id
	left outer join [database].shorthorn.dbo.cit_sh_contacts shc ON c.Shorthorn_Id__c = shc.contactId											
	left outer join Salesforce..ATLAS_User__c au ON c.Id = au.Contact__c
	WHERE SC > 3
	GROUP BY detail.ContactId, Field, NewValue,
	case when detail.Field = 'Salutation' then CONVERT(VarChar(MAX), c.Salutation)
	when detail.Field = 'FirstName' then CONVERT(VarChar(MAX), c.FirstName)
	when detail.Field = 'LastName' then CONVERT(VarChar(MAX), c.LastName)
	when detail.Field = 'Email' then CONVERT(VarChar(MAX), c.Email)
	when detail.Field = 'Account' then CONVERT(VarChar(MAX), c.AccountId)
	when detail.Field = 'Active__c' then CONVERT(VarChar(MAX), c.Active__c)
	when detail.Field = 'MobilePhone' then CONVERT(VarChar(MAX), c.MobilePhone)
	when detail.Field = 'Phone' then CONVERT(VarChar(MAX), c.Phone)
	when detail.Field = 'Position__c' then CONVERT(VarChar(MAX), c.Position__c) end,
	case when detail.Field = 'Salutation' and shc.title = 1 then 'Mr'
	when detail.Field = 'Salutation' and shc.title = 2 then 'Mrs'
	when detail.Field = 'Salutation' and shc.title = 3 then 'Miss'
	when detail.Field = 'Salutation' and shc.title = 4 then 'Ms'
	when detail.Field = 'Salutation' and shc.title = 5 then 'Dr'
	when detail.Field = 'FirstName' then CONVERT(VarChar(MAX), shc.fName)
	when detail.Field = 'LastName' then CONVERT(VarChar(MAX), shc.sName)
	when detail.Field = 'Email' then CONVERT(VarChar(MAX), shc.email)
	when detail.Field = 'Active__c' then CONVERT(VarChar(MAX), shc.enabled)
	when detail.Field = 'MobilePhone' then CONVERT(VarChar(MAX), shc.mob)
	when detail.Field = 'Phone' then CONVERT(VarChar(MAX), shc.tel)
	when detail.Field = 'Position__c' then CONVERT(VarChar(MAX), shc.position) end,
	case when detail.Field = 'FirstName' then CONVERT(VarChar(MAX), au.FirstName__c)
	when detail.Field = 'LastName' then CONVERT(VarChar(MAX), au.SecondName__c)
	when detail.Field = 'Email' then CONVERT(VarChar(MAX), au.Email__c)
	when detail.Field = 'Account' then CONVERT(VarChar(MAX), au.Account__c)
	when detail.Field = 'Active__c' then CONVERT(VarChar(MAX), au.IsActive__c)
	when detail.Field = 'Position__c' then CONVERT(VarChar(MAX), au.Role__c) end
	HAVING MAX(detail.CreatedDate) >= DATEADD(day,-7,GETDATE())
) detail
ORDER BY Matching, [Changes] desc