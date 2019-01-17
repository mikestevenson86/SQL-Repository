-- Capture Changes

IF OBJECT_ID('tempdb..#Changes') IS NOT NULL
	BEGIN
		DROP TABLE #Changes
	END

	SELECT 
	svh.SiteVisitId,
	svh.Account__c, 
	svh.AccountSite__c,
	svh.Consultant__c HistoricCon,
	case when svt.Consultant__c <> svh.Consultant__c then svt.Consultant__c else '' end NewCon,
	svh.MainContact__c HistoricContact,
	case when svt.MainContact__c <> svh.MainContact__c then svt.MainContact__c else '' end NewContact,
	svh.TypeOfVisit__c,
	svh.VisitDate__c,
	svh.VisitNumber__c

	INTO
	#Changes

	FROM SalesforceReporting..SiteVisitsALL svt
	inner join SalesforceReporting..SiteVisitHistory svh ON svt.Account__c = svh.Account__c
															and svt.AccountSite__c = svh.AccountSite__c
															and svt.VisitDate__c = svh.VisitDate__c
															and svt.VisitNumber__c = svh.VisitNumber__c
															and svt.TypeOfVisit__c = svh.TypeOfVisit__c
	WHERE
	svt.Consultant__c <> svh.Consultant__c
	or
	svt.MainContact__c <> svh.MainContact__c

-- New Consultant - Updates

IF OBJECT_ID ('Salesforce..SiteVisit__c_Update') IS NOT NULL
	BEGIN 
		DROP TABLE Salesforce..SiteVisit__c_Update
	END

	SELECT 
	CAST(SiteVisitId as NCHAR(18)) Id,
	NewCon Consultant__c,
	CAST('' as NVarChar(255)) Error
	INTO
	Salesforce..SiteVisit__c_Update
	FROM
	#Changes
	WHERE
	SiteVisitId <> ''
	and
	NewCon <> ''

-- Load to Salesforce

IF (SELECT COUNT(1) FROM Salesforce..SiteVisit__c_Update) > 0
	BEGIN
		exec Salesforce..SF_BulkOps 'Update:batchsize(50)','Salesforce','SiteVisit__c_Update'
	END

-- New Consultant - Inserts

IF OBJECT_ID('Salesforce..SiteVisit__c_Load') IS NOT NULL
	BEGIN	
		DROP TABLE Salesforce..SiteVisit__c_Load
	END
	
	SELECT 
	CAST('' as NCHAR(18)) Id,
	Account__c,
	AccountSite__c,
	NewCon Consultant__c,
	case when NewContact = '' then HistoricContact else NewContact end MainContact__c,
	TypeOfVisit__c,
	VisitDate__c,
	VisitNumber__c,
	CAST('' as NVarChar(255)) Error
	INTO
	Salesforce..SiteVisit__c_Load
	FROM
	#Changes
	WHERE
	SiteVisitId = ''
	and
	NewCon <> ''

-- Load to Salesforce

IF (SELECT COUNT(1) FROM Salesforce..SiteVisit__c_Load) > 0
	BEGIN
		exec Salesforce..SF_BulkOps 'Insert:batchsize(5)','Salesforce','SiteVisit__c_Load'
	END

-- New Main Contact - Updates

IF OBJECT_ID ('Salesforce..SiteVisit__c_Update') IS NOT NULL
	BEGIN 
		DROP TABLE Salesforce..SiteVisit__c_Update
	END

	SELECT 
	CAST(SiteVisitId as NCHAR(18)) Id,
	NewContact MainContact__c,
	CAST('' as NVarChar(255)) Error
	INTO
	Salesforce..SiteVisit__c_Update
	FROM
	#Changes
	WHERE
	SiteVisitId <> ''
	and
	NewContact <> ''

-- Load to Salesforce

IF (SELECT COUNT(1) FROM Salesforce..SiteVisit__c_Update) > 0
	BEGIN
		exec Salesforce..SF_BulkOps 'Update:batchsize(50)','Salesforce','SiteVisit__c_Update'
	END

-- New Main Contact - Inserts

IF OBJECT_ID('Salesforce..SiteVisit__c_Load') IS NOT NULL
	BEGIN	
		DROP TABLE Salesforce..SiteVisit__c_Load
	END

	SELECT 
	CAST('' as NCHAR(18)) Id,
	Account__c,
	AccountSite__c,
	case when NewCon = '' then HistoricCon else NewCon end Consultant__c,
	NewContact MainContact__c,
	TypeOfVisit__c,
	VisitDate__c,
	VisitNumber__c,
	CAST('' as NVarChar(255)) Error
	INTO
	Salesforce..SiteVisit__c_Load
	FROM
	#Changes
	WHERE
	SiteVisitId = ''
	and
	NewContact <> ''

-- Load to Salesforce

IF (SELECT COUNT(1) FROM Salesforce..SiteVisit__c_Load) > 0
	BEGIN
		exec Salesforce..SF_BulkOps 'Insert:batchsize(5)','Salesforce','SiteVisit__c_Load'
	END