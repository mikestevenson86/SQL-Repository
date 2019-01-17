WITH temp as
(
select d.companyId,count(*) count1 from Documents d
where d.isdeleted=0 group by d.companyId
)
select c.FullName,count1 from citation.companies c
left join temp p on p.companyid = c.id
order by count1 desc
