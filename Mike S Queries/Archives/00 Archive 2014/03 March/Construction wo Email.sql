--NBS

--commit

/*select COUNT(*) from cust_nbs c where c.listid = 7317 --cleaning
select COUNT(*) from cust_nbs c where c.listid = 7316 --construction



--select COUNT(*) from dbo.cust_nbs --Result 116,725
begin transaction
--rollback
insert into dbo.cust_nbs
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
cold_affinity,
contact_name,
sf_status,
sfdc_ownerid,
sector,
dm_position,
SIC_2007Code,
SIC_2007Code_2,
business_urn
)*/


select

7319
as listid
,44
as country_id
,left(l.Phone,4)
as area
,substring(l.Phone,5,10)
as phone
,l.Name
as sname
,l.Street
as address1
,l.City
as address2
,BDM.Name
as city
,l.PostalCode
as postal_code
,l.State
as county,
l.email
,l.Id
as sfdc_id
,l.Company
as company
,l.PostalCode
as postcode
,case when l.Phone like '0%' then RIGHT(l.phone,10) else l.Phone end
as contact_number
,BDM.Name
as BDM
,l.Affinity_Cold__c
as cold_affinity
,l.Name
as contact_name
,l.Status
as sf_status
,l.OwnerId
as sfdc_ownerid
,l.CitationSector__c
as sector
,l.Position__c
as dm_position
,l.SIC2007_Code__c
as SIC_2007Code
,l.SIC2007_Code2__c
as SIC_2007Code_2
,l.Prospect_External_Id__c
as business_urn
from [Salesforce].dbo.Lead l

left outer join [salesforce].dbo.[User] BDM
on BDM.Id = l.OwnerId
left join cust_nbs nbs on l.Id collate latin1_general_CS_AS = nbs.sfdc_id collate latin1_general_CS_AS

where l.Status = 'Open'
and l.Id not in ('00QD000000fR8VqMAK', '00QD000000fTyRgMAK')
and l.Phone is not null
and CHARINDEX('/',l.name) = 0
and l.Email is null
and l.SIC2007_Code__c = 'F'
and l.SIC2007_Code3__c in (43330,
43320,
41202,
43999,
42990,
43310,
43130,
43910,
43342,
43290,
43210,
43341,
43220,
43110,
42910,
41100
)
and Total_Employees__c between 6 and 100
--select
--top 50 *
--from dbo.cust_nbs


