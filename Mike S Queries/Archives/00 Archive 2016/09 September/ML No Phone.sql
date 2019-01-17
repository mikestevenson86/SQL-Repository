SELECT COUNT(URN)
FROM MarketLocation..MainDataSet l
left outer join SalesforceReporting..SIC2007Codes sc ON l.[UK 07 Sic Code] = sc.SIC3_Code
WHERE [Telephone Number] = '' and location_type <> 'B'
and
		((
		l.[web address] not like '%.gov.uk%' and l.[Contact email address] not like '%gov.uk%' and l.[company email address] not like '%gov.uk%'
		
		and
		l.[web address] not like '%.nhs.uk%' and l.[Contact email address] not like '%nhs.uk%' and l.[company email address] not like '%nhs.uk%'
		
		and
		l.[web address] not like '%.royalmail.co%' and l.[Contact email address] not like '%royalmail.co%' and l.[company email address] not like '%royalmail.co%'
		
		and
		l.[web address] not like '%hpcha.org%' and l.[Contact email address] not like '%hpcha.org%' and l.[company email address] not like '%hpcha.org%'
		
		and
		l.[web address] not like '%o2.co%' and l.[Contact email address] not like '%o2.co%' and l.[company email address] not like '%o2.co%'
		
		and
		l.[web address] not like '%.bupa.co%' and l.[Contact email address] not like '%bupa.co.uk%' and l.[company email address] not like '%bupa.co.uk%') or [web address] = '' or l.[Contact email address] = '' or [company email address] = '')
		
		and
		[Business Name] not in (SELECT Company FROM SalesforceReporting..BadCompanies)

		and
		(
		sc.SIC_Code not in ('B','D','E','K','I','O','R')
		and l.[UK 07 Sic Code] not in ('1629','20130','20140','20150','20160','20200','35110','35120','35130','35140','35210','35220','35230')
		and l.[UK 07 Sic Code] not in ('35300','36000','37000','38110','38120','38220','38310','38320','39000','42120','43110','47300','49100')
		and l.[UK 07 Sic Code] not in ('55209','55300','64110','64191','47300','49100','49200','49311','49319','49320','50100','50200','50300')
		and l.[UK 07 Sic Code] not in ('50400','51220','52211','55202','64192','69101','69102','69109','80300','84210','84220','84230','84240')
		and l.[UK 07 Sic Code] not in ('84250','84300','86101','86210','90040','91011','91012','91020','91030','91040','94910','99999')
		) or l.[UK 07 Sic Code] = ''
		
		and LEFT(l.Postcode,4) not between 'PA20' and 'PA80'
		and LEFT(l.Postcode,4) not between 'PO30' and 'PO41'
		and LEFT(l.Postcode,2) not in ('LD','ZE','GY','JE','IM','HS')
		
		and
		l.[Nat Employees] between 6 and 225