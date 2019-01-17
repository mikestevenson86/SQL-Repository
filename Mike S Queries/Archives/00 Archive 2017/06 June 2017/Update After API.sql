exec Salesforce..SF_Refresh 'Salesforce','User'

DECLARE @Value as VarChar(20)

SELECT @Value = DiallerFK__c FROM Salesforce..[User] WHERE Name = 'Salesforce Admin'

IF CONVERT(VarChar,GETDATE(),103) + '_ML' = @Value
BEGIN
	exec SalesforceReporting..tsk_UpdateAffinity
	exec SalesforceReporting..tsk_UpdateCountry
	exec SalesforceReporting..tsk_UpdateLeadSICFlag
	exec SalesforceReporting..tsk_UpdateSICCodes
	exec SalesforceReporting..tsk_UpdateSector

IF OBJECT_ID('Salesforce..User_Update') IS NOT NULL
BEGIN
	DROP TABLE Salesforce..User_Update
END

SELECT
CAST (Id as NCHAR(18)) Id,
'' DiallerFK__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..User_Update

FROM
Salesforce..[User]

WHERE 
Name = 'Salesforce Admin'

exec Salesforce..SF_BulkOps 'Update:batchisize(5)','Salesforce','User_Update'

END