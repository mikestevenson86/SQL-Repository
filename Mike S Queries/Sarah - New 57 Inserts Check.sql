SELECT 
case when sv.Manual_Exclusion=0 then 1 else 0 end ManualExclusion,
case when (CONVERT(INT, ISNULL(sv.Exc_ContactCentre,0))+CONVERT(INT, ISNULL(sv.Exc_Events,0)))<2 then 1 else 0 end Exclusions,
case when Market_Location_URN__c IS NULL then 1 else 0 end SFDC_URN,
case when Market_Location_URN__c NOT IN (SELECT Market_Location_URN__c FROM [LSAUTOMATION].LEADS_ODS.dbo.SFDC_Success_Log_MLAPI_Current_run) then 1 else 0 end  Success_URN,
case when ISNULL(sv.OnHold,0)=0 then 1 else 0 end OnHold,
case when temp.[Type] = 'Inserts' then 1 else 0 end Inserts,
case when sv.ML_TYPE = 'N' then 1 else 0 end ML_TYPE_N,
case when sv.ML_LOCATION_TYPE = 'S' then 1 else 0 end LOCATION_TYPE_S,
case when sv.ML_UPDATE_BAND = 'A' then 1 else 0 end UPDATE_BAND_A,
case when sv.ML_RECORD_TYPE = 'C' then 1 else 0 end  RECORD_TYPE_C,
case when sv.ML_MAJOR_SECTOR_DESCRIPTION not like '%mining%' then 1 else 0 end Mining,
case when sv.ML_EASY_SECTOR_CODE not in
( 
15,23,40,41,42,44,46,47,74,146,152,317,328,329,332,333,334,335,336,337,377,378,379,389,390,398,436,455,470,471,488,490,491,503,518,519,540,569,570,574,580,591,592, 
594,610,618,658,665,669,670,671,672,701,702,703,704,707,708,709,739,771,772,777,796,814,816,821,865,878,883,884,905,915,925,933,949,956,957,959,1058,1059,1063,1123, 
1140,1146,1193,1212,1213,1214,1215,1254,1277,1278,1279,1280,1300,1329,1330,1331,1336,1344,1345,1346,1347,1349,1350,1355,1369,1398,1400,1410,1412,1415,1429,1435,1462, 
1483,1484,1485,1486,1487,1488,1489,1500,1520,1521,1522,1523,1615,1638,1639,1692,1695,1697,1698,1700,1701,1705,1741,1796,1800,1806,1847,1848,1867,1892,2002,2013,2030, 
2031,2043,2051,2062,2119,2165,2201,2294,2302,2320,2328,2331,2337,2342,2353,2369,2387,2405,2406,2407,2038,2108,2155,2156,2252,2254,2255,2281,2286,2287,2290,2297,2378
)  then 1 else 0 end BadEasySector,
case when ISNULL(sv.Exc_ContactCentre,0) = 0 then 1 else 0 end Exclusion_ContactCentre
FROM SalesforceReporting.[dbo].temp_singleview_i_u temp  WITH (NOLOCK)
INNER JOIN [LSAUTOMATION].LEADS_ODS.dbo.[LeadsSingleViewAuto] sv  WITH (NOLOCK) ON sv.ML_URN = temp.ML_URN
--INNER JOIN dbo.Temp_Singleview_Manual_Exclusions ex WITH (NOLOCK)  ON ex.ML_URN=sv.ML_URN
LEFT JOIN ( SELECT * FROM (SELECT ROW_NUMBER() OVER(PARTITION BY Market_Location_URN__c ORDER BY [Company] DESC ,[Street] DESC ,[City] DESC ,[State] DESC ,[PostalCode] DESC ,[Phone] DESC 
																								,[IsTPS__c] DESC ,[Salutation] DESC ,[FirstName] DESC ,[LastName] DESC ,[Position__c] DESC 
																								,[Website] DESC ,[FT_Employees__c] DESC ,[SIC2007_Code3__c] DESC  ) rn,*
								FROM [LSAUTOMATION].LEADS_ODS.dbo.[SFDC_Lead_Dump]  WITH (NOLOCK) 
							) a 
			WHERE rn=1
		)l ON sv.ML_URN = l.Market_Location_URN__c