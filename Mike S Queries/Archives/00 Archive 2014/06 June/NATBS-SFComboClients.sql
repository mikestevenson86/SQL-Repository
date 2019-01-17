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
sfdc_id,
company,
postcode,
contact_number,
bdm,
contact_name,
sfdc_ownerid,
sector,
dm_position,
SIC_2007Code,
SIC_2007Code_2,
business_urn,
dateimported,
listsource
)*/


select

7320
as listid
,44
as country_id
,left(a.Phone,4)
as area
,substring(a.Phone,5,10)
as phone
,cc.Name
as sname
,a.BillingStreet
as address1
,a.BillingCity
as address2
,u.Name
as city
,a.BillingPostalCode
as postal_code
,a.BillingState
as county,
cc.Email
,a.Id
as sfdc_id
,a.Name
as company
,a.BillingPostalCode
as postcode
,case when a.Phone like '0%' then RIGHT(a.phone,10) else a.Phone end
as contact_number
,u.Name
as BDM
,cc.Name
as contact_name
,a.OwnerId
as sfdc_ownerid
,a.CitationSector__c
as sector
,cc.Position__c
as dm_position
,a.SIC2007_Code__c
as SIC_2007Code
,a.SIC2007_Code2__c
as SIC_2007Code_2
,a.Account_External_Id__c
as business_urn,
GETDATE()
as dateimported,
'H&S Combo SF Extract'
as ListSource
FROM Salesforce..Account a
inner join Salesforce..[User] u on a.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
left outer join Salesforce..Contact cc on a.Id collate latin1_general_CS_AS = cc.AccountId collate latin1_general_CS_AS
left outer join Salesforce..Contract c on a.Id collate latin1_general_CS_AS = c.AccountId collate latin1_general_CS_AS
WHERE u.Name in ('James OHare','Andy Coleman','Alan Barber','Jo Elliott','Mark Kelsall') 
and 
c.Services_Taken_EL__c = 'true' 
and 
c.Services_Taken_HS__c = 'true'