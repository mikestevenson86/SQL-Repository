DECLARE @LOCAL_StartDate as Date
DECLARE @LOCAL_EndDate as Date

SET @LOCAL_StartDate = '2018-03-01'
SET @LOCAL_EndDate = '2018-03-19'

SELECT
t.Id TaskId,
l.Id LeadId,
t.NVMConnect__DialList__c ListId,
l.CitationSector__c CitationSector,
l.TEXT_BDM__c BDM,
ccm.Name CCM,
bdc.Name BDC,
l.FT_Employees__c FTE,
t.CallType,
l.Date_Made__c DateMade,
l.MADE_Criteria__c MADECriteria

FROM
Salesforce..Task t
left outer join Salesforce..Lead l ON t.WhoId = l.Id
left outer join Salesforce..[User] bdc ON t.OwnerId = bdc.Id
left outer join Salesforce..[User] ccm ON bdc.ManagerId = ccm.Id

WHERE
t.CallType in ('Inbound','Outbound')
and
t.CallObject is not null
and
CONVERT(date, t.ActivityDate) between @LOCAL_StartDate and @LOCAL_EndDate