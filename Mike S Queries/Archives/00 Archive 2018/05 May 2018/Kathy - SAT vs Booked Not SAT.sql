IF OBJECT_ID('tempdb..#DatesThisYear') IS NOT NULL
	BEGIN
		DROP TABLE #DatesThisYear
	END

IF OBJECT_ID('tempdb..#SAT') IS NOT NULL
	BEGIN
		DROP TABLE #SAT
	END
	
IF OBJECT_ID('tempdb..#BNS') IS NOT NULL
	BEGIN
		DROP TABLE #BNS
	END

IF OBJECT_ID('tempdb..#Results') IS NOT NULL
	BEGIN
		DROP TABLE #Results
	END

CREATE TABLE #DatesThisYear
(
WeekNo int
)

DECLARE @Wno as int
SET @Wno = 1

WHILE @Wno < 54
	BEGIN
		INSERT INTO #DatesThisYear (WeekNo) VALUES (@Wno)
		SET @Wno = @Wno + 1
	END

-- Build SAT

SELECT DATEPART(week, firstVisit) WeekNo, COUNT(dealId) SAT
INTO #SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(firstVisit) = 2018
GROUP BY DATEPART(week, firstVisit)

INSERT INTO #SAT
SELECT DATEPART(week, secVisit) WeekNo, COUNT(dealId) SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(secVisit) = 2018
GROUP BY DATEPART(week, secVisit)

INSERT INTO #SAT
SELECT DATEPART(week, thirVisit) WeekNo, COUNT(dealId) SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(thirVisit) = 2018
GROUP BY DATEPART(week, thirVisit)

INSERT INTO #SAT
SELECT DATEPART(week, fourthVisit) WeekNo, COUNT(dealId) SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(fourthVisit) = 2018
GROUP BY DATEPART(week, fourthVisit)

INSERT INTO #SAT
SELECT DATEPART(week, fifthVisit) WeekNo, COUNT(dealId) SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(fifthVisit) = 2018
GROUP BY DATEPART(week, fifthVisit)

INSERT INTO #SAT
SELECT DATEPART(week, sixthVisit) WeekNo, COUNT(dealId) SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(sixthVisit) = 2018
GROUP BY DATEPART(week, sixthVisit)

INSERT INTO #SAT
SELECT DATEPART(week, dateInstalled) WeekNo, COUNT(dealId) SAT
FROM Shorthorn..cit_sh_dealsHS
WHERE YEAR(dateInstalled) = 2018
GROUP BY DATEPART(week, dateInstalled)

-- Build Booked Not SAT

SELECT DATEPART(week, visit1book) WeekNo, COUNT(dealId) BookedNotSAT
INTO #BNS
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(visit1book) = 2018 and firstVisit is null
GROUP BY DATEPART(week, visit1book)

INSERT INTO #BNS
SELECT DATEPART(week, visit2book) WeekNo, COUNT(dealId) BookedNotSAT
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(visit2book) = 2018 and secVisit is null
GROUP BY DATEPART(week, visit2book)

INSERT INTO #BNS
SELECT DATEPART(week, visit3book) WeekNo, COUNT(dealId) BookedNotSAT
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(visit3book) = 2018 and thirVisit is null
GROUP BY DATEPART(week, visit3book)

INSERT INTO #BNS
SELECT DATEPART(week, visit4book) WeekNo, COUNT(dealId) BookedNotSAT
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(visit4book) = 2018 and fourthVisit is null
GROUP BY DATEPART(week, visit4book)

INSERT INTO #BNS
SELECT DATEPART(week, visit5book) WeekNo, COUNT(dealId) BookedNotSAT
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(visit5book) = 2018 and fifthVisit is null
GROUP BY DATEPART(week, visit5book)

INSERT INTO #BNS
SELECT DATEPART(week, visit6book) WeekNo, COUNT(dealId) BookedNotSAT
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(visit6book) = 2018 and sixthVisit is null
GROUP BY DATEPART(week, visit6book)

INSERT INTO #BNS
SELECT DATEPART(week, installdatebook) WeekNo, COUNT(dealId) BookedNotSAT
FROM Shorthorn..cit_sh_dealsHS dhs
WHERE YEAR(installdatebook) = 2018 and dateInstalled is null
GROUP BY DATEPART(week, installdatebook)

-- Final Resultset

SELECT wn.WeekNo, ISNULL(sat.SAT, 0) SAT, ISNULL(bns.BookedNotSAT, 0) BookedNotSAT
INTO #Results
FROM #DatesThisYear wn
left outer join	(
					SELECT WeekNo, SUM(SAT) SAT
					FROM #SAT 
					GROUP BY WeekNo
				) sat ON wn.WeekNo = sat.WeekNo
left outer join	(
					SELECT WeekNo, SUM(BookedNotSAT) BookedNotSAT
					FROM #BNS
					GROUP BY WeekNo
				) bns ON wn.WeekNo = bns.WeekNo
ORDER BY wn.WeekNo

SELECT * FROM #Results

-- Potential YTD
SELECT SUM(SAT), SUM(BookedNotSAT)
FROM #Results

-- Actual YTD
SELECT SUM(SAT), SUM(BookedNotSAT)
FROM #Results
WHERE WeekNo < DATEPART(week, GETDATE())