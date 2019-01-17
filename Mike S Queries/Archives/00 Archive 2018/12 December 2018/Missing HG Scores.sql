exec Salesforce..SF_Refresh 'Salesforce','Lead'

-- Query

SELECT
l.Id,
CONVERT(decimal(18,6), sc.ELTV) HG_Score__c
FROM
Salesforce..Lead l
inner join HGLeadScoring..Scores sc ON l.Id = CONVERT(VarChar, sc.Lead_Id)
WHERE
CONVERT(decimal(18,6), l.HG_Score__c) <> CONVERT(decimal(18,6), sc.ELTV)
and
l.Status <> 'Approved'
and
l.IsConverted = 'false'

-- Job

/*
IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END

SELECT
CAST(l.Id as NCHAR(18)) Id,
CONVERT(decimal(18,6), sc.ELTV) HG_Score__c,
CAST('' as NVarChar(255)) Error
INTO
Salesforce..Lead_Update
FROM
Salesforce..Lead l
inner join HGLeadScoring..Scores sc ON l.Id = CONVERT(VarChar, sc.Lead_Id)
WHERE
CONVERT(decimal(18,6), l.HG_Score__c) <> CONVERT(decimal(18,6), sc.ELTV)
and
l.Status <> 'Approved'
and
l.IsConverted = 'false'

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'
*/