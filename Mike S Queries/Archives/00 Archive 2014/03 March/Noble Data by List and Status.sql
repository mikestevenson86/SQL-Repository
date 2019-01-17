use Enterprise

select ca.listname, c.status, COUNT(*) Records
from noblecustomtables..cust_citation as c
join catalogue as ca on c.listid = ca.listid
where listname like 'tmcd%'
group by listname, c.status

