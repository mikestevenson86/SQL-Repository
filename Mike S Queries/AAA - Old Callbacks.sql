BEGIN
	exec Salesforce..SF_Refresh 'Salesforce','LeadHistory'
END

SELECT lo.Id, lh.OldValue, lh2.OldValue
FROM SalesforceReporting..LastOverdueRun lo
inner join Salesforce..LeadHistory lh ON lo.Id = lh.LeadId 
										and CONVERT(date, lh.CreatedDate) = CONVERT(date, lo.RunDate) 
										and Field = 'BDC__c'
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
inner join Salesforce..LeadHistory lh2 ON lo.Id = lh2.LeadId 
										and CONVERT(date, lh2.CreatedDate) = CONVERT(date, lo.RunDate) 
										and lh2.Field = 'Callback_Date_Time__c'
inner join Salesforce..[User] u2 ON lh.CreatedById = u2.Id
WHERE 
u.Name = 'Salesforce Admin' 
and
u2.Name = 'Salesforce Admin'
and 
lh.NewValue = 'Jo Wood' 
and 
lh2.NewValue is null 
and 
CONVERT(date, lh2.OldValue) > CONVERT(date, lo.RunDate) 