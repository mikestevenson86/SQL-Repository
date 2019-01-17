SELECT *
FROM
(
	SELECT
	cc.Id, a.Id SFDC_AccountId, cc.FullName CompanyName, COUNT(t.SubjectId) Logins, COUNT(atp.Id) CompletedTraining, 
	ISNULL(ra.Assessments, 0) Assessments, ISNULL(ha.Holidays, 0) Holidays, ISNULL(ha.Absenses, 0) Absenses, ISNULL(dd.DistributedDocs, 0) DistributedDocs
	FROM
	[database].shorthorn.dbo.cit_sh_clients cl
	left outer join Salesforce..Account a ON cl.clientId = a.Shorthorn_Id__c
	left outer join AtlasStaging.Citation.Companies cc ON LEFT(a.Id, 15) collate latin1_general_CS_AS = LEFT(cc.SalesforceAccountID, 15) collate latin1_general_CS_AS
	left outer join AtlasStaging.Shared.Users u ON cc.Id = u.CompanyId
	left outer join AtlasStaging.[identity].tokens t ON CONVERT(VarChar, u.Email) = CONVERT(VarChar, t.SubjectId) and YEAR(Expiry) = 2018
	left outer join Salesforce..Contact c ON a.Id = c.AccountId
	left outer join Salesforce..AtlasTrainingPlan__c atp ON c.Id = atp.Contact__c and YEAR(TrainingDate__c) = 2018 and TrainingStatus__c = 'Complete'
	left outer join AtlasStaging..UBT_RAs_2018 ra ON cc.Id = ra.CompanyId
	left outer join AtlasStaging..UBT_HAs_2018 ha ON cc.Id = ha.CompanyId
	left outer join AtlasStaging..UBT_DDs_2018 dd ON cc.Id = dd.CompanyId
	WHERE cl.clienttype = 'UBT'
	GROUP BY cc.Id, a.Id, cc.FullName, ISNULL(ra.Assessments, 0), ISNULL(ha.Holidays, 0), ISNULL(ha.Absenses, 0), ISNULL(dd.DistributedDocs, 0) 
) detail
WHERE Logins > 0 or Assessments > 0 or Holidays > 0 or DistributedDocs > 0 or Absenses > 0 or CompletedTraining > 0
ORDER BY CompanyName