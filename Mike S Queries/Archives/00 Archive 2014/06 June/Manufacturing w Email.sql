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

7320
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
as business_urn,
GETDATE()
as dateimported
from [Salesforce].dbo.Lead l

left outer join [salesforce].dbo.[User] BDM
on BDM.Id = l.OwnerId
left join noblecustomtables..cust_nbs nbs on l.Id collate latin1_general_CS_AS = nbs.sfdc_id collate latin1_general_CS_AS

where l.Status = 'Open'
and l.Id not in ('00QD000000fR8VqMAK', '00QD000000fTyRgMAK')
and l.Phone is not null
and CHARINDEX('/',l.name) = 0
and l.Email is not null
and l.SIC2007_Code__c = 'C'
and l.SIC2007_Code3__c in (26513,
32500,
22290,
28250,
20160,
28230,
15120,
31010,
28290,
16230,
23610,
26702,
32990,
27120,
13923,
29202,
27320,
32200,
14190,
20301,
23190,
28990,
10890,
25730,
32409,
23700,
16210,
13939,
25990,
24100,
11050,
31090,
25940,
26110,
22220,
22210,
23990,
27900,
28220,
26400,
10822,
17120,
28950,
25210,
13910,
25500,
10710,
20590,
28930,
17230,
27400,
29100,
25610,
33200,
28132,
23420,
28301,
20420,
25110,
29320,
10420,
23140,
13300,
14120,
10110,
28923,
27510,
18121,
30990,
29201,
26309,
28140,
33120,
25720,
10840,
25290,
23200,
28240,
11070,
26511,
28150,
31020,
25930,
16290,
22190,
13990,
24200,
31030,
19209,
15200,
10520,
27110,
24420,
17290,
10920,
30920,
17220,
22230,
30200,
13940,
16100,
21100,
20170,
26520,
17211,
32910,
24510,
33110,
23910,
22110,
24450,
23490,
29203,
28210,
23630)
and Total_Employees__c between 6 and 100
--select
--top 50 *
--from dbo.cust_nbs


