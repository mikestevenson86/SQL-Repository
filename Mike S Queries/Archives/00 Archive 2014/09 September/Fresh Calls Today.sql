SELECT u.Name BDM, WhoId
FROM
(
SELECT WhoId, ActivityDate, ROW_NUMBER () OVER (PARTITION BY WhoId ORDER BY ActivityDate) CallAttempt
FROM Salesforce..Task
WHERE Subject = 'Outbound Call'
) detail
inner join Salesforce..Lead l On detail.WhoId collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u ON l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE CallAttempt = 1 and CONVERT(date, ActivityDate) = CONVERT(date, GETDATE())
ORDER BY BDM 
SELECT u.Name BDM, COUNT(l.id) Prospects
FROM
(
SELECT WhoId, ActivityDate, ROW_NUMBER () OVER (PARTITION BY WhoId ORDER BY ActivityDate) CallAttempt
FROM Salesforce..Task
WHERE Subject = 'Outbound Call'
) detail
inner join Salesforce..Lead l On detail.WhoId collate latin1_general_CS_AS = l.Id collate latin1_general_CS_AS
inner join Salesforce..[User] u ON l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE CallAttempt = 1 and CONVERT(date, ActivityDate) = CONVERT(date, GETDATE())
GROUP BY u.Name
