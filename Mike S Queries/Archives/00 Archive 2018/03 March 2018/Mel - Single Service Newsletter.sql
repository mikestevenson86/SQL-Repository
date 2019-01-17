SELECT 
a.Id, 
a.Name CompanyName, 
c.FirstName, 
c.LastName, 
c.Email, 
a.S__c Segmentation, 
c.Active__c [Is Contact Active?], 
a.Citation_Client__c [Is Citation Client?], 
a.CitationSector__c [Sector], 
case when ISNULL(c.Helpline_H_S__c, '') = 'Yes' then 'TRUE' else 'FALSE' end HelplineHS, 
case when ISNULL(c.Helpline_PEL__c, '') = 'Yes' then 'TRUE' else 'FALSE' end HelplinePEL,
c.AdviceCard__c AdviceCard, 
c.Service_Owner__c ServiceOwner,
case when ISNULL(c.Main_User__c, '') = 'Yes' then 'TRUE' else 'FALSE' end MainUser, 
c.Billing_Contact__c BillingContact,
c.HasOptedOutOfEmail [Email Opt Out?],
REPLACE(REPLACE(REPLACE(REPLACE(LTRIM([Services]), 'HSELHR','Combined'),'HSEL','H&S EL'),'HS','H&S'),'ELHR','EL & HR') [Services]

FROM
(
	SELECT 
	a.Id, 
	STUFF
	(
		(
			SELECT 
					', ' + case when c2.Services_Taken_HS__c = 'true' then 'HS' else '' end + case when c2.Services_Taken_EL__c = 'true' then 'ELHR' else '' end
			FROM 
					Salesforce..Contract c2
					inner join Salesforce..Account a2 ON c2.AccountId = a2.Id
			WHERE
					a.Id = a2.Id
					and
					c2.StartDate <= GETDATE() and c2.EndDate > GETDATE() and c2.Cancellation_Date__c is null
					and
					(
						c2.Services_Taken_HS__c = 'true' or c2.Services_Taken_EL__c = 'true'
					)
			ORDER BY 
					case when c2.Services_Taken_HS__c = 'true' then 'HS' else '' end + case when c2.Services_Taken_EL__c = 'true' then 'ELHR' else '' end
			FOR XML PATH ('')
		), 1, 1, ''
	) [Services]
	
	FROM 
	Salesforce..Account a
	inner join Salesforce..Contract c ON a.Id = c.AccountId
	
	WHERE 
	c.StartDate <= GETDATE() and c.EndDate > GETDATE() and c.Cancellation_Date__c is null
) detail
left outer join Salesforce..Account a ON detail.Id = a.Id
left outer join Salesforce..Contact c ON detail.Id = c.AccountId

WHERE 
(
	[Services] like '%HS%ELHR%' 
	or 
	[Services] like '%ELHR%HS%'
)
and 
c.HasOptedOutOfEmail = 'false'
and
a.IsActive__c = 'true' 
and 
a.Citation_Client__c = 'true' 
and 
c.Active__c = 'true' 
and 
ISNULL(c.Email, '') like '%@%'
and 
ISNULL(c.Email, '') not like '%citation.co.uk%' 
and 
(
	(
		Billing_Contact__c = 'true'
		and
		(
			ISNULL(Helpline_H_S__c, '') = 'Yes'
			or
			ISNULL(Helpline_PEL__c, '') = 'Yes'
			or
			c.Service_Owner__c = 'true'
			or
			c.AdviceCard__c = 'true'
			or
			ISNULL(c.Main_User__c, '') = 'Yes'
		)
	) or Billing_Contact__c = 'false'
)