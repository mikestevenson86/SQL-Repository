/*begin transaction
--rollback
insert into NobleCustomTables..cust_nbs
(
listid,
country_id,
areacode,
phone,
sname,
address1,
address2,
city,
postal_code,
county,
email,
company,
postcode,
contact_number,
contact_name,
dateimported,
listsource
)*/


select

7327
as listid
,44
as country_id
,left(REPLACE(l.phone1,' ',''),4)
as area
,substring(REPLACE(l.Phone1,' ',''),5,10)
as phone
,l.contact1
as sname
,l.address_1
as address1
,l.address_2
as address2
,l.address_3
as city
,l.postcode
as postal_code
,l.address_4
as county,
l.email1
as email
,l.client_name
as company
,l.postcode
as postcode
,case when l.Phone1 like '0%' then RIGHT(REPLACE(l.phone1,' ',''),10) else REPLACE(l.Phone1,' ','') end
as contact_number
,l.contact1
as contact_name,
CONVERT(date,GETDATE())
as dateimported,
'NBS HotRod Extract 2'
as ListSource
,l.ShorthornClientID
as BusinessURN
from SalesforceReporting..[NBS - SH matched data] l

