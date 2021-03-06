SELECT compID, COUNT(*) emps
INTO #Emps
FROM CitationMain..cit_tfl_Employee
--WHERE [disabled] = 0
GROUP BY compID

SELECT [user_id], COUNT(*) ra
INTO #RA
FROM CitationMain..citation_assessments
GROUP BY [user_id]

SELECT companyID, COUNT(*) passes
INTO #Train
FROM CitationMain..citation_trainer_GroupCourseUserMapping tc
inner join CitationMain..citation_trainer_Users u ON tc.userID = u.userID
WHERE progress = 'p' or completionDate is not null
GROUP BY companyID

SELECT companyID, MAX(startDate) LastCourse
INTO #LastTrain
FROM CitationMain..citation_trainer_GroupCourseUserMapping tc
inner join CitationMain..citation_trainer_Users u ON tc.userID = u.userID
GROUP BY companyID

SELECT compID, 
SUM(case when DATEPART(month, whenUsed) = 1 then 1 else 0 end) January,
SUM(case when DATEPART(month, whenUsed) = 2 then 1 else 0 end) February,
SUM(case when DATEPART(month, whenUsed) = 3 then 1 else 0 end) March,
SUM(case when DATEPART(month, whenUsed) = 4 then 1 else 0 end) April,
SUM(case when DATEPART(month, whenUsed) = 5 then 1 else 0 end) May,
SUM(case when DATEPART(month, whenUsed) = 6 then 1 else 0 end) June,
SUM(case when DATEPART(month, whenUsed) = 7 then 1 else 0 end) July,
SUM(case when DATEPART(month, whenUsed) = 8 then 1 else 0 end) August,
SUM(case when DATEPART(month, whenUsed) = 9 then 1 else 0 end) September,
SUM(case when DATEPART(month, whenUsed) = 10 then 1 else 0 end) October,
SUM(case when DATEPART(month, whenUsed) = 11 then 1 else 0 end) November,
SUM(case when DATEPART(month, whenUsed) = 12 then 1 else 0 end) December
INTO #Logins
FROM CitationMain..citation_appUsage ap
WHERE whenUsed >= '2015-01-01' and whenUsed < '2016-01-01'
GROUP BY compID

SELECT 
ct.uid CitWebID, 
ct.coName Company, 
em.emps [Employees], 
ra.ra [Risk Assessments], 
tr.passes [Courses Passed], 
MAX(CONVERT(datetime, whenUsed)) [Last Login], 
lt.LastCourse [Last Course Date], 
lo.January,
lo.February,
lo.March,
lo.April,
lo.May,
lo.June,
lo.July,
lo.August,
lo.September,
lo.October,
lo.November,
lo.December
FROM CitationMain..citation_CompanyTable2 ct
left outer join CitationMain..citation_appUsage ap ON ct.uid = ap.compID
left outer join #Emps em ON ct.uid = em.compID
left outer join #RA ra ON ct.uid = ra.[user_id]
left outer join #Train tr ON ct.uid = tr.companyID
left outer join #LastTrain lt ON ct.uid = lt.companyID
left outer join #Logins lo ON ct.uid = lo.compID
WHERE ct.status = 1
GROUP BY ct.uid, ct.coName, em.emps, ra.ra, tr.passes, lt.LastCourse,lo.January,lo.February,lo.March,lo.April,lo.May,lo.June,lo.July,lo.August,lo.September,lo.October,lo.November,lo.December

DROP TABLE #Emps
DROP TABLE #RA
DROP TABLE #Train
DROP TABLE #LastTrain
DROP TABLE #Logins