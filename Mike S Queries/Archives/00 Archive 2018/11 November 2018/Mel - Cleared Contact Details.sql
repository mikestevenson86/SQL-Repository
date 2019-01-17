IF OBJECT_ID('tempdb..#ContactHistory') IS NOT NULL
	BEGIN
		DROP TABLE #ContactHistory
	END

SELECT ch.*
INTO #ContactHistory
FROM Salesforce..ContactHistory ch
inner join Salesforce..[User] u ON ch.CreatedById = u.Id
WHERE ch.Field in ('Salutation','Phone','Position__c') and ISNULL(OldValue, '') <> '' and ISNULL(NewValue, '') = '' and u.Name = 'Mike Stevenson'

SELECT 
c.Id
,c.Salutation [SFDC Title]
,sht.title [Shorthorn Title]
,c.Phone [SFDC Phone]
,shc.tel [Shorthorn Phone]
,c.Position__c [SFDC Position]
,shc.position [Shorthorn Position]
FROM 
Salesforce..Contact c
left outer join Salesforce..Account a ON c.AccountId = a.Id
left outer join #ContactHistory ch On c.Id = ch.ContactId
left outer join [database].shorthorn.dbo.cit_sh_contacts shc ON c.Shorthorn_Id__c = shc.contactId
left outer join [database].shorthorn.dbo.cit_sh_titles sht ON shc.title = sht.titleId
WHERE 
a.Account_Data_Cleansed__c = 'true' 
and 
(
	ISNULL(c.Salutation, '') = ''
	or
	ISNULL(c.Position__c, '') = ''
	or
	ISNULL(c.Phone, '') = ''
)
and
c.Active__c = 'true'
and
ch.Id is not null
and
shc.contactId is not null
GROUP BY c.Id, c.Salutation, sht.title, c.Phone, shc.tel, c.Position__c, shc.position