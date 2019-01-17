-- ( D.parentid = '4E9C4B2B-7F3F-9907-B556-83FA3A5988BF' or  D.id = '4E9C4B2B-7F3F-9907-B556-83FA3A5988BF')
-- Jade Donohue - 85FF9028-0527-41DF-96BE-F3FAA0647839
DECLARE @Month date
DECLARE @FTE decimal(18,2)

SET @Month = DATEADD(dd,-1,DATEADD(mm,DATEDIFF(mm,0,GETDATE())+1,0))
SET @FTE = 37.5

IF OBJECT_ID('tempdb..#Pay') IS NOT NULL
	BEGIN
		DROP TABLE #Pay
	END

IF OBJECT_ID('tempdb..#MonthEmployees') IS NOT NULL
	BEGIN
		DROP TABLE #MonthEmployees
	END
	
IF OBJECT_ID('tempdb..#MonthEmployeesOperations') IS NOT NULL
	BEGIN
		DROP TABLE #MonthEmployeesOperations
	END

IF OBJECT_ID('tempdb..#MonthEmployeesBackOffice') IS NOT NULL
	BEGIN
		DROP TABLE #MonthEmployeesBackOffice
	END

IF OBJECT_ID('tempdb..#UltimateDept') IS NOT NULL
	BEGIN
		DROP TABLE #UltimateDept
	END
	
IF OBJECT_ID('tempdb..#Depts') IS NOT NULL
	BEGIN
		DROP TABLE #Depts
	END

IF OBJECT_ID('tempdb..#All') IS NOT NULL
	BEGIN
		DROP TABLE #All
	END

IF OBJECT_ID('tempdb..#LastDept') IS NOT NULL
	BEGIN
		DROP TABLE #LastDept
	END
	
CREATE TABLE #UltimateDept
(
DeptId uniqueidentifier,
DeptName NVarChar(255),
ParentId uniqueidentifier,
ParentName NVarChar(255),
[Level] int,
UltimateId uniqueidentifier,
UltimateName NVarChar(255)
)

DECLARE @Dept uniqueidentifier
DECLARE @ParDept uniqueidentifier
DECLARE @UltDept uniqueidentifier
DECLARE @ThisRecord int
DECLARE @Level int

