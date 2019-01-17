SELECT
c.Name [Campaign Name],
c.Id [Campaign ID],
l.Id [Salesforce ID],
l.Phone,
l.Salutation,
l.FirstName,
l.LastName,
l.[Status],
CONVERT(date,l.Status_Changed_Date__c) [Status Changed Date],
CONVERT(datetime,l.Callback_Date_Time__c) [Callback Date and Time],
bdc.Name BDC,
l.CitationSector__c Sector,
l.Affinity_Cold__c [Affinity/Cold],
l.Affinity_Industry_Type__c [Affinity Industry Type],
CONVERT(date,l.LastActivityDate)[Last Activity Date],
bdm.Name BDM,
c.noblesys__listId__c [Noble List],
CONVERT(date,l.Date_Made__c) [Date Made],
e.Subject,
e.ActivityDate [Due Date],
u.Name [Assigned To],
e.CallDisposition [Call Result],
l.SIC2007_Code__c [SIC Code]
FROM
Salesforce..Lead l
left outer join Salesforce..Task e ON l.Id collate latin1_general_CS_AS = e.WhoId collate latin1_general_CS_AS
inner join Salesforce..CampaignMember cm ON l.Id collate latin1_general_CS_AS = cm.LeadId collate latin1_general_CS_AS
inner join Salesforce..Campaign c ON cm.CampaignId collate latin1_general_CS_AS = c.Id collate latin1_general_CS_AS
inner join Salesforce..[User] bdc ON l.BDC__c collate latin1_general_CS_AS = bdc.Id collate latin1_general_CS_AS
inner join Salesforce..[User] bdm ON l.OwnerId collate latin1_general_CS_AS = bdm.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u ON e.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE DATEPART(week,e.CreatedDate) = DATEPART(WEEK,GETDATE())-1 and Subject = 'Outbound Call'
ORDER BY e.CreatedDate