SELECT COUNT(record_id) records, sfdc_id collate latin1_general_cS_AS SFID
INTO #DeDup
from NobleCustomTables..cust_citation
group by sfdc_id collate latin1_general_CS_AS
order by COUNT(record_id) desc

begin tran

UPDATE cust_citation
SET IsDupe = 1
WHERE record_id in 
(SELECT MAX(record_id)
FROM cust_citation c
left join #DeDup dd on c.sfdc_id collate latin1_general_CS_AS = dd.SFID collate latin1_general_CS_AS
WHERE dd.records = 2
GROUP BY sfdc_id)

--drop table #dedup