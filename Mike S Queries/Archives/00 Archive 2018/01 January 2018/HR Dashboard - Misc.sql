Use CitationAtlas
GO

-- Basic Details

SELECT *
FROM
(
SELECT e.Id,
case when PATINDEX('%[0-9]%', EmployeeNumber) = 0 then 0 else CONVERT(int, ISNULL(SUBSTRING(EmployeeNumber, PATINDEX('%[0-9]%', EmployeeNumber), LEN(CONVERT(VarChar, EmployeeNumber))),0)) end EmployeeNo, 
NINumber, 
FirstName, 
Surname, 
d.Name Department, 
e.[Type] EmployeeType, 
DOB,
DATEDIFF(YEAR, DOB, GETDATE()) EmployeeAge,
a.Town City, 
a.Postcode,
e.Email,
CONVERT(date, j.StartDate) StartDate, 
CONVERT(date, j.FinishDate) FinishDate, 
CONVERT(VarChar, FLOOR(DATEDIFF(month, j.StartDate, ISNULL(j.FinishDate, GETDATE())))/12)
 + ' Year(s) ' + 
CONVERT(VarChar, 
DATEDIFF(month, j.StartDate, ISNULL(j.FinishDate, GETDATE())) - (FLOOR(DATEDIFF(month, j.StartDate, ISNULL(j.FinishDate, GETDATE())))/12)*12)
+ ' Month(s)' Tenure
FROM
dbo.Employees e
left outer join dbo.Jobs j ON e.Id = j.EmployeeId
left outer join dbo.EmployeeJobHistory ejh ON e.Id = ejh.employeeId
left outer join dbo.EmployeePayrollDetails epd ON e.Id = epd.employeeId
left outer join dbo.Departments d ON j.DepartmentId = d.Id
left outer join dbo.Addresses a ON e.AddressId = a.Id
WHERE e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA'
) detail
ORDER BY DATEDIFF(MONTH, StartDate, ISNULL(FinishDate, GETDATE())) desc

SELECT COUNT(distinct e.Id), SUM(case when epd.Id is not null then 1 else 0 end)
FROM
dbo.Employees e
left outer join dbo.EmployeePayrollDetails epd ON e.Id = epd.employeeId
WHERE e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA'

-- TypeId
--1 = Holiday
--2 = Absence

-- HolidayUnitType
--1 = Day
--2 = Hour

-- Holidays and Absenses

SELECT 
*, 
Holidays_Days * DayHours + Holidays_Hours As Holidays_HoursTotal,
CONVERT(decimal(18,2), (Holidays_Days * DayHours + Holidays_Hours) / DayHours) As Holidays_DaysTotal,
HolidayEntitlement_Hours - Holidays_Days * DayHours + Holidays_Hours As Holidays_HoursRemaining,
CONVERT(decimal(18,2), (HolidayEntitlement_Hours - Holidays_Days * DayHours + Holidays_Hours)/DayHours) As Holidays_DaysRemaining,
Case when Absenses_Days > 14 then 'Long Term' else 'Short Term' end AbsenseTerm
FROM
(
SELECT 
CONVERT(VarChar, e.FirstName) FirstName, CONVERT(VarChar, e.Surname) Surname, 
CONVERT(int, j.HolidayEntitlement) HolidayEntitlement_Days,
CONVERT(decimal(18,2), DATEDIFF(Minute,[StartTimeHours],[EndTimeHours]))/60 DayHours,
CONVERT(decimal(18,2), CONVERT(decimal(18,2), DATEDIFF(Minute,[StartTimeHours],[EndTimeHours]))/60) * CONVERT(int, j.HolidayEntitlement) HolidayEntitlement_Hours,
SUM(Case when ma.HolidayUnitType = 1 and ma.TypeId = 1 then NoOfUnits else 0 end) Holidays_Days, 
SUM(Case when ma.HolidayUnitType = 2 and ma.TypeId = 1 then NoOfUnits else 0 end) Holidays_Hours, 
SUM(Case when ma.HolidayUnitType = 1 and ma.TypeId = 2 then NoOfUnits else 0 end) Absenses_Days,
SUM(Case when ma.HolidayUnitType = 2 and ma.TypeId = 2 then NoOfUnits else 0 end) Absenses_Hours
FROM dbo.Employees e
inner join dbo.MyAbsences ma ON e.Id = ma.EmployeeId
inner join dbo.EmployeePayrollDetails epd ON e.Id = epd.EmployeeId
inner join dbo.Jobs j ON e.Id = j.EmployeeId
inner join dbo.EmployeeHolidaySettings ehs ON e.CompanyId = ehs.CompanyId
inner join CitationAtlas.Shared.AbsenseStatus abst ON ma.StatusId = abst.Id
WHERE e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' and YEAR(ma.StartDate) = YEAR(GETDATE()) and abst.Name = 'Approved'
GROUP BY
CONVERT(VarChar, e.FirstName), 
CONVERT(VarChar, e.Surname), 
CONVERT(int, j.HolidayEntitlement), 
CONVERT(decimal(18,2), DATEDIFF(Minute,[StartTimeHours],[EndTimeHours]))/60,
CONVERT(decimal(18,2), CONVERT(decimal(18,2), DATEDIFF(Minute,[StartTimeHours],[EndTimeHours]))/60) * CONVERT(int, j.HolidayEntitlement)
) detail

