SELECT
Id [SFDC Id],
Company [Company Name],
Name [Contact],
Position__c [Contact Position],
Street+' '+City+' '+PostalCode [Address],
Phone,
Email,
case when IsTPS__c is not null then 'Yes' else 'No' end TPS,
[Status],
SIC2007_Code3__c [SIC Code 3],
s3.[Description]
FROM
Salesforce..Lead l
left outer join SalesforceReporting..SIC3 s3 ON l.SIC2007_Code3__c = s3.[SIC Code 3]
WHERE 
SIC2007_Code3__c in ('85200','85310','85320','85422','85590')
ORDER BY
SIC2007_Code3__c