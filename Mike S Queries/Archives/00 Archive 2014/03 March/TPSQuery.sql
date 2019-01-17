select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.contact_number = tps.Number
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.phone = tps.Number
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.mobile_number = tps.Number
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.other_number = tps.Number
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.contact_number = RIGHT(tps.Number,10)
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.phone = RIGHT(tps.Number,10)
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.mobile_number = RIGHT(tps.Number,10)
where tps.Number is not null

select c.record_id, c.contact_number, tps.Number, c.other_number, c.phone, c.mobile_number
from NobleCustomTables..cust_citation c
inner join SalesforceReporting..ctps_ns tps on c.other_number = RIGHT(tps.Number,10)
where tps.Number is not null