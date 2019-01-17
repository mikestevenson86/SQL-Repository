SELECT COUNT(distinct Market_Location_URN__c)
FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_history scd
inner join [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Success_Log_MLAPI ml ON scd.URN = ml.Market_Location_URN__c
WHERE CreatedDate = '2018-04-30'

SELECT l.Market_Location_URN__c, Field
FROM [LSAUTOMATION].LEADS_ODS.ml.SCDChanges_history scd
inner join [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Success_Log_MLAPI ml ON scd.URN = ml.Market_Location_URN__c
inner join Salesforce..Lead l ON ml.Market_Location_URN__c collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE scd.CreatedDate = '2018-04-30'
GROUP BY l.Market_Location_URN__c, Field