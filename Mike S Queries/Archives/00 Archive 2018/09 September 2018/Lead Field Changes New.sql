	IF OBJECT_ID('tempdb..#PhoneChanges') IS NOT NULL DROP TABLE #PhoneChanges
	IF OBJECT_ID('tempdb..#MobileChanges') IS NOT NULL DROP TABLE #MobileChanges
	IF OBJECT_ID('tempdb..#CompChanges') IS NOT NULL DROP TABLE #CompChanges
	IF OBJECT_ID('tempdb..#ACompChanges') IS NOT NULL DROP TABLE #ACompChanges
	IF OBJECT_ID('tempdb..#APostCodeChanges') IS NOT NULL DROP TABLE #APostCodeChanges
	IF OBJECT_ID('tempdb..#APhoneChanges') IS NOT NULL DROP TABLE #APhoneChanges
	IF OBJECT_ID('tempdb..#SPostCodeChanges') IS NOT NULL DROP TABLE #SPostCodeChanges
	IF OBJECT_ID('tempdb..#SPhoneChanges') IS NOT NULL DROP TABLE #SPhoneChanges	

-- Lead Phone
	
	SELECT lh.LeadId, lh.CreatedDate,
	REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','') OldPhone, 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') NewPhone
	INTO #PhoneChanges
	FROM Salesforce..LeadHistory lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'Phone'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')
	
	IF OBJECT_ID('LeadChangeReview..LPhones') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..LPhones
	END
	
	SELECT LeadId, Phone, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..LPhones
	FROM
	(
		SELECT pc.LeadId, pc.CreatedDate StartDate, pc.NewPhone Phone, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #PhoneChanges pc
		left outer join #PhoneChanges lh ON pc.LeadId = lh.LeadId
											and pc.NewPhone = lh.OldPhone
											and pc.NewPhone <> lh.NewPhone
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ',''), GETDATE() EndDate
		FROM Salesforce..Lead l with(nolock)
		left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'Phone'
		WHERE lh.LeadId is null
	) detail
	WHERE Phone <> '' and Phone <> '0'
	GROUP BY LeadId, Phone, CONVERT(date, StartDate), CONVERT(date, EndDate)
	
-- Lead Mobile

	SELECT lh.LeadId, lh.CreatedDate,
	REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','') OldPhone, 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') NewPhone
	INTO #MobileChanges
	FROM Salesforce..LeadHistory lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'MobilePhone'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')
	
	IF OBJECT_ID('LeadChangeReview..LMobiles') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..LMobiles
	END
	
	SELECT LeadId, Mobile, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..LMobiles
	FROM
	(
		SELECT pc.LeadId, pc.CreatedDate StartDate, pc.NewPhone Mobile, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #MobileChanges pc
		left outer join #MobileChanges lh ON pc.LeadId = lh.LeadId
											and pc.NewPhone = lh.OldPhone
											and pc.NewPhone <> lh.NewPhone
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ',''), GETDATE() EndDate
		FROM Salesforce..Lead l with(nolock)
		left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'MobilePhone'
		WHERE lh.LeadId is null
	) detail
	WHERE Mobile <> '' and Mobile <> '0'
	GROUP BY LeadId, Mobile, CONVERT(date, StartDate), CONVERT(date, EndDate)
	
-- Lead Company

	SELECT lh.LeadId, lh.CreatedDate,
	lh.OldValue OldComp, 
	lh.NewValue NewComp
	INTO #CompChanges
	FROM Salesforce..LeadHistory lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'Company'
	and 
	lh.NewValue <> lh.OldValue
	
	IF OBJECT_ID('LeadChangeReview..LCompany') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..LCompany
	END
	
	SELECT LeadId, Company, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..LCompany
	FROM
	(
		SELECT pc.LeadId, pc.CreatedDate StartDate, pc.NewComp Company, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #CompChanges pc
		left outer join #CompChanges lh ON pc.LeadId = lh.LeadId
											and pc.NewComp = lh.OldComp
											and pc.NewComp <> lh.NewComp
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, l.Company, GETDATE() EndDate
		FROM Salesforce..Lead l with(nolock)
		left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'Company'
		WHERE lh.LeadId is null
	) detail
	WHERE Company <> ''
	GROUP BY LeadId, Company, CONVERT(date, StartDate), CONVERT(date, EndDate)
	
-- Account Company

	SELECT lh.AccountId, lh.CreatedDate,
	lh.OldValue OldComp, 
	lh.NewValue NewComp
	INTO #ACompChanges
	FROM Salesforce..AccountHistory lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'TextName'
	and 
	lh.NewValue <> lh.OldValue
	
	IF OBJECT_ID('LeadChangeReview..ACompany') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..ACompany
	END
	
	SELECT AccountId, Company, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..ACompany
	FROM
	(
		SELECT pc.AccountId, pc.CreatedDate StartDate, pc.NewComp Company, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #ACompChanges pc
		left outer join #ACompChanges lh ON pc.AccountId = lh.AccountId
											and pc.NewComp = lh.OldComp
											and pc.NewComp <> lh.NewComp
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, l.Name, GETDATE() EndDate
		FROM Salesforce..Account l with(nolock)
		left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'TextName'
		WHERE lh.AccountId is null
	) detail
	WHERE Company <> ''
	GROUP BY AccountId, Company, CONVERT(date, StartDate), CONVERT(date, EndDate)
	
