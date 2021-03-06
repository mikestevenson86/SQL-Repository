
SELECT DISTINCT coName,cl.clientID,cl.SFDC_AccountId, d.renewDate, CASE WHEN u.appID = 9 THEN 'Yes' ELSE 'No' END AS 'CQC Usage'
,case when d.dealStatus in (12,13) then 'Auto' else 'Non-Auto' end RenewalStatus
FROM CitationMain..citation_CompanyTable2  AS cc
LEFT join Shorthorn.dbo.cit_sh_clients  AS cl ON cc.sageAC = cl.sageCode COLLATE Latin1_General_CI_AS AND
cc.sageAC  = cl.sageCode  COLLATE Latin1_General_CI_AS
LEFT join Shorthorn.dbo.cit_sh_deals AS d ON d.clientID = cl.clientID AND renewDate > GETDATE() 
LEFT JOIN CitationMain..citation_appUsage AS u ON u.compID = cc.uid AND u.appID = 9
left join [DB01].Salesforce.dbo.Contract c ON d.dealID = c.Shorthorn_Deal_ID__c
WHERE CQCDocs_Dental = 'Y' AND coName NOT LIKE 'Citation %' AND cl.clientID NOT IN (86369,86433,86434)
ORDER BY coName