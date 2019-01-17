SELECT 
c2.SFDC_Id Id, CONVERT(NVARCHAR(MAX),
'=CONCATENATE("CQC Provider Link - http://www.cqc.org.uk/provider/' + c2.CQCProviderId + '", CHAR(10), CHAR(10), "' +
'Number of Sites - ' + CONVERT(VarChar, Number_Of_Sites__c) + '", CHAR(10) , CHAR(10), "' +
STUFF
(
      (
             SELECT '", CHAR(10), "' + c1.Company + ' ' + c1.PostCode 
             FROM 
                   SalesforceReporting..CQCHeadNotes c1
             WHERE
                   c2.SFDC_Id = c1.SFDC_Id
                   and HeadOffice <> 'TRUE'
             ORDER BY c1.Company + ' - ' + c1.PostCode
             FOR XML PATH ('')
      ), 1, 1, ''
)) + '")' Session_Notes__c

FROM
SalesforceReporting..CQCHeadNotes c2
inner join Salesforce..Lead l ON c2.SFDC_Id = l.Id
WHERE 
HeadOffice <> 'TRUE'
GROUP BY 
c2.SFDC_Id, c2.CQCProviderId, CONVERT(VarChar, Number_Of_Sites__c) 