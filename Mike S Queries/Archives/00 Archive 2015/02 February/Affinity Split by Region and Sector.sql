SELECT 
af.Sector,
SUM(case when u.Name in ('William Mcfaulds','John McCaffrey') then 1 else 0 end) Scotland,
SUM(case when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 1 else 0 end) North,
SUM(case when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 1 else 0 end) London,
SUM(case when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 1 else 0 end) South
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..UserRole ur ON u.UserRoleId = ur.Id
inner join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]
WHERE	Status = 'open' 

		and
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
		
		and
		IsTPS__c is null
GROUP BY af.Sector