SELECT ServiceName Company, ProviderName Company_Group__c, AddressLine1 + ' ' + AddressLine2 Street, Town City, Postcode PostalCode, Tel Phone, 
Category + ' Max Places (' + [Max Approved Places] + ') Care Categories: ' + [Categories of Care] + ' Certificate Conditions: ' 
+ [Conditions(AsOnCertificate)] Notes__c,
[Contact Forename] FirstName, [Contact Surname] LastName, [Contact Position] Position__c
FROM SalesforceReporting..RQIA_January2017
WHERE [insert] = 1

SELECT *
FROM
(
SELECT l.Id, ServiceName Company, ProviderName Company_Group__c, AddressLine1 + ' ' + AddressLine2 Street, Town City, Postcode PostalCode, Tel Phone, 
Category + ' Max Places (' + [Max Approved Places] + ') Care Categories: ' 
+ [Categories of Care] + ' Certificate Conditions: ' + [Conditions(AsOnCertificate)] [Description1],
[Contact Forename] FirstName, [Contact Surname] LastName, [Contact Position] Position__c
FROM SalesforceReporting..RQIA_January2017 r
inner join Salesforce..Lead l ON REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') = 
									REPLACE(case when r.Tel like '0%' then r.Tel else '0'+r.Tel end,' ','') 
WHERE [Update] = 1 and Tel <> '' and Tel <> '0'
UNION
SELECT l.Id, ServiceName Company, ProviderName Company_Group__c, AddressLine1 + ' ' + AddressLine2 Street, Town City, Postcode PostalCode, Tel Phone, 
Category + ' Max Places (' + [Max Approved Places] + ') Care Categories: ' 
+ [Categories of Care] + ' Certificate Conditions: ' + [Conditions(AsOnCertificate)] [Description1],
[Contact Forename] FirstName, [Contact Surname] LastName, [Contact Position] Position__c
FROM SalesforceReporting..RQIA_January2017 r
inner join Salesforce..Lead l ON REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','') = 
									REPLACE(case when r.Tel like '0%' then r.Tel else '0'+r.Tel end,' ','') 
WHERE [Update] = 1 and Tel <> '' and Tel <> '0'
UNION
SELECT l.Id, ServiceName Company, ProviderName Company_Group__c, AddressLine1 + ' ' + AddressLine2 Street, Town City, Postcode PostalCode, Tel Phone, 
Category + ' Max Places (' + [Max Approved Places] + ') Care Categories: ' 
+ [Categories of Care] + ' Certificate Conditions: ' + [Conditions(AsOnCertificate)] [Description1],
[Contact Forename] FirstName, [Contact Surname] LastName, [Contact Position] Position__c
FROM SalesforceReporting..RQIA_January2017 r
inner join Salesforce..Lead l ON REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','') = 
									REPLACE(case when r.Tel like '0%' then r.Tel else '0'+r.Tel end,' ','') 
WHERE [Update] = 1 and Tel <> '' and Tel <> '0'
UNION
SELECT l.Id, ServiceName Company, ProviderName Company_Group__c, AddressLine1 + ' ' + AddressLine2 Street, Town City, Postcode PostalCode, Tel Phone, 
Category + ' Max Places (' + [Max Approved Places] + ') Care Categories: ' 
+ [Categories of Care] + ' Certificate Conditions: ' + [Conditions(AsOnCertificate)] [Description1],
[Contact Forename] FirstName, [Contact Surname] LastName, [Contact Position] Position__c
FROM SalesforceReporting..RQIA_January2017 r
inner join Salesforce..Lead l ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(r.ServiceName,'Ltd',''),'Limited','')
									and REPLACE(l.PostalCode,' ','') = REPLACE(r.PostCode,' ','')
WHERE [Update] = 1 and Tel <> '' and Tel <> '0'
UNION
SELECT l.Id, ServiceName Company, ProviderName Company_Group__c, AddressLine1 + ' ' + AddressLine2 Street, Town City, Postcode PostalCode, Tel Phone, 
Category + ' Max Places (' + [Max Approved Places] + ') Care Categories: ' 
+ [Categories of Care] + ' Certificate Conditions: ' + [Conditions(AsOnCertificate)] [Description1],
[Contact Forename] FirstName, [Contact Surname] LastName, [Contact Position] Position__c
FROM SalesforceReporting..RQIA_January2017 r
inner join Salesforce..Lead l ON REPLACE(REPLACE(l.Company,'Ltd',''),'Limited','') = REPLACE(REPLACE(r.ProviderName,'Ltd',''),'Limited','')
									and REPLACE(l.PostalCode,' ','') = REPLACE(r.PostCode,' ','')
WHERE [Update] = 1 and Tel <> '' and Tel <> '0'
) detail