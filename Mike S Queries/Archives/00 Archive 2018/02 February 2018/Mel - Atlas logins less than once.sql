SELECT sc.CitationSector, detail.*
FROM
(
	SELECT 
	a.Id, a.Name, COUNT(t.SubjectId) logins

	FROM 
	Salesforce..Account a
	left outer join Salesforce..ATLAS_User__c au ON LEFT(a.Id, 15) collate latin1_general_CS_AS = LEFT(au.Account__c, 15) collate latin1_general_CS_AS
	left outer join [SYNCHUB].[SynchHubReporting].[identity].tokens t ON CONVERT(VarChar, au.Email__c) = CONVERT(VarChar, t.SubjectId)

	WHERE
	( 
		a.Cluster_Start_Date__c >= '2015-11-09'
		or
		MigrationStatus__c = 'Complete'
	)
	and
	(
		Profile__c like '%Service Owner%'
		or
		Profile__c like '%HR Manager%'
		or
		Profile__c like '%HS Co-ordinator%'
	)
	and
	Test_Account__c = 'false'
	and
	Citation_Client__c = 'true'
	and 
	a.Cluster_End_Date__c > CONVERT(date, GETDATE())
	and
	au.IsActive__c = 'true'
	and
	ISNULL(CONVERT(VarChar, Email__c), '') <> ''

	GROUP BY
	a.Id, a.Name
) detail
inner join Salesforce..Account a ON detail.Id = a.Id
inner join SalesforceReporting..SIC2007Codes sc ON a.SIC2007_Code3__c = sc.SIC3_Number