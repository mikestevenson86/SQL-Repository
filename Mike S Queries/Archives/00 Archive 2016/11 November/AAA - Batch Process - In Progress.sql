INSERT INTO
SalesforceReporting..Batch
(
[BatchID],[Run],[Source],[CreatedDate],[InitialCount],[Updates],[Inserts],[Deletes],[ActualUpdates],[ActualInserts],[ActualDeletes],
[Dupe_Lead],[Dupe_Toxic],[Dupe_Account],[Dupe_Site],[ToxicSIC],[ToxicSIC_Events],[BadCompany_Exact],[BadCompany_Near],[BadCompany_Events],[BadDomain],
[BadDomain_NHS],[BadPosition_Events],[BadSector_Events],[Status]
)

SELECT 
[BatchID],
[Run]+1 Run,
[Source],
GETDATE() [CreatedDate],
[InitialCount],
(SELECT COUNT(*) Updates FROM MarketLocation..ML_Amends_Filtered) Updates,
(SELECT COUNT(*) Updates FROM MarketLocation..ML_News_Filtered)[Inserts],
[Deletes],
[ActualUpdates],
[ActualInserts],
[ActualDeletes],
[Dupe_Lead],
[Dupe_Toxic],
[Dupe_Account],
[Dupe_Site],
[ToxicSIC],
[ToxicSIC_Events],
[BadCompany_Exact],
[BadCompany_Near],
[BadCompany_Events],
[BadDomain],
[BadDomain_NHS],
[BadPosition_Events],
[BadSector_Events],
'In Progress' [Status]

FROM SalesforceReporting..Batch

WHERE 
Run = 
	(
	SELECT MAX(Run)
	FROM SalesforceReporting..Batch
	WHERE Source like 'ML_%' and BatchID =
		(
		SELECT MAX(BatchID)
		FROM SalesforceReporting..Batch
		WHERE Source like 'ML_%'
		)
	)
and 
BatchID = 
	(
	SELECT MAX(BatchID)
	FROM SalesforceReporting..Batch
	WHERE Source like 'ML_%'
	)