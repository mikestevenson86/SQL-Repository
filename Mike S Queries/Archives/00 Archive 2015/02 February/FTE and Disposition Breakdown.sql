SELECT 
case when l.FT_Employees__c between 0 and 5 then '0 - 5'
when l.FT_Employees__c between 6 and 15 then '6 - 15'
when l.FT_Employees__c between 16 and 25 then '16 - 25'
when l.FT_Employees__c between 26 and 35 then '26 - 35'
when l.FT_Employees__c between 36 and 45 then '36 - 45'
when l.FT_Employees__c between 46 and 55 then '46 - 55'
when l.FT_Employees__c between 56 and 65 then '56 - 65'
when l.FT_Employees__c between 66 and 75 then '66 - 75'
when l.FT_Employees__c between 76 and 85 then '76 - 85'
when l.FT_Employees__c between 86 and 95 then '86 - 95'
when l.FT_Employees__c between 96 and 105 then '96 - 105'
when l.FT_Employees__c between 106 and 115 then '106 - 115'
when l.FT_Employees__c between 116 and 125 then '116 - 125'
when l.FT_Employees__c between 126 and 135 then '126 - 135'
when l.FT_Employees__c between 136 and 145 then '136 - 145'
when l.FT_Employees__c between 146 and 155 then '146 - 155'
when l.FT_Employees__c between 156 and 165 then '156 - 165'
when l.FT_Employees__c between 166 and 175 then '166 - 175'
when l.FT_Employees__c between 176 and 185 then '176 - 185'
when l.FT_Employees__c between 186 and 195 then '186 - 195'
when l.FT_Employees__c between 196 and 205 then '196 - 205'
when l.FT_Employees__c between 206 and 215 then '206 - 215'
when l.FT_Employees__c between 216 and 225 then '216 - 225' end Band,
COUNT(*),
SUM(case when Affinity_Cold__c = 'Cold' then 1 else 0 end) Cold,
SUM(case when Affinity_Cold__c like 'Affinity%' then 1 else 0 end) [Affinity],
SUM(case when l.SIC2007_Code3__c is null or l.SIC2007_Code3__c = 0 then 1 else 0 end) BlankSIC,
SUM(case when Status = 'Open' and Suspended_Closed_Reason__c = 'Decision Maker Unavailable' then 1 else 0 end) Open_DMU,
SUM(case when Status = 'Open' and Suspended_Closed_Reason__c = 'Gatekeeper Refusal' then 1 else 0 end) Open_GKR,
SUM(case when Status = 'Open' and Suspended_Closed_Reason__c = 'Answer Machine' then 1 else 0 end) Open_AM,
SUM(case when Status = 'Open' and Suspended_Closed_Reason__c = 'No Answer' then 1 else 0 end) Open_NoAns,
SUM(case when Status = 'Callback Requested' and Suspended_Closed_Reason__c = 'DM Callback' then 1 else 0 end) CB_DMC,
SUM(case when Status = 'Callback Requested' and Suspended_Closed_Reason__c = 'Non DM Callback' then 1 else 0 end) CB_DMC,
SUM(case when Status = 'Data Quality' then 1 else 0 end) DataQuality,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'Under Criteria' then 1 else 0 end) Susp_UndCrit,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'Not Interested' then 1 else 0 end) Susp_NI,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'Bad Sector' then 1 else 0 end) Susp_BadSec,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'DM Refusal' then 1 else 0 end) Susp_DMR,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'Area Not Covered' then 1 else 0 end) Susp_ANC,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'Third Party Renewal' then 1 else 0 end) Susp_TPR,
SUM(case when Status = 'Suspended' and Suspended_Closed_Reason__c = 'Tier 4 SIC Code' then 1 else 0 end) Susp_Tier4,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Over Criteria' then 1 else 0 end) Closed_OvCrit,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Ceased Trading' then 1 else 0 end) Closed_CT,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Branch' then 1 else 0 end) Closed_Branch,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Do Not Call' then 1 else 0 end) Closed_DNC,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Duplicate' then 1 else 0 end) Closed_Dupe,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Client' then 1 else 0 end) Closed_Client,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Sole Trader' then 1 else 0 end) Closed_SoleT,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Local Authority' then 1 else 0 end) Closed_LA,
SUM(case when Status = 'Closed' and Suspended_Closed_Reason__c = 'Bad Company' then 1 else 0 end) Closed_BadComp,
SUM(case when Status in ('Closed','Suspended') and Suspended_Closed_Reason__c is null then 1 else 0 end) CLSusp_NULL
FROM Salesforce..Lead l
left outer join SalesforceReporting..[ML-FebruaryData-2015] ml ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = ml.Phone
left outer join SalesforceReporting..[ML-FebruaryData-2015] ml2 ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') = ml2.Phone
left outer join SalesforceReporting..[ML-FebruaryData-2015] ml3 ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') = ml3.Phone
WHERE ml.Phone is not null or ml2.Phone is not null or ml3.Phone is not null
GROUP BY
case when l.FT_Employees__c between 0 and 5 then '0 - 5'
when l.FT_Employees__c between 6 and 15 then '6 - 15'
when l.FT_Employees__c between 16 and 25 then '16 - 25'
when l.FT_Employees__c between 26 and 35 then '26 - 35'
when l.FT_Employees__c between 36 and 45 then '36 - 45'
when l.FT_Employees__c between 46 and 55 then '46 - 55'
when l.FT_Employees__c between 56 and 65 then '56 - 65'
when l.FT_Employees__c between 66 and 75 then '66 - 75'
when l.FT_Employees__c between 76 and 85 then '76 - 85'
when l.FT_Employees__c between 86 and 95 then '86 - 95'
when l.FT_Employees__c between 96 and 105 then '96 - 105'
when l.FT_Employees__c between 106 and 115 then '106 - 115'
when l.FT_Employees__c between 116 and 125 then '116 - 125'
when l.FT_Employees__c between 126 and 135 then '126 - 135'
when l.FT_Employees__c between 136 and 145 then '136 - 145'
when l.FT_Employees__c between 146 and 155 then '146 - 155'
when l.FT_Employees__c between 156 and 165 then '156 - 165'
when l.FT_Employees__c between 166 and 175 then '166 - 175'
when l.FT_Employees__c between 176 and 185 then '176 - 185'
when l.FT_Employees__c between 186 and 195 then '186 - 195'
when l.FT_Employees__c between 196 and 205 then '196 - 205'
when l.FT_Employees__c between 206 and 215 then '206 - 215'
when l.FT_Employees__c between 216 and 225 then '216 - 225' end
ORDER BY
case when l.FT_Employees__c between 0 and 5 then '0 - 5'
when l.FT_Employees__c between 6 and 15 then '6 - 15'
when l.FT_Employees__c between 16 and 25 then '16 - 25'
when l.FT_Employees__c between 26 and 35 then '26 - 35'
when l.FT_Employees__c between 36 and 45 then '36 - 45'
when l.FT_Employees__c between 46 and 55 then '46 - 55'
when l.FT_Employees__c between 56 and 65 then '56 - 65'
when l.FT_Employees__c between 66 and 75 then '66 - 75'
when l.FT_Employees__c between 76 and 85 then '76 - 85'
when l.FT_Employees__c between 86 and 95 then '86 - 95'
when l.FT_Employees__c between 96 and 105 then '96 - 105'
when l.FT_Employees__c between 106 and 115 then '106 - 115'
when l.FT_Employees__c between 116 and 125 then '116 - 125'
when l.FT_Employees__c between 126 and 135 then '126 - 135'
when l.FT_Employees__c between 136 and 145 then '136 - 145'
when l.FT_Employees__c between 146 and 155 then '146 - 155'
when l.FT_Employees__c between 156 and 165 then '156 - 165'
when l.FT_Employees__c between 166 and 175 then '166 - 175'
when l.FT_Employees__c between 176 and 185 then '176 - 185'
when l.FT_Employees__c between 186 and 195 then '186 - 195'
when l.FT_Employees__c between 196 and 205 then '196 - 205'
when l.FT_Employees__c between 206 and 215 then '206 - 215'
when l.FT_Employees__c between 216 and 225 then '216 - 225' end