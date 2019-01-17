IF OBJECT_ID('tempdb..#UltimateDept') IS NOT NULL
	BEGIN
		DROP TABLE #UltimateDept
	END
	
IF OBJECT_ID('tempdb..#Depts') IS NOT NULL
	BEGIN
		DROP TABLE #Depts
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
	WHERE CompanyId = '04D33DA5-CA77-4CCD-826D-867422D81AA1'
	
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
 
FROM 
#UltimateDept 

WHERE UltimateName is null and ParentId is not null and ParentId <> '04D33DA5-CA77-4CCD-826D-867422D81AA1'

ORDER BY 
DeptId, Level