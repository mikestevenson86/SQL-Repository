-- Find existing contacts that share Atlas User details and update Contact ID on Atlas Users table

IF OBJECT_ID('Salesforce..ATLAS_User__c_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..ATLAS_User__c_Update
	END

SELECT 
CAST(au.Id as NCHAR(18)) Id,
nc.Id Contact__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Atlas_User__c_Update

FROM 
Salesforce..Atlas_User__c au
left outer join Salesforce..Contact c ON au.Contact__c = c.Id
left outer join Salesforce..Contact nc ON CONVERT(VarChar,au.FirstName__c)+CONVERT(VarChar,au.SecondName__c)+CONVERT(VarChar,au.Account__c) 
										= nc.FirstName+nc.LastName+nc.AccountId
WHERE 
c.Id is null 
and 
nc.Id is not null

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Atlas_User__c_Update'

-- Find Atlas Users without Contact ID that fit profile criteria

IF OBJECT_ID('Salesforce..Contact_Load') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Contact_Load
	END

SELECT 
CAST('' as NCHAR(18)) Id, 
au.Account__c AccountId,
au.FirstName__c FirstName,
au.SecondName__c LastName,
au.Email__c Email,
au.Id AtlasUserID,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Contact_Load

FROM 
Salesforce..Atlas_User__c au
left outer join Salesforce..Contact c ON au.Contact__c = c.Id

WHERE C.ID is null and 
(
Profile__c like '%service owner%' or
Profile__c like '%HS co-ordinator%' or
Profile__c like '%MR Manager%'
)

exec Salesforce..SF_BulkOps 'Insert:batchsize(10)','Salesforce','Contact_Load'

-- Take contact IDs from Contact_Load table and write back to Atlas Users table

IF OBJECT_ID('Salesforce..ATLAS_User__c_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..ATLAS_User__c_Update
	END

SELECT
CAST(cl.AtlasUserID as NCHAR(18)) Id,
cl.ID Contact__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Atlas_User__c_Update

FROM
Salesforce..Contact_Load cl

WHERE
Error = 'Operation Successful.'

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Atlas_User__c_Update'