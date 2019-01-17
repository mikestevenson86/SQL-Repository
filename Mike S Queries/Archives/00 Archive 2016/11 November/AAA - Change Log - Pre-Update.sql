IF OBJECT_ID('SalesforceReporting..TempChanges') IS NOT NULL 
	BEGIN
		DROP TABLE SalesforceReporting..TempChanges
	END

SELECT *
INTO SalesforceReporting..TempChanges
FROM
(	
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'Street' Field,
	l.Street OldValue,
	ml.Street NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.Street <> l.Street
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'City' Field,
	l.City OldValue,
	ml.City NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.City <> l.City
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'State' Field,
	l.State OldValue,
	ml.State NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.State <> l.State
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'PostalCode' Field,
	l.PostalCode OldValue,
	ml.Postalcode NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.Postalcode <> l.PostalCode 
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'FirstName' Field,
	l.FirstName OldValue,
	ml.FirstName NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.FirstName <> l.FirstName
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'LastName' Field,
	l.LastName OldValue,
	ml.LastName NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.LastName <> l.LastName
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'Salutation' Field,
	l.Salutation OldValue,
	ml.Salutation NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.Salutation <> l.Salutation 
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'Position__c' Field,
	l.Position__c OldValue,
	ml.Position__c NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.Position__c <> l.Position__c 
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'Email' Field,
	l.Email OldValue,
	ml.Email NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.Email <> l.Email
	
		UNION
		
	SELECT 
	CONVERT(date, GETDATE()) CreatedDate,
	'ML' [Source],
	l.Id,
	'Website' Field,
	l.Website OldValue,
	ml.Website NewValue
	FROM MarketLocation..ML_Amends_Filtered ml
	inner join Salesforce..Lead l ON ml.Id = l.Id
	WHERE
	ml.Website <> l.Website
) detail