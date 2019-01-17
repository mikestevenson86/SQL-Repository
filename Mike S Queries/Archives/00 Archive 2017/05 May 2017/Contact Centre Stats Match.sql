UPDATE SalesforceReporting..Contact_Centre
SET CalledId = CO.Id
FROM SalesforceReporting..Contact_Centre cc
inner join SalesforceReporting..Cisco_SFDC_Bridge CO ON REPLACE(case when cc.CalledPhone like '0%' then cc.CalledPhone else '0'+cc.CalledPhone end,' ','')
														= REPLACE(case when CO.Phone like '0%' then CO.Phone else '0'+CO.Phone end,' ','')
WHERE CalledId is null

UPDATE SalesforceReporting..Contact_Centre
SET CallingId = CI.Id
FROM SalesforceReporting..Contact_Centre cc
inner join SalesforceReporting..Cisco_SFDC_Bridge CI ON REPLACE(case when cc.CallingPhone like '0%' then cc.CallingPhone else '0'+cc.CallingPhone end,' ','')
															= REPLACE(case when CI.Phone like '0%' then CI.Phone else '0'+CI.Phone end,' ','')
WHERE CallingId is null