ORDER BY Absenses_Days desc

-- Lateness Summary

SELECT 
CONVERT(VarChar, d.Name) Dept,
CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname) EmployeeName, 
YEAR(abd.FromHour) [Year],
DATENAME(dw, abd.FromHour) [DayName],
--abt.TypeName AbsenseType,
--ast.Name SubType,
case when LEN(CONVERT(VarChar, SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))/60)) = 1 
then 
'0'+ CONVERT(VarChar, SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))/60)
else
CONVERT(VarChar, SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))/60)
end
 + ':' + 
case when LEN(CONVERT(VarChar, SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))-(SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))/60) * 60)) = 1
then
'0' + CONVERT(VarChar, SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))-(SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))/60) * 60)
else
CONVERT(VarChar, SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))-(SUM(DATEDIFF(minute,abd.FromHour,abd.ToHour))/60) * 60)
end TimeOff,
SUM(abd.NoOfUnits) TimeOffUnits,
COUNT(abd.Id) NoOfLates
FROM [dbo].[MyAbsenceDetails] abd
inner join MyAbsences ab ON abd.MyAbsenceId = ab.Id
inner join Employees e ON ab.EmployeeId = e.Id
inner join EmployeeHolidaySettings ehs ON abd.CompanyId = ehs.CompanyId
inner join Jobs j ON e.Id = j.EmployeeId
inner join Departments d ON j.DepartmentId = d.Id
inner join AbsenceType abt ON ab.AbsenTypeId = abt.Id
inner join AbsenceSubType ast ON ab.SubtypeId = ast.Id
WHERE abd.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' and ab.TypeId = 2 and ast.Name = 'Lateness'
GROUP BY CONVERT(VarChar, d.Name), CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname), YEAR(abd.FromHour), DATENAME(dw, abd.FromHour)
ORDER BY [Year], EmployeeName

-- Lateness

IF OBJECT_ID ('tempdb..#Lateness') IS NOT NULL
	BEGIN
		DROP TABLE #Lateness
	END

SELECT 
CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname) EmployeeName, 
CONVERT(date, abd.FromHour) LateDate,
DATEDIFF(minute,abd.FromHour, abd.ToHour) MinutesLate,
case when LEN(CONVERT(VarChar, DATEDIFF(minute,abd.FromHour,abd.ToHour)/60)) = 1 
then 
'0'+ CONVERT(VarChar, DATEDIFF(minute,abd.FromHour,abd.ToHour)/60)
else
CONVERT(VarChar, DATEDIFF(minute,abd.FromHour,abd.ToHour)/60)
end
 + ':' + 
