DELETE FROM SalesforceReporting..RefEmployee

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Phone FROM Salesforce..Lead) l1 ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
																	= REPLACE(case when l1.Phone like '0%' then l1.Phone else '0'+l1.Phone end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Phone,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l																	
left outer join (SELECT Id LeadId, MobilePhone FROM Salesforce..Lead) l1 ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
																	= REPLACE(case when l1.MobilePhone like '0%' then l1.MobilePhone else '0'+l1.MobilePhone end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Phone,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Other_Phone__c FROM Salesforce..Lead) l1 ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
																	= REPLACE(case when l1.Other_Phone__c like '0%' then l1.Other_Phone__c else '0'+l1.Other_Phone__c end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Phone,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Phone FROM Salesforce..Lead) l1 ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
																	= REPLACE(case when l1.Phone like '0%' then l1.Phone else '0'+l1.Phone end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.MobilePhone,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l																	
left outer join (SELECT Id LeadId, MobilePhone FROM Salesforce..Lead) l1 ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
																	= REPLACE(case when l1.MobilePhone like '0%' then l1.MobilePhone else '0'+l1.MobilePhone end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.MobilePhone,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Other_Phone__c FROM Salesforce..Lead) l1 ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
																	= REPLACE(case when l1.Other_Phone__c like '0%' then l1.Other_Phone__c else '0'+l1.Other_Phone__c end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.MobilePhone,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Phone FROM Salesforce..Lead) l1 ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
																	= REPLACE(case when l1.Phone like '0%' then l1.Phone else '0'+l1.Phone end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Other_Phone__c,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l																	
left outer join (SELECT Id LeadId, MobilePhone FROM Salesforce..Lead) l1 ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
																	= REPLACE(case when l1.MobilePhone like '0%' then l1.MobilePhone else '0'+l1.MobilePhone end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Other_Phone__c,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Other_Phone__c FROM Salesforce..Lead) l1 ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
																	= REPLACE(case when l1.Other_Phone__c like '0%' then l1.Other_Phone__c else '0'+l1.Other_Phone__c end,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Other_Phone__c,'') not in ('0','') and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/

INSERT INTO SalesforceReporting..RefEmployee
SELECT Id
FROM Salesforce..Lead l
left outer join (SELECT Id LeadId, Company, PostalCode FROM Salesforce..Lead) l1 ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(l1.Company,'Ltd',''),'Limited','')
																	and REPLACE(l.PostalCode,' ','') = REPLACE(l1.PostalCode,' ','')
																	and l.Id <> l1.LeadId 
WHERE ISNULL(l.Company,'') <> '' and ISNULL(l.PostalCode,'') <> '' and LeadSource = 'Ref_Employee' and 
(
Status = 'Open'
or
(Status = 'Suspended' and Suspended_Closed_Reason__c in ('Third Party Renewal','Not Interested'))
) and l1.LeadId is not null
/*
Suspended_Closed_Reason__c in ('Not Interested','Under Criteria') and YEAR(l.CreatedDate) in (2015,2016) and g.Name = 'Website Leads'
and IsConverted = 'false'
*/