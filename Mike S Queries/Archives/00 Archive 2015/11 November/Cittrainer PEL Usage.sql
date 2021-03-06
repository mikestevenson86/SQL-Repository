/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      ct.coName,
      u.forename + ' ' + u.surname empName,
      c.title,
      r.startDate,
      r.progress,
      r.completionDate
  FROM [CitationMain].[dbo].[citation_trainer_GroupCourseUserMapping] r
  left outer join CitationMain..citation_trainer_Users u ON r.userID = u.userID
  left outer join CitationMain..citation_trainer_Courses c ON r.courseID = c.courseID
  left outer join CitationMain..citation_trainer_CourseGroups cg ON r.groupID = cg.groupID
  left outer join CitationMain..citation_CompanyTable2 ct ON cg.companyID = ct.[uid]
  WHERE startDate >= '2016-01-01' and c.subGroupID = 2
  ORDER BY coName, empName, title, startDate
  
  SELECT 
      ct.coName,
      COUNT(distinct(u.forename + ' ' + u.surname)) Employees,
      SUM(case when r.startDate is not null then 1 else 0 end) [Total Started],
      SUM(case when r.completionDate is not null then 1 else 0 end) [Total Completed]
  FROM [CitationMain].[dbo].[citation_trainer_GroupCourseUserMapping] r
  left outer join CitationMain..citation_trainer_Users u ON r.userID = u.userID
  left outer join CitationMain..citation_trainer_Courses c ON r.courseID = c.courseID
  left outer join CitationMain..citation_trainer_CourseGroups cg ON r.groupID = cg.groupID
  left outer join CitationMain..citation_CompanyTable2 ct ON cg.companyID = ct.[uid]
  WHERE startDate >= '2016-01-01' and c.subGroupID = 2
  GROUP BY coName
  ORDER BY coName