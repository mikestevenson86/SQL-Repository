SELECT 
	u.Name,
	COUNT(l.id) [Open Prospects]

FROM 
	Salesforce..Lead l
	left outer join SalesforceReporting..[Noble Records - 10-06-2014] n 
	ON l.Id collate latin1_general_CS_AS = n.sfdc_id collate latin1_general_CS_AS
	inner join salesforce..[User] u 
	ON l.OwnerId collate latin1_general_CS_AS = u.id collate latin1_general_CS_AS

WHERE 
	l.[Status] = 'open' 
	and l.Affinity_Cold__c = 'cold'
	and n.sfdc_id is null 
	and l.FT_Employees__c between 6 and 200 
	and (l.SIC2007_Code__c is not null or l.SIC2007_Code2__c is not null or l.SIC2007_Code3__c is not null)
	and l.SIC2007_Code__c not in ('A','B','D','E','K','R')
	and l.SIC2007_Code3__c not in ('43110','49100','49200','49311','49320','50100','50200','50300')
	and l.SIC2007_Code3__c not in ('50400','51101','51102','51210','51220','52211','52220','52230')
	and l.SIC2007_Code3__c not in ('56101','69101','69109','69202','69203','74901','77341','77342')
	and l.SIC2007_Code3__c not in ('77351','77352','77390','79110','79120','82200','82911','82912')
	and l.SIC2007_Code3__c not in ('86101','86210','94110','94120','94200','94910','94920','94990')
	and l.SIC2007_Code3__c not in ('99999','69102','49320','86230')
	and l.SIC2007_Code3__c not in ('47110','47190','47220','47230','47240','47290','47300','47421')
	and l.SIC2007_Code3__c not in ('47510','47520','47530','47540','47591','47599','47610','47620')
	and l.SIC2007_Code3__c not in ('47640','47650','47710','47722','47782','47789','47910','47990')
	and l.SIC2007_Code3__c not in ('55100','55300','55900','56103','56210','56302','81210','81299','93110','93120','93199','93290')
	and l.Phone is not NULL
	and LEFT(l.PostalCode,4) not in ('BD13','BD16','BD17','BD18','BD97','BD98','LS21','LS29','EX31','EX33','EX34','EX35','EX39')
	and LEFT(l.postalCode,4) not between 'BD20' and 'BD24'
	and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
	and LEFT(l.PostalCode,4) not between 'EX20' and 'EX23'
	and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
	and l.Area_Code__c not in ('PO','KW','IV','BT','LN','SA','LD','HR','TR','PL','TQ','DT')
	
GROUP BY
	u.Name