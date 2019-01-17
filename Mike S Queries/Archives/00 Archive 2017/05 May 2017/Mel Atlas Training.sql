		SELECT 
		ap.Id, 
		a.Name Company, 
		c.Name Contact, 
		ap.TrainingDeliveredBy__c Trainer,
		CONVERT(date, TrainingDate__c) TrainingDate, 
		ap.CreatedDate [Inserted Date],
		ap.LastModifiedDate [Updated Date]

		FROM 
		Salesforce..AtlasTrainingPlan__c ap
		left outer join Salesforce..Contact c ON ap.Contact__c = c.Id
		left outer join Salesforce..Account a ON c.AccountId = a.Id

		WHERE 
		TrainingStatus__c = 'Complete' 
		and 
		DATEPART(Month, TrainingDate__c) = DATEPART(Month, GETDATE())