IF OBJECT_ID('tempdb..#ELHR') IS NOT NULL
	BEGIN
		DROP TABLE #ELHR
	END
IF OBJECT_ID('tempdb..#HS') IS NOT NULL
	BEGIN
		DROP TABLE #HS
	END
	
SELECT AccountId INTO #ELHR FROM Salesforce..Contract
WHERE Services_Taken_EL__c = 'true' and StartDate < GETDATE() and EndDate > GETDATE() and Cancellation_Date__c is null
GROUP BY AccountId

SELECT c.AccountID INTO #HS FROM Salesforce..Contract c
inner join #ELHR hr ON c.AccountId = hr.AccountId
WHERE Services_Taken_HS__c = 'true' and StartDate < GETDATE() and EndDate > GETDATE() and Cancellation_Date__c is null
GROUP BY c.AccountId

SELECT
a.Name Company,
c.FirstName	[First Name],
c.LastName	[Last Name],
c.Email,
a.s__c Segmentation,
a.CitationSector__c Sector,
c.Helpline_H_S__c [H&S Contact],
c.Helpline_PEL__c	[HR Contact],
c.Migration_Contact__c	[Onboarding Contact],
c.AdviceCard__c	[Advice Card],
c.Main_User__c	[Main Contact],
c.Billing_Contact__c	[Billing Contact]

FROM
Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id	
inner join #HS hs ON c.AccountId = hs.AccountId

WHERE
a.IsActive__c = 'true'
and
a.Citation_Client__c = 'true'
and
c.Active__c = 'true'
and
c.HasOptedOutOfEmail = 'false'
and
ISNULL(c.Email, '') like '%@%'
and
ISNULL(c.Email, '') not like '%@citation.co.uk%'

ORDER BY a.Name, c.Name