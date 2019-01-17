SELECT Id, Company, Affinity_Cold__c, SIC2007_Description__c, SIC2007_Description2__c, SIC2007_Description3__C, Status, Suspended_Closed_Reason__c
FROM Salesforce..Lead
WHERE SIC2007_Code3__c in
(
SELECT [SIC Code]
FROM SalesforceReporting..AffinitySICCodes
)
and
Suspended_Closed_Reason__c like '%Tier 4%'