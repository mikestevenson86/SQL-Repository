SELECT 
s.Name SiteName, 
d.Name DeptName, 
COUNT(e.Id) Employees, 
SUM(j.HoursAWeek) [Hours per Week],
SUM(j.HoursAWeek)/40 [FTE Equivilent],
SUM(sal.Pay) [Department Salary]
FROM Atlas_UAT.dbo.Sites s
inner join Atlas_UAT.Citation.Companies c ON s.companyId = c.Id
inner join Atlas_UAT.dbo.Departments d ON c.Id = d.CompanyId
inner join Atlas_UAT.dbo.Jobs j ON d.Id = j.DepartmentId and c.Id = j.CompanyId
inner join Atlas_UAT.dbo.Employees e ON j.EmployeeId = e.Id
inner join Atlas_UAT.dbo.EmployeeSalaryHistory sal ON e.Id = sal.employeeId and IsCurrentSalary = 1
WHERE c.FullName like '%Rosie Trading%'
GROUP BY s.Name, d.Name
ORDER BY s.Name, d.Name