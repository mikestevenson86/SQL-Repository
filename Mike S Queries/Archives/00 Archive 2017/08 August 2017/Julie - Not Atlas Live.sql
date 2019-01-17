SELECT a.Id, a.Name, a.ATLASLive__c, StartDate, EndDate, Cancellation_Date__c, Status, Test_Account__c 
FROM Salesforce..Account a
inner join Salesforce..[Contract] c ON c.AccountId = a.Id
WHERE a.Name in
(
'Grade A Care Ltd',
'Elite Services Holdings Limited',
'PTM Media Ltd',
'Cuddles Day Nursery Ltd',
'Glasgow Auto''s Ltd t/a Khan Auto''s',
'Annandale Roofing Ltd',
'PH Insulations Ltd',
'Cam Systems Ltd',
'Interdive Services Ltd',
'Loyalcare Group Services Ltd',
'Moseley Golf Club Ltd',
'R Nightingale Ltd'
)
/*
and
	ATLASLive__c = 'false' and
	(
		(
		CONVERT(date, StartDate) <= CONVERT(date, GETDATE())
		and
		CONVERT(date, EndDate) >= CONVERT(date, GETDATE())
		and
		Cancellation_Date__c is null
		and
		Status = 'Active'
		and
		Test_Account__c = 'false'
		)
			or
		(
		Status = 'Pending Start'
		and
		CONVERT(date, StartDate) >= CONVERT(date, GETDATE())
		and
		Cancellation_Date__c is null
		and
		Test_Account__c = 'false'
		)
	)
*/
ORDER BY a.ATLASLive__c, a.Name