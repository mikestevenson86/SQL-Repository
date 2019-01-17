SELECT
ID,
Name,
Company,
Phone,
Replace(Replace(Replace(Replace(Street, ',', ''), CHAR(10)+CHAR(13), ''), CHAR(10), ''), CHAR(13), '') as address1,
City,
PostalCode,
Email
FROM
Salesforce..Lead 
WHERE
SIC2007_Code3__c in ('81210','81221','81222','81223','81229','81299')
and
FT_Employees__c between 6 and 100
and
phone is not null
and
(FirstName is not null or FirstName<>'' or FirstName<>'?')
and
(LastName is not null or LastName<>'' or LastName<>'?')
and
--(
--PostalCode like 'FY%' or
--PostalCode like 'LL%' or
--PostalCode like 'SY%' or
--PostalCode like 'HG%' or
--PostalCode like 'YO%' or
--PostalCode like 'LN%' or
--PostalCode like 'PE%' or
--PostalCode like 'NN%'
--)
--and
IsTPS__c is null

SELECT
ID,
Name,
Company,
Phone,
Replace(Replace(Replace(Replace(Street, ',', ''), CHAR(10)+CHAR(13), ''), CHAR(10), ''), CHAR(13), '') as address1,
City,
PostalCode,
Email
FROM
Salesforce..Lead 
WHERE
SIC2007_Code3__c in ('71121','71122','71129','72190','77320')
and
FT_Employees__c between 6 and 100
and
phone is not null
and
(FirstName is not null or FirstName<>'' or FirstName<>'?')
and
(LastName is not null or LastName<>'' or LastName<>'?')
and
--(
--PostalCode like 'FY%' or
--PostalCode like 'LL%' or
--PostalCode like 'SY%' or
--PostalCode like 'HG%' or
--PostalCode like 'YO%' or
--PostalCode like 'LN%' or
--PostalCode like 'PE%' or
--PostalCode like 'NN%'
--)
--and
IsTPS__c is null