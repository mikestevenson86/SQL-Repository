SELECT l.id, af.Partner, l.SIC2007_Code3__c, l.SIC2007_Description3__c, l.Affinity_Industry_Type__c
FROM Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af on l.SIC2007_Code3__c = af.[SIC Code]
WHERE l.Affinity_Cold__c <> 'Affinity - Key' and l.IsConverted is null

SELECT l.id, af.Partner, l.SIC2007_Code3__c, l.SIC2007_Description3__c, l.Affinity_Industry_Type__c
FROM Salesforce..Lead l
left outer join SalesforceReporting..AffinitySICCodes af on l.SIC2007_Code3__c = af.[SIC Code]
WHERE l.Affinity_Cold__c = 'Affinity - Key' and af.[SIC Code] is null and l.SIC2007_Code3__c is not null and l.IsConverted is null
