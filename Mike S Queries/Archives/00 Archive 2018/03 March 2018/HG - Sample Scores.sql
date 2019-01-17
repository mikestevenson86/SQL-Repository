SELECT 
hg.*, 
case when a.IsActive__c = 'true' then 'Yes' else 'No' end Client,
l.Status, 
l.Suspended_Closed_Reason__c [Suspended/Closed Reason], 
l.CitationSector__c [Citation Sector], 
l.FT_Employees__c FTE, 
l.IsTPS__c [Is TPS?], 
l.TEXT_BDM__c BDM, 
rt.Name [Record Type], 
l.Phone 
FROM SalesforceReporting..HG_DataScoring_SampleScores hg
left outer join Salesforce..Lead l ON hg.Lead_ID = l.Id
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join Salesforce..Account a ON l.ConvertedAccountId = a.Id