case when LEN(CONVERT(VarChar, DATEDIFF(minute,abd.FromHour,abd.ToHour) - (DATEDIFF(minute,abd.FromHour,abd.ToHour)/60) * 60)) = 1
then
'0' + CONVERT(VarChar, DATEDIFF(minute,abd.FromHour,abd.ToHour) - ((DATEDIFF(minute,abd.FromHour,abd.ToHour)/60) * 60))
else
CONVERT(VarChar, DATEDIFF(minute,abd.FromHour,abd.ToHour) - ((DATEDIFF(minute,abd.FromHour,abd.ToHour)/60) * 60))
end TimeOff
INTO #Lateness
FROM [dbo].[MyAbsenceDetails] abd
inner join MyAbsences ab ON abd.MyAbsenceId = ab.Id
inner join Employees e ON ab.EmployeeId = e.Id
inner join EmployeeHolidaySettings ehs ON abd.CompanyId = ehs.CompanyId
inner join AbsenceType abt ON ab.AbsenTypeId = abt.Id
inner join AbsenceSubType ast ON ab.SubtypeId = ast.Id
WHERE abd.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' and ab.TypeId = 2 and ast.Name = 'Lateness'
ORDER BY EmployeeName, LateDate

SELECT * FROM #Lateness

-- Employee Turnover

IF OBJECT_ID('tempdb..#Turnover') IS NOT NULL
	BEGIN
		DROP TABLE #Turnover
	END

SELECT j.Id, d.Name Department, StartDate, TerminationDate FinishDate
INTO #Turnover
FROM dbo.Employees e
left outer join dbo.Jobs j ON e.Id = j.EmployeeId
left outer join dbo.EmployeeEvent ee ON e.Id = ee.EmployeeId
left outer join dbo.Departments d ON j.DepartmentId = d.Id
WHERE e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' and (YEAR(StartDate) = YEAR(GETDATE()) or YEAR(TerminationDate) = YEAR(GETDATE()))

-- Year Calendar Builder

IF OBJECT_ID ('tempdb..#ThisYear') IS NOT NULL
	BEGIN
		DROP TABLE #ThisYear
	END
	
IF OBJECT_ID ('tempdb..#YearAbsenses') IS NOT NULL
	BEGIN
		DROP TABLE #YearAbsenses
	END

CREATE TABLE #ThisYear (
ID int identity,
ThisDate date
)

DECLARE @ThisDate date
SET @ThisDate = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)
--DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1) AS EndOfYear

WHILE @ThisDate <= DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1)
	BEGIN
	
		INSERT INTO #ThisYear (ThisDate) VALUES (@ThisDate)
		
		SET @ThisDate = DATEADD(day,1,@ThisDate)
	
	END

-- Absenses This Year

	SELECT ty.ThisDate, COUNT(ma.Id) Absenses
	FROM #ThisYear ty
	left outer join MyAbsences ma ON ty.ThisDate between ma.StartDate and ma.EndDate
										and ma.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' 
										and ma.TypeId = 2
	GROUP BY ty.ThisDate
	ORDER BY ty.ThisDate
	
-- Lates This Year

	SELECT ty.ThisDate, COUNT(l.EmployeeName) Lates, ISNULL(SUM(l.MinutesLate), 0) TotalMinutes
	FROM #ThisYear ty
	left outer join #Lateness l ON ty.ThisDate = l.LateDate
	GROUP BY ty.ThisDate
	ORDER BY ty.ThisDate
	
