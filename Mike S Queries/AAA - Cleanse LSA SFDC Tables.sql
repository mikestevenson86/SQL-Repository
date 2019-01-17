IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp

SELECT Id 
INTO #Temp
FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Lead_Dump 
WHERE Id collate latin1_general_CI_AS not in (SELECT ID collate latin1_general_CI_AS FROM Salesforce..Lead)

DELETE FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Lead_Dump 
WHERE Id collate latin1_general_CI_AS in (SELECT Id  collate latin1_general_CI_AS FROM #Temp)

IF OBJECT_ID('tempdb..#Temp2') IS NOT NULL DROP TABLE #Temp2

SELECT Id 
INTO #Temp2
FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Account_Dump 
WHERE Id collate latin1_general_CI_AS not in (SELECT ID collate latin1_general_CI_AS FROM Salesforce..Account)

DELETE FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Account_Dump 
WHERE Id collate latin1_general_CI_AS in (SELECT Id  collate latin1_general_CI_AS FROM #Temp2)

IF OBJECT_ID('tempdb..#Temp3') IS NOT NULL DROP TABLE #Temp3

SELECT Id 
INTO #Temp3
FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Sites_Dump 
WHERE Id collate latin1_general_CI_AS not in (SELECT ID collate latin1_general_CI_AS FROM Salesforce..Site__c)

DELETE FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Sites_Dump 
WHERE Id collate latin1_general_CI_AS in (SELECT Id  collate latin1_general_CI_AS FROM #Temp3)