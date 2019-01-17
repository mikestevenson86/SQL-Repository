SELECT Dials, COUNT(Id) ProspectsAttempted
FROM
	(
	SELECT Id, MAX(rn) Dials
	FROM
		(
		SELECT ROW_NUMBER () OVER (PARTITION BY l.Id ORDER BY act_date DESC, act_time DESC) rn, L.Id, ch.act_date, ch.act_time
		FROM Salesforce..Lead l
		left outer join SalesforceReporting..call_history ch ON l.Id = ch.lm_filler2
		WHERE Affinity_Cold__c = 'Cold' and 
				l.Status = 'open' 
				
				and
				Website not like '%.gov.uk%' and Website not like '%.nhs.uk%'
				
				and
				l.Email not like '%gov.uk%' and l.Email not like '%nhs.uk%'
				
				and
				l.Website not like '%royalmail.co%' and l.Email not like '%royalmail.co%'
				
				and
				Company not in (SELECT Company FROM SalesforceReporting..BadCompanies)

				and
				l.SIC2007_Code__c not in ('D','E','K','R')
				and l.SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319','94910')
				and l.SIC2007_Code3__c not in ('50100','50200','50300','50400','51211','64110','64191','69101','69102','69109','82200','86101','86210','86220','99999')
				and l.SIC2007_Code3__c not in ('49320','51210','55100','55201','55202','55209','55300','55900','56101','56102','56103','56210','56290','56301')
				and l.SIC2007_Code3__c not in ('56302','80200','90010','90020','90030','90040','91011','91012','91020','91030','91040','92000','93110','93120','93130','93191','93199','93210')

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
				
				and
				IsTPS__c is null
			) detail
			
	GROUP BY Id
	) detail2

GROUP BY detail2.Dials
ORDER BY detail2.Dials

SELECT Dials, COUNT(Id) ProspectsConnected
FROM
	(
	SELECT Id, MAX(rn) Dials
	FROM
		(
		SELECT ROW_NUMBER () OVER (PARTITION BY l.Id ORDER BY act_date DESC, act_time DESC) rn, L.Id, ch.act_date, ch.act_time
		FROM Salesforce..Lead l
		left outer join SalesforceReporting..call_history ch ON l.Id = ch.lm_filler2
		WHERE   ch.call_type in (0,2,4) and Affinity_Cold__c = 'Cold' and 
				l.Status = 'open' 
				
				and
				Website not like '%.gov.uk%' and Website not like '%.nhs.uk%'
				
				and
				l.Email not like '%gov.uk%' and l.Email not like '%nhs.uk%'
				
				and
				l.Website not like '%royalmail.co%' and l.Email not like '%royalmail.co%'
				
				and
				Company not in (SELECT Company FROM SalesforceReporting..BadCompanies)

				and
				l.SIC2007_Code__c not in ('D','E','K','R')
				and l.SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319','94910')
				and l.SIC2007_Code3__c not in ('50100','50200','50300','50400','51211','64110','64191','69101','69102','69109','82200','86101','86210','86220','99999')
				and l.SIC2007_Code3__c not in ('49320','51210','55100','55201','55202','55209','55300','55900','56101','56102','56103','56210','56290','56301')
				and l.SIC2007_Code3__c not in ('56302','80200','90010','90020','90030','90040','91011','91012','91020','91030','91040','92000','93110','93120','93130','93191','93199','93210')

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
				
				and
				IsTPS__c is null
			) detail
			
	GROUP BY Id
	) detail2

GROUP BY detail2.Dials
ORDER BY detail2.Dials