-- Turnover This Year

	SELECT 
	ty.ThisDate, 
	ISNULL(CONVERT(VarChar, st.Department), CONVERT(VarChar, ft.Department)) Department,
	SUM(case when YEAR(st.StartDate) = YEAR(GETDATE()) then 1 else 0 end) Starters,
	SUM(case when YEAR(ft.FinishDate) = YEAR(GETDATE()) then 1 else 0 end) Leavers,
	ISNULL(d.Active, d2.Active) Active
	FROM #ThisYear ty
	left outer join #Turnover st ON ty.ThisDate = CONVERT(date, st.StartDate)
	left outer join #Turnover ft On ty.ThisDate = CONVERT(date, ft.FinishDate)
	left outer join	(
					SELECT CONVERT(VarChar, d.Name) Name, COUNT(e.Id) Active
					FROM Employees e
					inner join Jobs j ON e.Id = j.EmployeeId
					inner join Departments d ON j.DepartmentId = d.Id
					WHERE IsLeaver = 0 and e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' 
					GROUP BY CONVERT(VarChar, d.Name)
					) d ON CONVERT(VarChar, ft.Department) = d.Name
	left outer join	(
					SELECT CONVERT(VarChar, d.Name) Name, COUNT(e.Id) Active
					FROM Employees e
					inner join Jobs j ON e.Id = j.EmployeeId
					inner join Departments d ON j.DepartmentId = d.Id
					WHERE IsLeaver = 0 and e.CompanyId = '89504E36-557B-4691-8F1B-7E86F9CF95EA' 
					GROUP BY CONVERT(VarChar, d.Name)
					) d2 ON CONVERT(VarChar, st.Department) = d2.Name
	GROUP BY ty.ThisDate, ISNULL(CONVERT(VarChar, st.Department), CONVERT(VarChar, ft.Department)), ISNULL(d.Active, d2.Active)
	ORDER BY ty.ThisDate, Department
	
-- List Employees On Holiday This Year

	SELECT 
	ty.ThisDate, 
	STUFF	(
				(
                     SELECT ', ' + CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname)
                     FROM 
                           CitationAtlas..MyAbsences ma
                           inner join CitationAtlas..Employees e ON ma.EmployeeId = e.Id
                           inner join CitationAtlas.Shared.AbsenseStatus abst ON ma.StatusId = abst.Id
                     WHERE
                           CONVERT(date, ty.ThisDate) between StartDate and EndDate and TypeId = 1 and abst.Name = 'Approved'
                     ORDER BY CONVERT(VarChar, e.FirstName) + ' ' + CONVERT(VarChar, e.Surname)
                     FOR XML PATH ('')
				), 1, 1, ''
			) EmployeesOnHoliday
	FROM #ThisYear ty
	GROUP BY ty.ThisDate
	ORDER BY ThisDate

	-- Holidays - Employee Names
	
	SELECT TypeName, SubType, StartDate, EndDate, TypeId, HolidayUnitType, NoOfUnits, Approver, Canceller
	FROM
	(
	SELECT abst.Name Status, CONVERT(VarChar, e.Firstname) + ' ' + CONVERT(VarChar, e.Surname) EmployeeName, ma.*, abt.TypeName, ast.Name SubType,
	CONVERT(VarChar, ape.Firstname) + ' ' + CONVERT(VarChar, ape.Surname) Approver,
	CONVERT(VarChar, cae.Firstname) + ' ' + CONVERT(VarChar, cae.Surname) Canceller
	FROM CitationAtlas..MyAbsences ma
	left outer join CitationAtlas..Employees e ON ma.EmployeeId = e.Id
	left outer join CitationAtlas..AbsenceType abt ON ma.AbsenTypeId = abt.Id
	left outer join CitationAtlas..AbsenceSubType ast ON ma.SubtypeId = ast.Id
	left outer join CitationAtlas..Employees ape ON ma.ApprovedBy = ape.Id
	left outer join CitationAtlas..Employees cae ON ma.CancelledBy = cae.Id
	left outer join CitationAtlas.Shared.AbsenseStatus abst ON ma.StatusId = abst.Id
	) detail
	WHERE 
	EmployeeName = 'Daniel Cox' 
	and TypeId = 1 
	--and Approver is not null 
	and YEAR(StartDate) = YEAR(GETDATE())
	and Status = 'Approved'