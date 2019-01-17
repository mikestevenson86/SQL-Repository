IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
BEGIN
	DROP TABLE Salesforce..Lead_Update
END


SELECT 
CAST(ID as NChar(18)) Id, 
'No' IsTPS__c,
CAST('' as NVarChar(255)) Error

INTO
Salesforce..Lead_Update

FROM 
Salesforce..Lead

WHERE 
ISNULL(IsTPS__c,'') in ('','NULL','NUL','0','NoNo') 
and 
Status <> 'Approved'

UNION

SELECT 
CAST(ID as NChar(18)) Id, 
'Yes' IsTPS__c,
CAST('' as NVarChar(255)) Error

FROM 
Salesforce..Lead

WHERE 
ISNULL(IsTPS__c,'') in ('Y','1') 
and 
Status <> 'Approved'

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'