-- Account Postcode

	SELECT lh.AccountId, lh.CreatedDate,
	lh.OldValue OldPostCode, 
	lh.NewValue NewPostCode
	INTO #APostCodeChanges
	FROM Salesforce..AccountHistory lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'BillingPostalCode'
	and 
	lh.NewValue <> lh.OldValue
	
	IF OBJECT_ID('LeadChangeReview..APostCode') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..APostCode
	END
	
	SELECT AccountId, BillingPostalCode, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..APostCode
	FROM
	(
		SELECT pc.AccountId, pc.CreatedDate StartDate, pc.NewPostCode BillingPostalCode, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #APostCodeChanges pc
		left outer join #APostCodeChanges lh ON pc.AccountId = lh.AccountId
											and pc.NewPostCode = lh.OldPostCode
											and pc.NewPostCode <> lh.NewPostCode
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, l.BillingPostalCode, GETDATE() EndDate
		FROM Salesforce..Account l with(nolock)
		left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'BillingPostalCode'
		WHERE lh.AccountId is null
	) detail
	WHERE BillingPostalCode <> ''
	GROUP BY AccountId, BillingPostalCode, CONVERT(date, StartDate), CONVERT(date, EndDate)
	
-- Account Phone

	SELECT lh.AccountId, lh.CreatedDate,
	REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','') OldPhone, 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') NewPhone
	INTO #APhoneChanges
	FROM Salesforce..AccountHistory lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'Phone'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')
	
	IF OBJECT_ID('LeadChangeReview..APhones') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..APhones
	END
	
	SELECT AccountId, Phone, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..APhones
	FROM
	(
		SELECT pc.AccountId, pc.CreatedDate StartDate, pc.NewPhone Phone, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #APhoneChanges pc
		left outer join #APhoneChanges lh ON pc.AccountId = lh.AccountId
											and pc.NewPhone = lh.OldPhone
											and pc.NewPhone <> lh.NewPhone
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ',''), GETDATE() EndDate
		FROM Salesforce..Account l with(nolock)
		left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'Phone'
		WHERE lh.AccountId is null
	) detail
	WHERE Phone <> '' and Phone <> '0'
	GROUP BY AccountId, Phone, CONVERT(date, StartDate), CONVERT(date, EndDate)

-- Site Postcode

	SELECT lh.ParentId, lh.CreatedDate,
	lh.OldValue OldPostCode, 
	lh.NewValue NewPostCode
	INTO #SPostCodeChanges
	FROM Salesforce..Site__History lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'PostCode__c'
	and 
	lh.NewValue <> lh.OldValue
	
	IF OBJECT_ID('LeadChangeReview..SPostCode') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..SPostCode
	END
	
	SELECT ParentId, PostCode, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..SPostCode
	FROM
	(
		SELECT pc.ParentId, pc.CreatedDate StartDate, pc.NewPostCode PostCode, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #SPostCodeChanges pc
		left outer join #SPostCodeChanges lh ON pc.ParentId = lh.ParentId
											and pc.NewPostCode = lh.OldPostCode
											and pc.NewPostCode <> lh.NewPostCode
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, l.Postcode__c, GETDATE() EndDate
		FROM Salesforce..Site__c l with(nolock)
		left outer join Salesforce..AccountHistory lh ON l.Id = lh.AccountId and lh.Field = 'PostCode__c'
		WHERE lh.AccountId is null
	) detail
	WHERE PostCode <> ''
	GROUP BY ParentId, PostCode, CONVERT(date, StartDate), CONVERT(date, EndDate) 
	
-- Site Phone

	SELECT lh.ParentId, lh.CreatedDate,
	REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','') OldPhone, 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','') NewPhone
	INTO #SPhoneChanges
	FROM Salesforce..Site__History lh with(nolock)
	WHERE 
	CONVERT(date, lh.CreatedDate) >= CONVERT(date, DATEADD(month, -2, GETDATE()))
	and
	lh.Field = 'Phone__c'
	and 
	REPLACE(case when lh.NewValue like '0%' then lh.NewValue else '0'+lh.NewValue end,' ','')
	<> REPLACE(case when lh.OldValue like '0%' then lh.OldValue else '0'+lh.OldValue end,' ','')
	
	IF OBJECT_ID('LeadChangeReview..SPhones') IS NOT NULL
	BEGIN
		DROP TABLE LeadChangeReview..SPhones
	END
	
	SELECT ParentID, Phone, CONVERT(date, StartDate) StartDate, CONVERT(date, EndDate) EndDate
	INTO LeadChangeReview..SPhones
	FROM
	(
		SELECT pc.ParentId, pc.CreatedDate StartDate, pc.NewPhone Phone, ISNULL(lh.CreatedDate, GETDATE()) EndDate
		FROM #SPhoneChanges pc
		left outer join #SPhoneChanges lh ON pc.ParentId = lh.ParentId
											and pc.NewPhone = lh.OldPhone
											and pc.NewPhone <> lh.NewPhone
											and pc.CreatedDate < lh.CreatedDate
			UNION ALL

		SELECT l.Id, l.CreatedDate, REPLACE(case when l.Phone__c like '0%' then l.Phone__c else '0'+l.Phone__c end,' ',''), GETDATE() EndDate
		FROM Salesforce..Site__c l with(nolock)
		left outer join Salesforce..Site__History lh ON l.Id = lh.ParentId and lh.Field = 'Phone__c'
		WHERE lh.ParentId is null
	) detail
	WHERE Phone <> '' and Phone <> '0'
	GROUP BY ParentID, Phone, CONVERT(date, StartDate), CONVERT(date, EndDate)