-- Total Flagged as TPS
SELECT COUNT(1) TotalFlagged
FROM SalesforceReporting..TPS_June2018

-- Main is not, but mobile or other is
SELECT COUNT(1) TPS_NotMain
FROM SalesforceReporting..TPS_June2018
WHERE TPS_Phone is null and ISNULL(Phone, '') <> '' and (TPS_Mobile = 1 or TPS_Other = 1)

-- Main is, but mobile or other is not
SELECT COUNT(1) TPS_MainNotOthers
FROM SalesforceReporting..TPS_June2018
WHERE TPS_Phone = 1 and (
							(TPS_Mobile is null and ISNULL(Mobile, '') <> '')
							or 
							(TPS_Other is null and ISNULL(Other, '') <> '')
						)
						
-- UPDATES
-- Clear mobile when it's TPS but Phone or Other is not

SELECT
l.Id,
NULL MobilePhone,
'No' IsTPS__c
FROM
Salesforce..Lead l
inner join SalesforceReporting..TPS_June2018 tps ON l.Id = tps.Id
WHERE
TPS_Mobile = 1
and
(
	(TPS_Phone is null and LEN(tps.Phone) > 7)
	or 
	(TPS_Other is null and LEN(Other) > 7)
)

-- Clear other when it's TPS but Phone or Mobile is not

SELECT
l.Id,
NULL Other_Phone__c,
'No' IsTPS__c
FROM
Salesforce..Lead l
inner join SalesforceReporting..TPS_June2018 tps ON l.Id = tps.Id
WHERE
TPS_Other = 1
and
(
	(TPS_Mobile is null and LEN(Mobile) > 7)
	or 
	(TPS_Phone is null and LEN(tps.Phone) > 7)
)

-- Replace phone number when it's TPS but Mobile or Other is not

SELECT
l.Id,
'No' IsTPS__c,
case when TPS_Mobile is null and LEN(Mobile) > 7 then Mobile else Other end Phone
FROM
Salesforce..Lead l
inner join SalesforceReporting..TPS_June2018 tps ON l.Id = tps.Id
WHERE
TPS_Phone = 1
and
(
	(TPS_Mobile is null and LEN(Mobile) > 7)
	or 
	(TPS_Other is null and LEN(Other) > 7)
)

-- Flag TPS records where ALL are TPS (No number clearance)

SELECT
l.Id,
'Yes' IsTPS__c
FROM
Salesforce..Lead l
inner join SalesforceReporting..TPS_June2018 tps ON l.Id = tps.Id
WHERE
TPS_Phone = 1 and TPS_Mobile = 1 and TPS_Other = 1