IF OBJECT_ID('tempdb..#Averages') IS NOT NULL
	BEGIN
		DROP TABLE #Averages
	END

IF OBJECT_ID('tempdb..#ConHours') IS NOT NULL
	BEGIN
		DROP TABLE #ConHours
	END

SELECT 
Consultant, 
AVG([8am]) [8-9],
AVG([9am]) [9-10],
AVG([10am]) [10-11],
AVG([11am]) [11-12],
AVG([12pm]) [12-1],
AVG([1pm]) [1-2],
AVG([2pm]) [2-3],
AVG([3pm]) [3-4],
AVG([4pm]) [4-5],
AVG([5pm]) [5-6],
AVG([6pm]) [6-7]

INTO
#Averages

FROM
(
	SELECT 
	u.FullName Consultant,
	CONVERT(date, dateOfCall) CallDate,
	SUM(case when CONVERT(time,ad.DateOfCall) between '08:00:00.000' and '09:00:00.000' then 1 else 0 end) [8am],
	SUM(case when CONVERT(time,ad.DateOfCall) between '09:00:00.000' and '10:00:00.000' then 1 else 0 end) [9am],
	SUM(case when CONVERT(time,ad.DateOfCall) between '10:00:00.000' and '11:00:00.000' then 1 else 0 end) [10am],
	SUM(case when CONVERT(time,ad.DateOfCall) between '11:00:00.000' and '12:00:00.000' then 1 else 0 end) [11am],
	SUM(case when CONVERT(time,ad.DateOfCall) between '12:00:00.000' and '13:00:00.000' then 1 else 0 end) [12pm],
	SUM(case when CONVERT(time,ad.DateOfCall) between '13:00:00.000' and '14:00:00.000' then 1 else 0 end) [1pm],
	SUM(case when CONVERT(time,ad.DateOfCall) between '14:00:00.000' and '15:00:00.000' then 1 else 0 end) [2pm],
	SUM(case when CONVERT(time,ad.DateOfCall) between '15:00:00.000' and '16:00:00.000' then 1 else 0 end) [3pm],
	SUM(case when CONVERT(time,ad.DateOfCall) between '16:00:00.000' and '17:00:00.000' then 1 else 0 end) [4pm],
	SUM(case when CONVERT(time,ad.DateOfCall) between '17:00:00.000' and '18:00:00.000' then 1 else 0 end) [5pm],
	SUM(case when CONVERT(time,ad.DateOfCall) between '18:00:00.000' and '19:00:00.000' then 1 else 0 end) [6pm]
	FROM Shorthorn..cit_sh_advice ad
	inner join Shorthorn..cit_sh_users u ON ad.consultant = u.userID
	WHERE CONVERT(date, DateOfCall) >= DATEADD(Month, -1, GETDATE())
	GROUP BY u.FullName, CONVERT(date, dateofCall)
) detail
GROUP BY Consultant

CREATE TABLE #ConHours
(
Consultant VarChar(255),
[Hour] VarChar(20),
Value int
)

INSERT INTO #ConHours SELECT Consultant, '[8am - 9am]', [8-9]  FROM #Averages WHERE [8-9] > 0
INSERT INTO #ConHours SELECT Consultant, '[9am - 10am]', [9-10] FROM #Averages WHERE [9-10] > 0
INSERT INTO #ConHours SELECT Consultant, '[10am - 11am]', [10-11] FROM #Averages WHERE [10-11] > 0
INSERT INTO #ConHours SELECT Consultant, '[11am - 12pm]', [11-12] FROM #Averages WHERE [11-12] > 0
INSERT INTO #ConHours SELECT Consultant, '[12pm - 1pm]', [12-1] FROM #Averages WHERE [12-1] > 0
INSERT INTO #ConHours SELECT Consultant, '[1pm - 2pm]', [1-2] FROM #Averages WHERE [2-3] > 0
INSERT INTO #ConHours SELECT Consultant, '[2pm - 3pm]', [2-3] FROM #Averages WHERE [2-3] > 0
INSERT INTO #ConHours SELECT Consultant, '[3pm - 4pm]', [3-4] FROM #Averages WHERE [3-4] > 0
INSERT INTO #ConHours SELECT Consultant, '[4pm - 5pm]', [4-5] FROM #Averages WHERE [4-5] > 0
INSERT INTO #ConHours SELECT Consultant, '[5pm - 6pm]', [5-6] FROM #Averages WHERE [5-6] > 0
INSERT INTO #ConHours SELECT Consultant, '[6pm - 7pm]', [6-7] FROM #Averages WHERE [6-7] > 0

SELECT
ch.Consultant,
[Hour],
Value CallsTaken

FROM
#ConHours ch
inner join (
			SELECT Consultant, MAX(Value) MaxValue
			FROM #ConHours
			GROUP BY Consultant
			) mv ON ch.Consultant = mv.Consultant and ch.Value = mv.MaxValue

ORDER BY
Consultant