SELECT 
CONVERT(VarChar, d.Name) DeptName,
CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname) EmployeeName, 
case when ma.TypeId = 1 then 'Holiday' else 'Absense' end [Type],
case when ma.HolidayUnitType = 1 then 'Day' else 'Hour' end UnitDuration,
ma.NoOfUnits,
ma.StartDate, 
ma.EndDate,
ab.Name Approval, 
abst.TypeName [Absence Type], 
ast.Name [Absense SubType]

FROM 
dbo.Employees e
Left outer join dbo.MyAbsences ma ON e.Id = ma.EmployeeId
Left outer join dbo.EmployeePayrollDetails epd ON e.Id = epd.EmployeeId
Left outer join dbo.Jobs j ON e.Id = j.EmployeeId
Left outer join dbo.EmployeeHolidaySettings ehs ON e.CompanyId = ehs.CompanyId
Left outer join CitationAtlas.Shared.AbsenseStatus ab ON ma.StatusId = ab.Id
Left outer join AbsenceType abst ON ma.AbsenTypeId = abst.Id
Left outer join AbsenceSubType ast ON ma.SubtypeId = ast.Id
left outer join dbo.Departments d ON j.DepartmentId = d.Id

WHERE 
e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' 
and
ma.StartDate >= '2017-01-01'
ORDER BY 
CONVERT(VarChar, d.Name),
CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname), 
ma.StartDate