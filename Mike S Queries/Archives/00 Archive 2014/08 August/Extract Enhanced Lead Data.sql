SELECT le.*
FROM SalesforceReporting..[LeadEnhanceGradeA-Improved] le
inner join Salesforce..Lead l ON le.Id collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
WHERE l.[Status] = 'open' and le.SIC2007_Code__c is not null and le.FT_Employees__c between 6 and 225