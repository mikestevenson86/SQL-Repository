SELECT Consultant, [WeekDay], AVG(Advice) [Average Daily Advice]
FROM
(
SELECT u.fullname Consultant, CONVERT(date, dateOfCall) CallDate, COUNT(ad.adviceId) Advice, 'Monday' [WeekDay]
FROM [Shorthorn].[dbo].[cit_sh_advice] ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID and u.enabled = 1
WHERE DATENAME(DW,CONVERT(date, dateOfCall)) = 'Monday' and YEAR(dateOfCall) = 2017
GROUP BY u.FullName, CONVERT(date, dateOfCall)
UNION
SELECT u.fullname Consultant, CONVERT(date, dateOfCall) CallDate, COUNT(ad.adviceId) Advice, 'Tuesday' [WeekDay]
FROM [Shorthorn].[dbo].[cit_sh_advice] ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID and u.enabled = 1
WHERE DATENAME(DW,CONVERT(date, dateOfCall)) = 'Tuesday' and YEAR(dateOfCall) = 2017
GROUP BY u.FullName, CONVERT(date, dateOfCall)
UNION
SELECT u.fullname Consultant, CONVERT(date, dateOfCall) CallDate, COUNT(ad.adviceId) Advice, 'Wednesday' [WeekDay]
FROM [Shorthorn].[dbo].[cit_sh_advice] ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID and u.enabled = 1
WHERE DATENAME(DW,CONVERT(date, dateOfCall)) = 'Wednesday' and YEAR(dateOfCall) = 2017
GROUP BY u.FullName, CONVERT(date, dateOfCall)
UNION
SELECT u.fullname Consultant, CONVERT(date, dateOfCall) CallDate, COUNT(ad.adviceId) Advice, 'Thursday' [WeekDay]
FROM [Shorthorn].[dbo].[cit_sh_advice] ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID and u.enabled = 1
WHERE DATENAME(DW,CONVERT(date, dateOfCall)) = 'Thursday' and YEAR(dateOfCall) = 2017
GROUP BY u.FullName, CONVERT(date, dateOfCall)
UNION
SELECT u.fullname Consultant, CONVERT(date, dateOfCall) CallDate, COUNT(ad.adviceId) Advice, 'Friday' [WeekDay]
FROM [Shorthorn].[dbo].[cit_sh_advice] ad
inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID and u.enabled = 1
WHERE DATENAME(DW,CONVERT(date, dateOfCall)) = 'Friday' and YEAR(dateOfCall) = 2017
GROUP BY u.FullName, CONVERT(date, dateOfCall)
) detail
GROUP BY Consultant, [WeekDay]
ORDER BY Consultant, 
case when [WeekDay] = 'Monday' then 1
when [WeekDay] = 'Tuesday' then 2
when [WeekDay] = 'Wednesday' then 3
when [WeekDay] = 'Thursday' then 4 else 5 end