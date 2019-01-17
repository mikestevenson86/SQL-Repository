IF OBJECT_ID('Salesforce..Lead_Update') IS NOT NULL
	BEGIN
		DROP TABLE Salesforce..Lead_Update
	END

SELECT CAST(Id as NCHAR(18)) ID, NULL Phone, CAST('' as NVarChar(255)) Error
INTO Salesforce..Lead_Update
FROM Salesforce..Lead
WHERE Status not in ('Approved','Data Quality','Pended')
and (Phone = '0' or Phone = '00' or Phone = '0FALSE' or Phone = '00FALSE')
UNION
select CAST(Id as NCHAR(18)) ID, NULL Phone, CAST('' as NVarChar(255)) Error
from Salesforce..Lead
where RecordTypeId = '012D0000000NbJsIAK' and status not in ('Approved', 'Pended','Data Quality')  and Phone is not null and
(
	(Phone like '01%' and LEN(REPLACE(Phone,' ','')) <> 11 and LEN(REPLACE(Phone,' ','')) <> 10)
	or
	(Phone like '02%' and LEN(REPLACE(Phone,' ','')) <> 11 and LEN(REPLACE(Phone,' ','')) <> 10)
	or
	(Phone like '03%' and LEN(REPLACE(Phone,' ','')) <> 11)
	or
	(Phone like '05%' and LEN(REPLACE(Phone,' ','')) <> 11 and LEN(REPLACE(Phone,' ','')) <> 10)
	or
	(Phone like '07%' and LEN(REPLACE(Phone,' ','')) <> 11)
	or
	(Phone like '0800%' and LEN(REPLACE(Phone,' ','')) <> 11 and LEN(REPLACE(Phone,' ','')) <> 10 and LEN(REPLACE(Phone,' ','')) <> 8)
	or
	(Phone like '0845%' and LEN(REPLACE(Phone,' ','')) <> 11 and LEN(REPLACE(Phone,' ','')) <> 8)
	or
	(Phone like '0844%' and LEN(REPLACE(Phone,' ','')) <> 11)
	or
	(Phone like '0870%' and LEN(REPLACE(Phone,' ','')) <> 11)
	or
	(Phone like '0560%' and LEN(REPLACE(Phone,' ','')) <> 11)
)

exec Salesforce..SF_BulkOps 'Update:batchsize(100)','Salesforce','Lead_Update'