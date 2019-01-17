IF OBJECT_ID('tempdb..#Temp') IS NOT NULL
	BEGIN
		DROP TABLE #Temp
	END
IF OBJECT_ID('tempdb..#Temp2') IS NOT NULL
	BEGIN
		DROP TABLE #Temp2
	END

CREATE TABLE #Temp
(
Phone VarChar(20)
)

INSERT INTO #Temp
SELECT
REPLACE(case when CalledPhone like '0%' then CalledPhone else '0'+CalledPhone end,' ','') Phone
FROM
SalesforceReporting..Contact_Centre

INSERT INTO #Temp
SELECT
REPLACE(case when CallingPhone like '0%' then CallingPhone else '0'+CallingPhone end,' ','') Phone
FROM
SalesforceReporting..Contact_Centre

SELECT *
INTO #Temp2
FROM #Temp
GROUP BY Phone

SELECT l.Id, t.Phone
FROM #Temp2 t
inner join Salesforce..Lead l ON	REPLACE(case when t.Phone like '0%' then t.Phone else '0'+t.Phone end,' ','')
									= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
									or
									REPLACE(case when t.Phone like '0%' then t.Phone else '0'+t.Phone end,' ','')
									= REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
									or
									REPLACE(case when t.Phone like '0%' then t.Phone else '0'+t.Phone end,' ','')
									= REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
								
SELECT 
CONVERT(date,LEFT(StartDateTime, 10),103), 
SUM(case when [Type] = 'Ext/Out' then 1 else 0 end) Outbound,
SUM(case when [Type] = 'Ext/In' then 1 else 0 end) Inbound
FROM SalesforceReporting..Contact_Centre cc
GROUP BY CONVERT(date,LEFT(StartDateTime, 10),103)
ORDER BY CONVERT(date,LEFT(StartDateTime, 10),103)

DROP TABLE #Temp
DROP TABLE #Temp2