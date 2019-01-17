SELECT *
FROM SalesforceReporting..QMS_Account_August2017
WHERE CitationClient is null and LastYearsOpps is null and ID not in
(
SELECT QMS_Id
FROM SalesforceReporting..QMSJoins
)

SELECT l.Id, Status, Suspended_Closed_Reason__c, bdc.Name BDC, bdm.Name BDM, Source__c [Source], LeadSource ProspectSource,
rt.Name
FROM Salesforce..Lead l
left outer join SalesforceReporting..QMSJoins qms ON l.Id = qms.Lead_Id
left outer join Salesforce..[User] bdc ON l.BDC__c = bdc.ID
left outer join Salesforce..[User] bdm ON l.OwnerId = bdm.Id
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
WHERE qms.Lead_Id is not null