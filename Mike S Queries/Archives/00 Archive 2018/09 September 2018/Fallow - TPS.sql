IF OBJECT_ID('LeadChangeReview..Fallow_TPS') IS NOT NULL DROP TABLE LeadChangeReview..Fallow_TPS
IF OBJECT_ID('tempdb..#NewPhones') IS NOT NULL DROP TABLE #NewPhones

SELECT
l.Id,
REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') Phone,
0 TPSPhone,
REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','') Mobile,
0 TPSMobile,
REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','') Other,
0 TPSOther
INTO
LeadChangeReview..Fallow_TPS
FROM
Salesforce..Lead l
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
WHERE
Status not in ('Data Quality','Approved','Callback Requested','Pended') and IsConverted = 'false' and rt.Name = 'Default Citation Record Type'
and ISNULL(Suspended_Closed_Reason__c, '') <> 'Do Not Call'

UPDATE lp
SET TPSPhone = 1
FROM LeadChangeReview..Fallow_TPS lp
inner join SalesforceReporting..ctps_ns tps ON lp.Phone = tps.Phone

UPDATE lp
SET TPSMobile = 1
FROM LeadChangeReview..Fallow_TPS lp
inner join SalesforceReporting..ctps_ns tps ON lp.Mobile = tps.Phone

UPDATE lp
SET TPSOther = 1
FROM LeadChangeReview..Fallow_TPS lp
inner join SalesforceReporting..ctps_ns tps ON lp.Other = tps.Phone

SELECT Id, Phone Old_Phone, case when TPSMobile = 0 and LEN(ISNULL(Mobile,'')) > 9 then Mobile else Other end New_Phone
INTO #NewPhones
FROM LeadChangeReview..Fallow_TPS 
WHERE TPSPhone = 1 and ((TPSMobile = 0 and LEN(ISNULL(Mobile,'')) > 9) or (TPSOther = 0 and LEN(ISNULL(Other,'')) > 9))

IF OBJECT_ID('LeadChangeReview..NewPhone') IS NOT NULL DROP TABLE LeadChangeReview..NewPhone
IF OBJECT_ID('LeadChangeReview..NewPhone_Exceptions') IS NOT NULL DROP TABLE LeadChangeReview..NewPhone_Exceptions

SELECT Id, New_Phone INTO LeadChangeReview..NewPhone FROM #NewPhones WHERE New_Phone NOT LIKE '%[^0-9.]%'
SELECT Id, New_Phone Exceptions INTO LeadChangeReview..NewPhone_Exceptions FROM #NewPhones WHERE New_Phone LIKE '%[^0-9.]%'