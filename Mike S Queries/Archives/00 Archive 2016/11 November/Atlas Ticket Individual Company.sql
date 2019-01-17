SELECT hdi.IssueDate, StartDate, ResolvedDate, Subject,hdu.Email, hdc.Name Category, hds.Name Status
FROM [Incidents].[hdIssues] hdi
inner join [Incidents].[hdUsers] hdu ON hdi.UserID = hdu.UserID
inner join [Incidents].[hdCategories] hdc ON hdi.CategoryID = hdc.CategoryID
inner join [Incidents].[hdStatus] hds ON hdi.StatusID = hds.StatusID
WHERE CompanyID = 2414