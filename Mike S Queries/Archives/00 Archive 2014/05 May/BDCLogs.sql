SELECT u.Id,u.Name,u.Email
INTO #ActiveBDC
FROM Salesforce..[User] u
inner join Salesforce..[Profile] pr on u.ProfileId collate latin1_general_CS_AS = pr.Id collate latin1_general_CS_AS
WHERE IsActive = 'TRUE' and pr.Name = 'Citation BDC'

SELECT '1' a, COUNT(u.id) bdcs
INTO #ABDCCount
FROM Salesforce..[User] u
inner join Salesforce..[Profile] pr on u.ProfileId collate latin1_general_CS_AS = pr.Id collate latin1_general_CS_AS
WHERE IsActive = 'TRUE' and pr.Name = 'Citation BDC'

SELECT CONVERT(date,logintime) LogTime, abc.bdcs Active,COUNT(distinct(name)) LoggedIn
FROM Salesforce..LoginHistory loh
inner join #ActiveBDC bdc on loh.UserId collate latin1_general_CS_AS = bdc.Id collate latin1_general_CS_AS
join #ABDCCount abc on '1' = abc.a
WHERE CONVERT(date,loh.LoginTime) >= CONVERT(date,GETDATE()-30)
GROUP by CONVERT(date,logintime), abc.bdcs

SELECT 
CONVERT(date,act_date) CallDate,
tsr.sname Agent,
SUM(case when ch.time_connect > 180 then 1 else 0 end) Made,
SUM (case when ch.time_acw > 180 then 1 else 0 end) ACW,
SUM (case when ch.[status] in ('AP','S') then 1 else 0 end) Appts
FROM Enterprise..call_history ch
inner join Enterprise..tsrmaster tsr on ch.tsr = tsr.tsr
GROUP BY CONVERT(date,act_date),tsr.sname
ORDER BY CONVERT(date,act_date),tsr.sname

DROP TABLE #ActiveBDC
DROP TABLE #ABDCCount

