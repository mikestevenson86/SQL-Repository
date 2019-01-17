-- Populate Table

IF OBJECT_ID('SalesforceReporting..WiredSuppressions') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..WiredSuppressions
	END

CREATE TABLE SalesforceReporting..WiredSuppressions
(
Email VarChar(200),
[Status] VarChar(50)
)

BULK INSERT SalesforceReporting..WiredSuppressions
FROM 
'C:\Users\mikestevenson\WiredSuppressions.txt' WITH (FIELDTERMINATOR='\t', ROWTERMINATOR='\n');

DELETE FROM SalesforceReporting..WiredSuppressions WHERE Email = 'Email' and Status = 'Status'

-- Leads

IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END

-- Load table for Soft Suppressions

SELECT 
CAST(Id as NCHAR(18)) Id, 
'TRUE' HasOptedOutOfEmail,
CAST('' as nvarchar(255)) Error

INTO
Salesforce..Lead_Update

FROM 
Salesforce..Lead

WHERE 
Status <> 'Approved' and HasOptedOutOfEmail = 'false' and Email in
	(
	SELECT Email
	FROM SalesforceReporting..WiredSuppressions
	WHERE Status not in ('HardBounced','ISPComplained','DirectComplaint')
	)

-- Upload to Salesforce	

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'

DROP TABLE Salesforce..Lead_Update

-- Load table for Hard Suppressions

SELECT 
CAST(Id as NCHAR(18)) Id, 
'TRUE' HasOptedOutOfEmail,
'' Email,
CAST('' as nvarchar(255)) Error

INTO
Salesforce..Lead_Update

FROM 
Salesforce..Lead

WHERE 
Status <> 'Approved' and Email in
	(
	SELECT Email
	FROM SalesforceReporting..WiredSuppressions
	WHERE Status in ('HardBounced','ISPComplained','DirectComplaint')
	)

-- Upload to Salesforce	

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'

DROP TABLE Salesforce..Lead_Update

-- Contacts

IF OBJECT_ID('Salesforce..Contact_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Contact_Update
	END

-- Load table for Soft Suppressions

SELECT 
CAST(Id as NCHAR(18)) Id, 
'TRUE' HasOptedOutOfEmail,
CAST('' as nvarchar(255)) Error

INTO
Salesforce..Contact_Update

FROM 
Salesforce..Contact

WHERE 
HasOptedOutOfEmail = 'false' and Email in
	(
	SELECT Email
	FROM SalesforceReporting..WiredSuppressions
	)

-- Upload to Salesforce	

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Contact_Update'

DROP TABLE Salesforce..Contact_Update