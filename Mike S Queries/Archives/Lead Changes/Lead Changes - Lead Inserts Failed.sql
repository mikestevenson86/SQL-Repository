SELECT 
ml.URN,
case when (
lsv.Manual_Exclusion=1
or (CONVERT(INT, ISNULL(lsv.Exc_ContactCentre,0))+CONVERT(INT, ISNULL(lsv.Exc_Events,0)))=2
--or Market_Location_URN__c IS not NULL or Market_Location_URN__c IN (SELECT Market_Location_URN__c COLLATE LATIN1_GENERAL_CI_AS FROM [lsautomation].leads_ods.DBO.SFDC_Success_Log_MLAPI_Current_run)
or ISNULL(lsv.OnHold,0)=1
--AND temp.[Type] = 'Inserts'
or lsv.ML_TYPE <> 'N' 
or lsv.ML_LOCATION_TYPE <> 'S'  
or lsv.ML_UPDATE_BAND <> 'A'
or lsv.ML_RECORD_TYPE <> 'C'  
 or 
 /*
(  
        (ISNULL(sv.[ML_CONTACT EMAIL ADDRESS], '') = '' and ISNULL(sv.[ML_COMPANY EMAIL ADDRESS], '') = '' and sv.[ML_NAT EMPLOYEES] between 3 and 225)
       or 
        (
              ( 
                      (ISNULL(sv.[ML_CONTACT EMAIL ADDRESS], '') <> '' and ISNULL(sv.[ML_COMPANY EMAIL ADDRESS], '') = '')   
                      or 
                      (ISNULL(sv.[ML_CONTACT EMAIL ADDRESS], '') = '' and ISNULL(sv.[ML_COMPANY EMAIL ADDRESS], '') <> '')  
                      or 
                      (ISNULL(sv.[ML_CONTACT EMAIL ADDRESS], '') <> '' and ISNULL(sv.[ML_COMPANY EMAIL ADDRESS], '') <> '') 
               )
              and 
               sv.[ML_NAT EMPLOYEES] between 3 and 301
       )  
 )  
 and 
 */
lsv.ML_MAJOR_SECTOR_DESCRIPTION like '%mining%'  
 or lsv.ML_EASY_SECTOR_CODE in
( 
 15,23,40,41,42,44,46,47,74,146,152,317,328,329,332,333,334,335,336,337,377,378,379,389,390,398,436,455,470,471,488,490,491,503,518,519,540,569,570,574,580,591,592, 
 594,610,618,658,665,669,670,671,672,701,702,703,704,707,708,709,739,771,772,777,796,814,816,821,865,878,883,884,905,915,925,933,949,956,957,959,1058,1059,1063,1123, 
 1140,1146,1193,1212,1213,1214,1215,1254,1277,1278,1279,1280,1300,1329,1330,1331,1336,1344,1345,1346,1347,1349,1350,1355,1369,1398,1400,1410,1412,1415,1429,1435,1462, 
 1483,1484,1485,1486,1487,1488,1489,1500,1520,1521,1522,1523,1615,1638,1639,1692,1695,1697,1698,1700,1701,1705,1741,1796,1800,1806,1847,1848,1867,1892,2002,2013,2030, 
 2031,2043,2051,2062,2119,2165,2201,2294,2302,2320,2328,2331,2337,2342,2353,2369,2387,2405,2406,2407,2038,2108,2155,2156,2252,2254,2255,2281,2286,2287,2290,2297,2378
)  
 or ISNULL(lsv.Exc_ContactCentre,0) = 1

) then 'Citation Exclusion'
when er.Market_Location_URN__c is not null then 'SFDC Error' end ErrorReason
FROM [LSAUTOMATION].LEADS_ODS.dbo.LeadsSingleViewAuto lsv
left outer join [LSAUTOMATION].LEADS_ODS.ml.MainDataSet ml ON ml.URN = lsv.ML_URN
left outer join [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Lead_Dump l ON ml.URN = l.Market_Location_URN__c
left outer join [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Lead_Dump_ErrorLog er ON ml.URN = er.Market_Location_URN__c
WHERE CONVERT(date, ml.DateCreated) = '2018-04-30' and l.Market_Location_URN__c is null