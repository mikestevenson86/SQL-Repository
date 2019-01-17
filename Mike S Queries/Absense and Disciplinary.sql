SELECT c.FullName CompanyName, c.TotalEmployees, emp.FirstName + ' ' + emp.Surname EmployeeName, COUNT(ma.Id) Absense
FROM [synchub].SynchHubReporting.dbo.MyAbsences ma
inner join [synchub].SynchHubReporting.Citation.Companies c ON ma.CompanyId = c.Id
inner join [synchub].SynchHubReporting.dbo.Employees emp ON ma.EmployeeId = emp.Id
inner join [synchub].SynchHubReporting.dbo.AbsenceType at ON ma.AbsenTypeId = at.Id
--inner join SynchHubReporting..AbsenceSubType ast ON ma.SubtypeId = ast.Id
WHERE ma.TypeId = 2 and YEAR(StartDate) = 2018 and TypeName <> 'TOIL'
GROUP BY c.FullName, c.TotalEmployees, emp.FirstName + ' ' + emp.Surname, ma.EmployeeId
HAVING COUNT(ma.Id) > 3

SELECT cl.clientId, cl.companyName, cl.totEmployees, COUNT(ad.adviceId) Advice_2018
FROM [database].shorthorn.dbo.cit_sh_advice ad
inner join [database].shorthorn.dbo.cit_sh_sites s ON ad.siteId = s.siteId
inner join [database].shorthorn.dbo.cit_sh_clients cl ON s.clientId = cl.clientId
WHERE
YEAR(dateOfCall) = 2018
and
(
	ad.disProc = 1 or ad.disAppeal = 1 or ad.grievance = 1
)
GROUP BY cl.clientId, cl.companyName, cl.totEmployees