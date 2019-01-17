SELECT 
detail.Id, 
detail.Name [Current Owner], 
detail.BDM [Expected Owner], 
detail.LeadPCArea [Prospect Postcode Area], 
detail.[PostCode Area] [Assignment Postcode Area],
detail.Affinity_Cold__c

FROM
(
	SELECT l.Id, u.Name, pc.BDM, LEFT(l.PostalCode, 4) LeadPCArea, pc.[PostCode Area], Affinity_Cold__c
	FROM Salesforce..Lead l
	inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 4) = pc.[PostCode Area]
	inner join Salesforce..[User] u ON l.OwnerId = u.Id
	WHERE pc.AreaLength = 4 and l.Status <> 'Approved'

UNION

	SELECT l.Id, u.Name, pc.BDM, LEFT(l.PostalCode, 3) LeadPCArea, pc.[PostCode Area], Affinity_Cold__c
	FROM Salesforce..Lead l
	inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 3) = pc.[PostCode Area]
	inner join Salesforce..[User] u ON l.OwnerId = u.Id
	WHERE pc.AreaLength = 3 and l.Status <> 'Approved' and l.Id not in
		(
		SELECT l.Id
		FROM Salesforce..Lead l
		inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 4) = pc.[PostCode Area]
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		WHERE pc.AreaLength = 4 and l.Status <> 'Approved'
		UNION
		SELECT l.Id
		FROM Salesforce..Lead l
		inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 2) = pc.[PostCode Area]
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		WHERE pc.AreaLength = 2 and l.Status <> 'Approved'
		)
		
UNION

	SELECT l.Id, u.Name, pc.BDM, LEFT(l.PostalCode, 2) LeadPCArea, pc.[PostCode Area], Affinity_Cold__c
	FROM Salesforce..Lead l
	inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 2) = pc.[PostCode Area]
	inner join Salesforce..[User] u ON l.OwnerId = u.Id
	WHERE pc.AreaLength = 2 and l.Status <> 'Approved' and l.Id not in
		(
		SELECT l.Id
		FROM Salesforce..Lead l
		inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 4) = pc.[PostCode Area]
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		WHERE pc.AreaLength = 4 and l.Status <> 'Approved'
		UNION
		SELECT l.Id
		FROM Salesforce..Lead l
		inner join SalesforceReporting..PostCodeAssignments pc ON LEFT(l.PostalCode, 3) = pc.[PostCode Area]
		inner join Salesforce..[User] u ON l.OwnerId = u.Id
		WHERE pc.AreaLength = 3 and l.Status <> 'Approved'
		)
) detail
inner join Salesforce..Lead l ON detail.Id = l.Id

WHERE detail.Name <> detail.BDM
and NOT 
(
(l.RecordTypeId <> '012D0000000KKTvIAO' and MADE_Criteria__c in ('Self Gen - 1','Self Gen - 2','Self Gen - 4','Introducer – Self Gen')
and LeadSource in ('Self Gen','SelfGen_BDC','SelfGen_Consultant','SelfGen_Consultant_500')) or OwnerId = '005D00000039IVjIAM'
)
and NOT
(
l.RecordTypeId = '012D0000000KKTvIAO' and OwnerId in 
	(
	'005D0000005v8ljIAA',
	'005D0000005v8nLIAQ',
	'005D000000629leIAA',
	'005D0000005uGAtIAM',
	'005D0000006cigbIAA',
	'005D0000008eqyzIAA',
	'005D0000005v8lUIAQ',
	'005D0000005v8loIAA',
	'005D0000005v8lyIAA',
	'005D0000005v8m8IAA',
	'005D000000377MSIAY',
	'005D00000037QJcIAM',
	'005D0000005v8l0IAA',
	'005D0000005v8lKIAQ'
	)
)
and NOT
(
MADE_Criteria__c = 'ISO - MADE'
)
and NOT
(
l.RecordTypeId = '012D0000000KKTvIAO' and l.LeadSource = 'Web (Imp Guide)'
)
and NOT
(
l.RecordTypeId = '012D0000000KKTvIAO' and l.LeadSource in ('Web (Auto-Quote)','Web (Call back Form)','Web (Incoming Call)','Client Referral (Voucher)','Client Referral (Wine)','Ref_Emp_QMS')
)
and NOT
(
l.RecordTypeId = '012D0000000NbJtIAK'
)
and NOT
(
LeadSource = 'Website' and l.RecordTypeId = '012D0000000NcsyIAC'
)
and NOT
(
LeadSource in ('Website','PPC') and l.RecordTypeId not in ('012D0000000KKTvIAO','012D0000000NbJtIAK')
)
and RecordTypeId not in ('012D0000000KKTvIAO','012D0000000NbJtIAK')