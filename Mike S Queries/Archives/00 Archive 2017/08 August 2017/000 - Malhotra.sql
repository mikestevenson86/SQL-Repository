/*
CREATE TABLE #Temp
(
CompanyUID int,
SiteName VarChar(255)
)

INSERT INTO #Temp (CompanyUID, SiteName) VALUES (23564, 'Abbey Court Care Home')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8181, 'Addison Court Care Home')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8195, 'Albatross Backpackers')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (15097, 'Brooke House')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (9302, 'Brunswick House')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8187, 'Cestria House')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (10162, 'Covent House')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (9221, 'Hadrian House')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8190, 'Heatherfield Care Home')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8012, 'Malhotra Group Ltd')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (14631, 'Melton House')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8191, 'New Northumbria Hotel')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (10816, 'Osbornes Bar')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8192, 'Parklands Residential Care Home')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8189, 'Student Accommodation')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8196, 'The Butchers Arms')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8188, 'The Duke of Northumberland')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8786, 'The Market Lane')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8194, 'The Runhead Bar & Grill')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (12592, 'The Sandpiper')
INSERT INTO #Temp (CompanyUID, SiteName) VALUES (8785, 'The Three Mile Inn')

UPDATE  AdventCalendar..SiteVisitData
SET companyuid = t.CompanyUID
FROM AdventCalendar..SiteVisitData ad
inner join #Temp t ON ad.Site = t.SiteName

*/

IF OBJECT_ID('tempdb..#Temp') IS NOT NULL
	BEGIN
		DROP TABLE #Temp
	END

CREATE TABLE #Temp
(
ID int
)

--80.244.188.102 - mikestevenson - standard work password
insert into CitationMainUAT..citdocsobservations (companyuid, sitename, visitdate, obscat, observation, recomendation, priority, priorityInt, revision, emailSent, outstanding) 
OUTPUT inserted.recordid INTO #Temp (ID)
select 
       companyuid,
       [Site] sitename,
       [Inspection Date] visitdate,
       obscat,
       Observation,
       Recommendation,
       [Priority], 
       case when [Priority] = 'Comments' then 0
when [Priority] = 'Immediate' then 1
when [Priority] = 'High' then 2
when [Priority] = 'Low' then 3
when [Priority] = 'Medium' then 4 end,

       1 as revision, 
       1 as emailsent, 
       1 as outstanding     
from AdventCalendar..SiteVisitData

SELECT * FROM #Temp