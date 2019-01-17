SELECT detail.Id, detail.Status, detail.kf_ID_Contact
INTO #Data
FROM
(
SELECT l.Id, Status, qms.kf_ID_Contact
FROM Salesforce..Lead l
inner join 
(
SELECT case when sf_ID_account = '' then op.AccountId else sf_ID_account end AccID, qms.kf_ID_Contact
FROM SalesforceReporting..QMS_CrossSell_20170424 qms
left outer join Salesforce..Opportunity op ON qms.sf_ID_opportunity_item = op.Id
) qms ON l.Previous_Account__c = qms.AccID
UNION
SELECT Id, Status, qms.kf_ID_Contact
FROM Salesforce..Lead l
inner join SalesforceReporting..QMS_CrossSell_20170424 qms ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
															= REPLACE(case when qms.Phone1A like '0%' then qms.Phone1A else '0'+qms.Phone1A end,' ','')
WHERE ISNULL(l.Phone,'') <> '' and ISNULL(l.Phone,'') <> '0'
UNION
SELECT Id, Status, qms.kf_ID_Contact
FROM Salesforce..Lead l
inner join SalesforceReporting..QMS_CrossSell_20170424 qms ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
															= REPLACE(case when qms.Phone1A like '0%' then qms.Phone1A else '0'+qms.Phone1A end,' ','')
WHERE ISNULL(l.MobilePhone,'') <> '' and ISNULL(l.Mobile__c,'') <> '0'
UNION
SELECT Id, Status, qms.kf_ID_Contact
FROM Salesforce..Lead l
inner join SalesforceReporting..QMS_CrossSell_20170424 qms ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
															= REPLACE(case when qms.Phone1A like '0%' then qms.Phone1A else '0'+qms.Phone1A end,' ','')
WHERE ISNULL(l.Other_Phone__c,'') <> '' and ISNULL(l.Other_Phone__c,'') <> '0'
) detail
GROUP BY detail.Id, detail.Status, detail.kf_ID_Contact

SELECT d.*,rt.Name, l.LeadSource
FROM #Data d
left outer join Salesforce..Lead l ON d.Id = l.Id
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id

DROP TABLE #Data