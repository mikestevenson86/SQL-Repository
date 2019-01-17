SELECT Area_Code__c, COUNT(*) CC
INTO #CC
FROM Salesforce..Lead
WHERE 
(Status = 'open' OR (Status = 'Callback Requested' and Callback_Date_Time__c >= '2015-04-10')) and
(FT_Employees__c between 6 and 225 or FT_Employees__c = 0) and
SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319',
'49320','50100','50200','50300','50400','51220','52211','64110','64191','69101','69102','69109','82200','85200','85310','85320','85410',
'85422','85510','85520','85530','85590','85600','86101','86210','99999') and
SIC2007_Code__c not in ('B','D','E') and
(Phone <> '' or Phone is not null) and (IsTPS__c is null or IsTPS__c <> 'Yes')
GROUP BY Area_Code__c

SELECT Area_Code__c, COUNT(*) EM
INTO #EM
FROM Salesforce..Lead
WHERE 
(Status = 'open' OR (Status = 'Callback Requested' and Callback_Date_Time__c >= '2015-04-10')) and
(FT_Employees__c between 6 and 225 or FT_Employees__c = 0) and
SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319',
'49320','50100','50200','50300','50400','51220','52211','64110','64191','69101','69102','69109','82200','85200','85310','85320','85410',
'85422','85510','85520','85530','85590','85600','86101','86210','99999') and
SIC2007_Code__c not in ('B','D','E') and
HasOptedOutOfEmail = 'false' and (Email is not null or Email <> '')
GROUP BY Area_Code__c

SELECT Area_Code__c, COUNT(*) DM
INTO #DM
FROM Salesforce..Lead
WHERE 
(Status = 'open' OR (Status = 'Callback Requested' and Callback_Date_Time__c >= '2015-04-10')) and
(FT_Employees__c between 6 and 225 or FT_Employees__c = 0) and
SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319',
'49320','50100','50200','50300','50400','51220','52211','64110','64191','69101','69102','69109','82200','85200','85310','85320','85410',
'85422','85510','85520','85530','85590','85600','86101','86210','99999') and
SIC2007_Code__c not in ('B','D','E') and
(Street is not null or Street <> '')
GROUP BY Area_Code__c

SELECT distinct(l.Area_Code__c), cc.CC, em.EM, dm.DM
FROM Salesforce..Lead l
left outer join #CC cc ON l.Area_Code__c = cc.Area_Code__c
left outer join #EM em ON l.Area_Code__c = em.Area_Code__c
left outer join #DM dm ON l.Area_Code__c = dm.Area_Code__c
ORDER BY l.Area_Code__c

DROP TABLE #DM
DROP TABLE #EM
DROP TABLE #CC