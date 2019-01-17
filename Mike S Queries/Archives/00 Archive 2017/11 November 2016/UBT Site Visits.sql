
SELECT 
	an.Id,
	an.BlockTitle,
	an.QuestionTitle,
	CASE WHEN an.Answer = '00000000-0000-0000-0000-000000000000' THEN 'Not Answered' ELSE an.Answer END as Answer,
	CASE WHEN an.Answer = 'No' THEN 1 ELSE 0 END as No,
	CASE WHEN an.Answer = 'N/A' THEN 1 ELSE 0 END as NA,
	CASE WHEN an.Answer = 'Yes' THEN 1 ELSE 0 END as Yes,
	CASE WHEN an.Answer = '00000000-0000-0000-0000-000000000000' THEN 1 ELSE 0 END as NotAnswered,
	c.FullName as Company,
	cast(sv.InspectionDate as date) as InspectionDate,
	u.FirstName + ' ' + u.SecondName as CreatedBy
FROM 
	[AtlasSiteVisitData]..[SiteVisitBlockQuestionAnswer] an INNER JOIN 
	SiteVisits sv on sv.Id = an.SiteVisitId INNER JOIN 
	Shared.Users u on sv.UserId = u.Id INNER JOIN 
	Citation.Companies c on c.Id = sv.CompanyId
WHERE
	c.ClientAffiliationId = '4AFF0342-FBB3-40CC-A847-4F64ED3DE5D6'