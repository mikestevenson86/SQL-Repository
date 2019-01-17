exec Salesforce..SF_Refresh 'Salesforce','LeadHistory'

SELECT 
	lh.CreatedDate, 
	u.Name Agent, 
	LeadId, 
	Field, 
	OldValue, 
	NewValue

FROM 
	Salesforce..LeadHistory lh
	inner join Salesforce..[User] u ON lh.CreatedById = u.Id

WHERE 
	u.Name in ('Suzanne Aguiz','Amanda Modev','Leon Weate') 
	and 
	CONVERT(date, lh.CreatedDate) = CONVERT(date, GETDATE())
	and 
	Field not in ('Active_Seminar_Viewed_Date__c','ownerassignment') 
	and 
	NOT(Field = 'Notes__c' and NewValue = OldValue) 
	and 
	NOT(Field = 'BDC__c' and NewValue like '005%')

ORDER BY 
	lh.CreatedDate