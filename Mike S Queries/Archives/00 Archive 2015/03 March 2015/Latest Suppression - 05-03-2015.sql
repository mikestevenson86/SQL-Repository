SELECT Id
INTO #CTPS
FROM Salesforce..Lead l
WHERE
REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','') in
(
SELECT Phone
FROM SalesforceReporting..ctps_ns
) or
REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ','') in
(
SELECT Phone
FROM SalesforceReporting..ctps_ns
) or
REPLACE(case when Other_Phone__c like '0%' then Other_Phone__c else '0'+Other_Phone__c end,' ','') in
(
SELECT Phone
FROM SalesforceReporting..ctps_ns
)

SELECT Phone
INTO #TPS
FROM Salesforce..Lead l
left outer join #CTPS c ON l.Id = c.Id
left outer join SalesforceReporting..sf_suppression s ON l.Id = s.sfdc_id
WHERE c.Id is null and IsTPS__c = 'Yes' and (s.sfdc_id is null or s.reason not like '%client%')
and

Company not in (SELECT Company FROM SalesforceReporting..BadCompanies) and

Website not like '%.gov.uk%' and Website not like '%.nhs.uk%' and

Email not like '%gov.uk%' and Email not like '%nhs.uk%' and

		l.SIC2007_Code__c not in ('D','E','K','R')
		and l.SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319','94910')
		and l.SIC2007_Code3__c not in ('50100','50200','50300','50400','51211','64110','64191','69101','69102','69109','82200','86101','86210','86220','99999')

		and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
		and LEFT(l.PostalCode,4) not between 'NP21' and 'NP24'
		and LEFT(l.PostalCode,4) not between 'SA16' and 'SA99'
		and LEFT(l.PostalCode,4) not between 'IV10' and 'IV39'
		and LEFT(l.PostalCode,4) not between 'PO30' and 'PO41'
		and l.Area_Code__c not in ('KW','BT','LD','ZE','GY','JE','IM','HS')
		
		and
		l.FT_Employees__c between 6 and 225
		
		and
		(l.Phone <> '' or l.Phone is not null)
		
SELECT s.*, l.phone
FROM SalesforceReporting..sf_suppression s
inner join Salesforce..Lead l ON s.sfdc_id = l.Id
left outer join SalesforceReporting..NonTier4 nt ON l.Id = nt.Id
left outer join #TPS t ON l.Phone = t.Phone
WHERE t.Phone is null and nt.Id is null
ORDER BY s.rowid

		DROP TABLE #CTPS
		DROP TABLE #TPS