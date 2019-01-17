SELECT ml.URN, STUFF
       (
              (
                     SELECT ', ' + al2.AuditType + ' - ' + al2.NewReason
                     FROM 
                           LeadChangeReview..AuditLog al2
                     WHERE
                           ml.URN collate latin1_general_CI_AS = al2.Source_ID
                     ORDER BY ml.URN
                     FOR XML PATH ('')
              ), 1, 1, ''
	   ) DupeExcReasons , case when l.ID is not null then 'Yes' else 'No' end InSalesforce
FROM [LSAUTOMATION].LEADS_ODS.ml.MainDataSet ml
left outer join [LSAUTOMATION].LEADS_ODS.dbo.LeadsSingleViewAuto lsv ON ml.URN = lsv.ML_URN
left outer join LeadChangeReview..AuditLog al ON ml.URN collate latin1_general_CI_AS = al.Source_Id
left outer join Salesforce..Lead l ON ml.URN collate latin1_general_CI_AS = l.Market_Location_URN__c
WHERE CONVERT(date, ml.DateCreated) = '2018-04-30' and lsv.ML_URN is null
GROUP BY ml.URN, l.Id
