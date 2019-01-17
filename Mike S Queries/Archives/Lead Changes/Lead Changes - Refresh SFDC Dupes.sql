IF OBJECT_ID('LeadChangeReview..LPhones') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..LPhones
	END
	
SELECT LeadId, Phone, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..LPhones
FROM
(
	SELECT lh.LeadId, lh.CreatedDate, REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') Phone, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..LeadHistory lh
	left outer join Salesforce..LeadHistory le ON lh.LeadId = le.LeadId 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														= REPLACE(case when le.OldValue like '0%' then le.OldValue else '0'+le.OldValue end,' ','') 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														<> REPLACE(case when le.NewValue like '0%' then le.NewValue else '0'+le.NewValue end,' ','') 
													and le.Field = 'Phone'
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'Phone'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')

		UNION ALL

	SELECT l.Id, l.CreatedDate, REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ',''), GETDATE()
	FROM Salesforce..Lead l
	left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'Phone'
	WHERE lh.LeadId is null
) detail
WHERE Phone <> '' and Phone <> '0'

IF OBJECT_ID('LeadChangeReview..LMobiles') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..LMobiles
	END
	
SELECT LeadId, Mobile, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..LMobiles
FROM
(
	SELECT lh.LeadId, lh.CreatedDate, REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') Mobile, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..LeadHistory lh
	left outer join Salesforce..LeadHistory le ON lh.LeadId = le.LeadId 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														= REPLACE(case when le.OldValue like '0%' then le.OldValue else '0'+le.OldValue end,' ','') 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														<> REPLACE(case when le.NewValue like '0%' then le.NewValue else '0'+le.NewValue end,' ','') 
													and le.Field = 'MobilePhone'
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'MobilePhone'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')

		UNION ALL

	SELECT l.Id, l.CreatedDate, REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ',''), GETDATE()
	FROM Salesforce..Lead l
	left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'MobilePhone'
	WHERE lh.LeadId is null
) detail
WHERE Mobile <> '' and Mobile <> '0'

IF OBJECT_ID('LeadChangeReview..LCompany') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..LCompany
	END

SELECT LeadId, Company, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..LCompany
FROM
(
	SELECT lh.LeadId, lh.CreatedDate, lh.NewValue Company, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..LeadHistory lh
	left outer join Salesforce..LeadHistory le ON lh.LeadId = le.LeadId 
													and lh.NewValue = le.OldValue 
													and lh.NewValue <> le.NewValue 
													and le.Field = 'Company' 
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'Company'
	and 
	lh.NewValue	<> lh.OldValue

		UNION ALL

	SELECT l.Id, l.CreatedDate, l.Company, GETDATE()
	FROM Salesforce..Lead l
	left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'Company'
	WHERE lh.LeadId is null
) detail
WHERE Company <> ''

IF OBJECT_ID('LeadChangeReview..ACompany') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..ACompany
	END

SELECT AccountId, Company, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..ACompany
FROM
(
	SELECT lh.AccountId, lh.CreatedDate, lh.NewValue Company, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..AccountHistory lh
	left outer join Salesforce..AccountHistory le ON lh.AccountId = le.AccountId 
													and lh.NewValue = le.OldValue 
													and lh.NewValue <> le.NewValue 
													and le.Field = 'TextName' 
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'TextName'
	and 
	lh.NewValue	<> lh.OldValue

		UNION ALL

	SELECT l.Id, l.CreatedDate, l.Name, GETDATE()
	FROM Salesforce..Account l
	left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'TextName'
	WHERE lh.AccountID is null
) detail
WHERE Company <> ''

IF OBJECT_ID('LeadChangeReview..APostcode') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..APostcode
	END

SELECT AccountId, BillingPostalCode Postcode, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..APostcode
FROM
(
	SELECT lh.AccountId, lh.CreatedDate, lh.NewValue BillingPostalCode, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..AccountHistory lh
	left outer join Salesforce..AccountHistory le ON lh.AccountId = le.AccountId 
													and lh.NewValue = le.OldValue 
													and lh.NewValue <> le.NewValue 
													and le.Field = 'BillingPostalCode' 
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'BillingPostalCode'
	and 
	lh.NewValue	<> lh.OldValue

		UNION ALL

	SELECT l.Id, l.CreatedDate, l.BillingPostalCode, GETDATE()
	FROM Salesforce..Account l
	left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'BillingPostalCode'
	WHERE lh.AccountID is null
) detail
WHERE BillingPostalCode <> ''

IF OBJECT_ID('LeadChangeReview..APhones') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..APhones
	END

SELECT AccountId, Phone, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..APhones
FROM
(
	SELECT lh.AccountId, lh.CreatedDate, REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') Phone, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..AccountHistory lh
	left outer join Salesforce..AccountHistory le ON lh.AccountId = le.AccountId 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														= REPLACE(case when le.OldValue like '0%' then le.OldValue else '0'+le.OldValue end,' ','') 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														<> REPLACE(case when le.NewValue like '0%' then le.NewValue else '0'+le.NewValue end,' ','') 
													and le.Field = 'Phone'
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'Phone'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')

		UNION ALL

	SELECT l.Id, l.CreatedDate, REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ',''), GETDATE()
	FROM Salesforce..Account l
	left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'Phone'
	WHERE lh.AccountID is null
) detail
WHERE Phone <> '' and Phone <> '0'

IF OBJECT_ID('LeadChangeReview..SPostcode') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..SPostcode
	END

SELECT ParentId, Postcode, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..SPostcode
FROM
(
	SELECT lh.ParentId, lh.CreatedDate, lh.NewValue PostCode, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..Site__History lh
	left outer join Salesforce..Site__History le ON lh.ParentId = le.ParentId 
													and lh.NewValue = le.OldValue 
													and lh.NewValue <> le.NewValue 
													and le.Field = 'Postcode__c' 
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'Postcode__c'
	and 
	lh.NewValue	<> lh.OldValue

		UNION ALL

	SELECT l.Id, l.CreatedDate, l.Postcode__c, GETDATE()
	FROM Salesforce..Site__c l
	left outer join Salesforce..Site__History lh ON l.Id = lh.ParentId and lh.Field = 'Postcode__c'
	WHERE lh.ParentId is null
) detail
WHERE PostCode <> ''

IF OBJECT_ID('LeadChangeReview..SPhones') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..SPhones
	END

SELECT ParentId, Phone, CONVERT(date, CreatedDate) StartDate, CONVERT(date, LastDate) EndDate
INTO LeadChangeReview..SPhones
FROM
(
	SELECT lh.ParentId, lh.CreatedDate, REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') Phone, ISNULL(le.CreatedDate, GETDATE()) LastDate
	FROM Salesforce..Site__History lh
	left outer join Salesforce..Site__History le ON lh.ParentId = le.ParentId 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														= REPLACE(case when le.OldValue like '0%' then le.OldValue else '0'+le.OldValue end,' ','') 
													and REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
														<> REPLACE(case when le.NewValue like '0%' then le.NewValue else '0'+le.NewValue end,' ','') 
													and le.Field = 'Phone__c'
													and le.CreatedDate > lh.CreatedDate

	WHERE 
	lh.Field = 'Phone__c'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')

		UNION ALL

	SELECT l.Id, l.CreatedDate, REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ',''), GETDATE()
	FROM Salesforce..Site__c l
	left outer join Salesforce..Site__History lh ON l.Id = lh.ParentId and lh.Field = 'Phone__c'
	WHERE lh.ParentId is null
) detail
WHERE Phone <> '' and Phone <> '0'