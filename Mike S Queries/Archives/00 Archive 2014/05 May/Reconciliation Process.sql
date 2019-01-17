------------------------------------
--Stage 1
------------------------------------

select
sfdc_id
into ##tmpListids
from noblecustomtables.dbo.cust_citation c
where 
c.listid in ('11009','11010','11011','11012','11013','11014','11015','11016','11017','11018','11019','11020','11021','11022','11023','11024','11025','11025','11026','11027','11028','11029','11030')
or c.listid in ('1200','12009','12010','12011','12008','12012','12013','12014','12015','12016','12017','12018','12019','12020','12021')

select
*
into ##tmpUpdateHistory
from
(
	select
	ROW_NUMBER() OVER(PARTITION BY ch.lm_filler2 ORDER BY ch.act_date DESC) AS Row
	,ch.lm_filler2
	,ch.[status]
	,ch.addi_status
	,ch.act_date

	from [Enterprise].dbo.call_history ch

	inner join ##tmpListids l
	on l.sfdc_id = ch.lm_filler2
)detail
where detail.Row = 1

drop table ##tmpListids


--Update cust_citation table
begin transaction
update noblecustomtables.dbo.cust_citation 
set [status] = h.status,  addi_status = h.addi_status,  call_date = h.act_date
from noblecustomtables.dbo.cust_citation c
	inner join ##tmpUpdateHistory h
	on h.lm_filler2 = c.sfdc_id


drop table ##tmpUpdateHistory

commit

---------------------------------------
--Stage 2
---------------------------------------

--clear list id
--select
--c.listid
--from dbo.cust_citation c
--where c.listid = '11009'

begin transaction
update noblecustomtables.dbo.cust_citation 
set listid = null
where 
listid in ('11009','11010','11011','11012','11013','11014','11015','11016','11017','11018','11019','11020','11021','11022','11023','11024','11025','11025','11026','11027','11028','11029','11030')
or listid in ('1200','12009','12010','12011','12008','12012','12013','12014','12015','12016','12017','12018','12019','12020','12021')

commit