SET @ThisRecord = 1
SET @Level = 1

	SELECT ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY (SELECT NULL)) Id, Id DepartmentId, ParentId
	INTO #Depts
	FROM dbo.Departments
	WHERE CompanyId = '945011E7-84E0-4F41-B139-69B5B974AB95'
	
	WHILE @ThisRecord < (SELECT MAX(Id) FROM #Depts)
	BEGIN
	
		SET @Dept = (SELECT DepartmentId FROM #Depts WHERE Id = @ThisRecord)
		SET @ParDept = (SELECT ParentId FROM #Depts WHERE Id = @ThisRecord)
		SET @UltDept = (SELECT ParentId FROM #Depts WHERE DepartmentID = @ParDept)
		
			WHILE @UltDept is not null
			BEGIN
			
				SET @UltDept = (SELECT ParentId FROM #Depts WHERE DepartmentID = @ParDept)
				
				INSERT INTO #UltimateDept 
				(
				DeptId, DeptName, ParentId, ParentName, [Level], UltimateId, UltimateName
				) 
				VALUES 
				(
				@Dept, (SELECT Name FROM dbo.Departments WHERE Id = @Dept), 
				@ParDept, (SELECT Name FROM dbo.Departments WHERE Id = @ParDept),
				@Level, 
				@UltDept, (SELECT Name FROM dbo.Departments WHERE Id = @UltDept)
				)
				
				SET @ParDept = @UltDept
				
				SET @Level = @Level + 1
				
			END

		SET @Level = 1
		SET @ThisRecord = @ThisRecord + 1
		
	END

SELECT 
DeptId, DeptName, ParentId, ParentName, Level

INTO
#LastDept
 
FROM 
#UltimateDept 

WHERE UltimateName is null and ParentId is not null and ParentId <> '945011E7-84E0-4F41-B139-69B5B974AB95'

ORDER BY 
DeptId, Level

SELECT esh.EmployeeId, Pay, IsCurrentSalary
INTO #Pay
FROM
EmployeeSalaryHistory esh
inner join (
SELECT EmployeeId, MAX(StartDate) StartDate
FROM EmployeeSalaryHistory
WHERE CompanyId = '945011E7-84E0-4F41-B139-69B5B974AB95'
GROUP BY EmployeeId
) detail ON esh.EmployeeID = detail.EmployeeId and esh.StartDate = detail.StartDate

-- Prepare Valid Employees List in Provided Month
SELECT 
EmployeeID

INTO 
#MonthEmployees 

FROM
(
	SELECT 
	e.Id EmployeeID
	 
	FROM 
	Employees e
	left outer join Jobs j on j.EmployeeId = e.Id

	WHERE 
	e.CompanyId = '945011E7-84E0-4F41-B139-69B5B974AB95'  
	and 
	CAST(j.StartDate as date) <= CAST(@Month  as date)
	and
	CAST(e.CreatedOn as date)  <= CAST(@Month  as date)
	and 
	IsLeaver = 0

	UNION

	--- Leavers List -- Added this union in Last month report as per new requirement from stuart
	SELECT 
	e.Id EmployeeID 

	FROM 
	Employees e
	left outer join Jobs j on j.EmployeeId = e.Id
	left outer join EmployeeEvent ee on ee.EmployeeId = e.Id

	WHERE 
	e.Companyid ='945011E7-84E0-4F41-B139-69B5B974AB95'  
	and 
	CAST(j.StartDate as date) <= CAST(@Month  as date)
	and
	CAST(e.CreatedOn as date)  <= CAST(@Month  as date)
	and 
	IsLeaver = 1 
	and 
	CAST(ee.TerminationDate as date) > CAST(@Month  as date)
) a
GROUP BY 
EmployeeId

--- Get Counts
SELECT 
COUNT(*) TotalHeadCount, 
COUNT(me.EmployeeId)/@FTE HoursPerWeek, 
SUM(case when IsCurrentSalary = 1 then Pay else 0 end) AnnualCost
INTO #All
FROM #MonthEmployees me
left outer join #Pay esh ON me.EmployeeId = esh.EmployeeId

----- Operations -----------

-- Prepare Valid Employees List for Operations with in Provided Month
SELECT 
ParentName
, EmployeeID
  
INTO 
#MonthEmployeesOperations 

FROM
(
	SELECT 
	e.Id EmployeeID
	, ud.ParentName
	 
	FROM 
	Employees e
	INNER JOIN Jobs j on j.EmployeeId = e.Id 
    INNER JOIN departments d on d.Id = j.DepartmentId
    LEFT OUTER JOIN #LastDept ud ON d.Id = ud.DeptId

	WHERE 
	e.CompanyId ='945011E7-84E0-4F41-B139-69B5B974AB95'  
	and 
	CAST(j.StartDate as date) <= CAST(@Month  as date)
	and
	CAST(e.CreatedOn as date)  <= CAST(@Month  as date)
	and 
	IsLeaver = 0

	UNION

	--- Leavers List -- Added this union in Last month report as per new requirement from stuart
	SELECT 
	e.Id EmployeeID
	, ud.ParentName

	FROM 
	Employees e
	INNER JOIN Jobs j on j.EmployeeId = e.Id
    INNER JOIN departments d on d.Id = j.DepartmentId
    INNER JOIN EmployeeEvent ee on ee.EmployeeId = e.Id   
    LEFT OUTER JOIN #LastDept ud ON d.Id = ud.DeptId

	WHERE 
	e.Companyid ='945011E7-84E0-4F41-B139-69B5B974AB95'  
	and 
	CAST(j.startdate as date) <= CAST(@Month  as date)
	and
	CAST(e.createdon as date) <= CAST(@Month  as date) 
	and 
	IsLeaver = 1 
	and 
	CAST(ee.TerminationDate as date) > CAST(@Month  as date)
) a
GROUP BY
ParentName
, EmployeeID 

-- Get Counts
SELECT 'All' [Head Department], *
FROM #All
UNION
SELECT 
ParentName,
COUNT(me.EmployeeId),
COUNT(me.EmployeeId)/@FTE HoursPerWeek, 
ISNULL(SUM(Pay),0) AnnualCost
FROM #MonthEmployeesOperations me
left outer join #Pay esh ON me.EmployeeId = esh.EmployeeId and IsCurrentSalary = 1
GROUP BY ParentName