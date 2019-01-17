SELECT em.fName FirstName, em.sName Surname, ab.reason, CONVERT(date,dtFrom)DateFrom, CONVERT(date,dtTo)DateTo, Comments, ROUND(noDays,2), 

(DATEDIFF(dd, dtFrom, dtTo) +1)
  -(DATEDIFF(wk, dtFrom, dtTo) * 2)
  -(CASE WHEN DATENAME(dw, dtFrom) = 'Sunday' THEN 1 ELSE 0 END) 
  -(CASE WHEN DATENAME(dw, dtTo) = 'Saturday' THEN 1 ELSE 0 END) ActualDays,
  em.employmentType,
  dt.compDept
FROM CitationMain..cit_tfl_absence ab
inner join CitationMain..cit_tfl_Employee em ON ab.empUID = em.empUID
left outer join CitationMain..cit_tfl_JobHistory j ON em.empUID = j.empUID and j.dtFinished is null
left outer join CitationMain..CRM_dept dt ON j.dept = dt.dID
WHERE 
dtFrom > '2013-01-01' 
and 
em.compID = 5537 
and 
(DATEDIFF(dd, dtFrom, dtTo) +1) -(DATEDIFF(wk, dtFrom, dtTo) * 2) -(CASE WHEN DATENAME(dw, dtFrom) = 'Sunday' THEN 1 ELSE 0 END) -(CASE WHEN DATENAME(dw, dtTo) = 'Saturday' THEN 1 ELSE 0 END) <> noDays 
ORDER BY DateFrom

SELECT em.fName FirstName, em.sName SurName, dtFrom DateFrom, dtTo DateTo, noDays, reason, dt.compDept
FROM CitationMain..cit_tfl_absence ab
inner join CitationMain..cit_tfl_Employee em ON ab.empUID = em.empUID
left outer join CitationMain..cit_tfl_JobHistory j ON em.empUID = j.empUID and j.dtFinished is null
left outer join CitationMain..CRM_dept dt ON j.dept = dt.dID
WHERE noDays > 30 and em.compID = 5537 and ab.dtFrom > '2013-01-01'