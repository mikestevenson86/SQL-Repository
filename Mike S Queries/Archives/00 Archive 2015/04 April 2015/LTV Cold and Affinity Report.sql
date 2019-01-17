SELECT
DATENAME(Month, Date_Made__c) ApptMonth,
af.Sector,
COUNT(l.Id) Appts
INTO
#Appts
FROM
Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE DATEPART(Year, Date_Made__c) = 2014
GROUP BY
DATENAME(Month, Date_Made__c),
af.Sector

SELECT
detail.CallMonth,
detail.Sector,
ISNULL((SUM(Calls)/ap.Appts), 0) CallsToAppt
FROM
(
SELECT
DATEPART(Month, act_date) MonthNo, 
DATENAME(Month, act_date) CallMonth,
af.Sector,
COUNT(seqno) Calls
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE 
DATEPART(Year, act_date) = 2014 and call_type in (0,2,4)
GROUP BY 
DATEPART(Month, act_date),
DATENAME(MONTH, act_date),
af.Sector
UNION
SELECT 
DATEPART(Month, act_date) MonthNo,
DATENAME(Month, act_date) CallMonth,
af.Sector,
COUNT(seqno) Calls
FROM
Enterprise..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE 
DATEPART(Year, act_date) = 2014 and call_type in (0,2,4)
GROUP BY 
DATEPART(Month, act_date),
DATENAME(MONTH, act_date),
af.Sector
) detail
left outer join #Appts ap ON detail.CallMonth = ap.ApptMonth and detail.Sector = ap.Sector
GROUP BY 
detail.MonthNo,
detail.CallMonth,
detail.Sector,
ap.Appts
ORDER BY
detail.MonthNo,
detail.Sector

SELECT
af.Sector,
COUNT(l.Id)
FROM
Salesforce..Lead l
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE
Status = 'open' 	
and
l.SIC2007_Code__c not in ('D','E','K','R')
and l.SIC2007_Code3__c not in ('01629','09100','20150','20160','20200','20301','20412','35110','43110','47300')
and l.SIC2007_Code3__c not in ('49100','49200','49311','49319','49320','50100','50200','50300','50400','51211')
and l.SIC2007_Code3__c not in ('51210','55100','55201','55202','55209','55300','55900','56101','56102','56103')
and l.SIC2007_Code3__c not in ('56210','56290','56301','56302','64110','64191','69101','69102','69109','82200')
and l.SIC2007_Code3__c not in ('86101','86210','86220','80200','90010','90020','90030','90040','91011','91012')
and l.SIC2007_Code3__c not in ('91020','91030','91040','92000','93110','93120','93130','93191','93199','93210','94910','99999')			
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP21' and 'NP24'
and LEFT(l.PostalCode,4) not between 'SA16' and 'SA99'
and LEFT(l.PostalCode,4) not between 'IV10' and 'IV39'
and LEFT(l.PostalCode,4) not between 'PO30' and 'PO41'
and l.Area_Code__c not in ('KW','BT','LD','ZE','GY','JE','IM','HS')		
and
l.FT_Employees__c between 6 and 225		
and
(l.Phone <> '' or l.Phone is not null)		
and
IsTPS__c is null		
and
(RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null)		
GROUP BY
af.Sector
ORDER BY
af.Sector

SELECT
DATENAME(Month, Date_Made__c) ApptMonth,
sc.[Description],
COUNT(l.Id) Appts
INTO
#CAppts
FROM
Salesforce..Lead l
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE DATEPART(Year, Date_Made__c) = 2014 and sc.[SIC Code 3] not in (SELECT [SIC Code 2007] FROM SalesforceReporting..AffinitySICCodes)
GROUP BY
DATENAME(Month, Date_Made__c),
sc.[Description]

SELECT
detail.CallMonth,
detail.[Description],
ISNULL((SUM(Calls)/ap.Appts), 0) CallsToAppt
FROM
(
SELECT
DATEPART(Month, act_date) MonthNo, 
DATENAME(Month, act_date) CallMonth,
sc.[Description],
COUNT(seqno) Calls
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE 
DATEPART(Year, act_date) = 2014 and call_type in (0,2,4) and sc.[SIC Code 3] not in (SELECT [SIC Code 2007] FROM SalesforceReporting..AffinitySICCodes)
GROUP BY 
DATEPART(Month, act_date),
DATENAME(MONTH, act_date),
sc.[Description]
UNION
SELECT
DATEPART(Month, act_date) MonthNo, 
DATENAME(Month, act_date) CallMonth,
sc.[Description],
COUNT(seqno) Calls
FROM
Enterprise..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE 
DATEPART(Year, act_date) = 2014 and call_type in (0,2,4) and sc.[SIC Code 3] not in (SELECT [SIC Code 2007] FROM SalesforceReporting..AffinitySICCodes)
GROUP BY 
DATEPART(Month, act_date),
DATENAME(MONTH, act_date),
sc.[Description]
) detail
left outer join #CAppts ap ON detail.CallMonth = ap.ApptMonth and detail.[Description] = ap.[Description]
GROUP BY 
detail.MonthNo,
detail.CallMonth,
detail.[Description],
ap.Appts
ORDER BY
detail.MonthNo,
detail.[Description]

SELECT
sc.[Description],
COUNT(l.Id)
FROM
Salesforce..Lead l
inner join SalesforceReporting..SICCodes2007 sc ON l.SIC2007_Code3__c = sc.[SIC Code 3]
WHERE
Status = 'open' 
and
l.SIC2007_Code__c not in ('D','E','K','R')
and l.SIC2007_Code3__c not in ('01629','09100','20150','20160','20200','20301','20412','35110','43110','47300')
and l.SIC2007_Code3__c not in ('49100','49200','49311','49319','49320','50100','50200','50300','50400','51211')
and l.SIC2007_Code3__c not in ('51210','55100','55201','55202','55209','55300','55900','56101','56102','56103')
and l.SIC2007_Code3__c not in ('56210','56290','56301','56302','64110','64191','69101','69102','69109','82200')
and l.SIC2007_Code3__c not in ('86101','86210','86220','80200','90010','90020','90030','90040','91011','91012')
and l.SIC2007_Code3__c not in ('91020','91030','91040','92000','93110','93120','93130','93191','93199','93210','94910','99999')	
and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
and LEFT(l.PostalCode,4) not between 'NP21' and 'NP24'
and LEFT(l.PostalCode,4) not between 'SA16' and 'SA99'
and LEFT(l.PostalCode,4) not between 'IV10' and 'IV39'
and LEFT(l.PostalCode,4) not between 'PO30' and 'PO41'
and l.Area_Code__c not in ('KW','BT','LD','ZE','GY','JE','IM','HS')		
and
l.FT_Employees__c between 6 and 225		
and
(l.Phone <> '' or l.Phone is not null)		
and
IsTPS__c is null		
and
(RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null)
and 
l.SIC2007_Code3__c not in (SELECT [SIC Code 2007] FROM SalesforceReporting..AffinitySICCodes)		
GROUP BY
sc.[Description]
ORDER BY
sc.[Description]

DROP TABLE #Appts
DROP TABLE #CAppts