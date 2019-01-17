DECLARE @FromDate as Date
DECLARE @ToDate as Date

SET @FromDate = '2017-04-01'
SET @ToDate = '2017-04-30'

	SELECT 
	em.Id,
	case when abt.Id is null then 'Holiday' else abt.TypeName end AbsenceType,
	MAX(ehs.HolidayEntitlement) EntitlementDays, 
	SUM(case when ab.StartDate >= @FromDate and ab.EndDate <= @ToDate then NoOfDays else 0 end) TakenDays,
	MAX(ehs.HolidayEntitlement)
	 - 
	SUM(NoOfDays)RemainingDays,
	SUM(NoOfDays) AllTaken,
	DATEDIFF(hh,MAX(StartTimeHours), MAX(EndTimeHours)) - MAX(LunchDuration) WorkingDay
	
	INTO
	#Days
	
	FROM 
	[MyAbsences] ab
	inner join Employees em ON ab.EmployeeId = em.Id
	inner join [EmployeeHolidaySettings] ehs ON ab.CompanyId = ehs.CompanyId
	left outer join AbsenceType abt ON ab.AbsenTypeID = abt.Id
	
	WHERE  
	YEAR(ab.StartDate) = YEAR(@FromDate) 
	and 
	YEAR(ab.EndDate) = YEAR(@ToDate) 
	and 
	ApprovedBy is not null 
	and 
	DeclinedBy is null 
	and 
	IsHour = 0
	
	GROUP BY 
	em.Id,
	case when abt.Id is null then 'Holiday' else abt.TypeName end
		
	SELECT 
	em.Id, 
	case when abt.Id is null then 'Holiday' else abt.TypeName end AbsenceType,
	CONVERT(int, MAX(ehs.HolidayEntitlement) * (DATEDIFF(hh,MAX(StartTimeHours), MAX(EndTimeHours)) - MAX(LunchDuration))) EntitlementHours,
	SUM(case when ab.StartDate >= @FromDate and ab.EndDate <= @ToDate then NoOfUnits else 0 end) TakenHours,
	CONVERT(int, MAX(ehs.HolidayEntitlement) * (DATEDIFF(hh,MAX(StartTimeHours), MAX(EndTimeHours)) - MAX(LunchDuration)))
	 - 
	SUM(NoOfUnits) RemainingHours,
	SUM(NoOfUnits) AllTaken,
	DATEDIFF(hh,MAX(StartTimeHours), MAX(EndTimeHours)) - MAX(LunchDuration) WorkingDay
	
	INTO
	#Hours
	
	FROM 
	[MyAbsences] ab
	inner join Employees em ON ab.EmployeeId = em.Id
	inner join [EmployeeHolidaySettings] ehs ON ab.CompanyId = ehs.CompanyId
	left outer join AbsenceType abt ON ab.AbsenTypeID = abt.Id
	
	WHERE 
	YEAR(ab.StartDate) = YEAR(@FromDate) 
	and 
	YEAR(ab.EndDate) = YEAR(@ToDate) 
	and 
	ApprovedBy is not null 
	and 
	DeclinedBy is null 
	and 
	IsHour = 1
	
	GROUP BY 
	em.Id,
	case when abt.Id is null then 'Holiday' else abt.TypeName end
	
	SELECT 
	case when em.KnownAs is null or em.KnownAs = '' then em.FirstName else em.KnownAs end + ' ' + em.Surname Employee,
	ISNULL(da.AbsenceType, hr.AbsenceType) AbsenceType,
	cm.FullName Company,   
	s.Name [Site], 
	d.Name Department,
	case when em.IsEmployee = 1 then 'Active' else 'InActive' end EmployeeStatus,
	CONVERT(int,case when da.EntitlementDays is null then hr.EntitlementHours/hr.WorkingDay else da.EntitlementDays end) EntitlementDays,
	CONVERT(int,case when hr.EntitlementHours is null then da.EntitlementDays * da.WorkingDay else hr.EntitlementHours end) EntitlementHours,
	case when da.TakenDays is null then hr.TakenHours/hr.WorkingDay else da.TakenDays + ISNULL(hr.TakenHours/hr.WorkingDay,0) end TakenDays,
	case when hr.TakenHours is null then (da.TakenDays * da.WorkingDay) else hr.TakenHours + ISNULL((da.TakenDays * da.WorkingDay),0) end TakenHours,
	case when da.RemainingDays is null then (hr.EntitlementHours/hr.WorkingDay) - (hr.AllTaken/hr.WorkingDay)
	else da.RemainingDays - ISNULL(hr.AllTaken/hr.WorkingDay,0) end RemainingDays,
	case when hr.RemainingHours is null then (da.EntitlementDays * da.WorkingDay) - (da.AllTaken * da.WorkingDay) 
	else hr.RemainingHours - ISNULL(da.AllTaken * da.WorkingDay,0) end RemainingHours,
	ISNULL(da.AllTaken,0) + ISNULL(hr.AllTaken / hr.WorkingDay,0) AllTakenDays,
	ISNULL(hr.AllTaken,0) + ISNULL(da.AllTaken * da.WorkingDay,0) AllTakenHours
	
	FROM 
	Employees em
	inner join Citation.Companies cm ON em.CompanyId = cm.Id
	inner join Jobs j ON em.Id = j.EmployeeId
	inner join Departments d ON j.DepartmentId = d.Id
	inner join Sites s ON j.SiteId = s.Id
	left outer join #Days da ON em.Id = da.Id
	left outer join #Hours hr ON em.Id = hr.Id
	
	WHERE
	da.Id is not null or hr.Id is not null
	
	ORDER BY
	Company,
	[Site],
	Employee
	
	DROP TABLE #Days
	DROP TABLE #Hours