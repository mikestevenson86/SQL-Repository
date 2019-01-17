SELECT ISNULL(af.Sector, sc.[Description 2]), COUNT(seqno)
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id,15) collate latin1_general_CS_AS
left outer join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join SalesforceReporting..SIC2 sc ON l.SIC2007_Code2__c = sc.[SIC Code 2]
WHERE act_date > '2014-10-08' and call_type in (0,2,4)
GROUP BY ISNULL(af.Sector, sc.[Description 2])

SELECT ISNULL(af.Sector, sc.[Description 2]), COUNT(l.Id)
FROM Salesforce..Lead l
left outer join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
left outer join SalesforceReporting..SIC2 sc ON l.SIC2007_Code2__c = sc.[SIC Code 2]
WHERE Date_Made__c > '2014-10-08' and MADE_Criteria__c in ('Outbound - 1','Outbound - 2','Outbound - 4','Inbound -  1','Inbound -  2','Inbound -  4','Seminars - Appointment')
GROUP BY ISNULL(af.Sector, sc.[Description 2])