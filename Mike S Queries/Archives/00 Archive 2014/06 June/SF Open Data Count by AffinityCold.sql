SELECT 
u.Name, 
SUM(case when l.Affinity_Cold__c = 'Cold' and	l.FT_Employees__c between 6 and 225
	and l.SIC2007_Code__c not in ('A','B','D','E','K','R')
	and l.SIC2007_Code3__c not in ('43110','49100','49200','49311','49320','50100','50200','50300')
	and l.SIC2007_Code3__c not in ('50400','51101','51102','51210','51220','52211','52220','52230')
	and l.SIC2007_Code3__c not in ('56101','69101','69109','69202','69203','74901','77341','77342')
	and l.SIC2007_Code3__c not in ('77351','77352','77390','79110','79120','82200','82911','82912')
	and l.SIC2007_Code3__c not in ('86101','86210','94110','94120','94200','94910','94920','94990')
	and l.SIC2007_Code3__c not in ('99999','69102','49320','86230','64110','64191','64192','64306')
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
	and l.Area_Code__c not in ('KW','IV','BT','LN','SA','LD','HR','TR','PL','TQ','DT') then 1 else 0 end) Cold,
	SUM(case when l.Affinity_Cold__c = 'Affinity - Key' and l.Phone is not NULL
	and (SIC2007_Code3__c in ('01130','01160','01190','01250','01290','01300','01430','01610','01621','01630','01640','16100','16210','16220','16230')
	or SIC2007_Code3__c in ('20150','20301','20302','20411','20412','20420','21100','21200','23110','23120','23130','23140','23190','23700','24530','25120')
	or SIC2007_Code3__c in ('25500','25610','25710','26701','28301','28302','28490','28910','29201','29202','30990','32120','32130','33150','33170','43320')
	or SIC2007_Code3__c in ('43342','43910','43991','46130','46150','46220','46310','46440','46460','46610','46620','46720','46730','46750','47520','47730')
	or SIC2007_Code3__c in ('47749','47760','49100','49200','49319','49390','49410','49420','50100','50200','50300','50400','51210','52101','52102','52103')
	or SIC2007_Code3__c in ('52213','52219','52230','52241','52242','52243','52290','53202','64204','71112','71129','71200','74901','74902','75000','77120')
	or SIC2007_Code3__c in ('77310','77320','77342','77351','77352','79120','80100','80200','80300','81210','81222','81223','81229','81291','81299','81300')
	or SIC2007_Code3__c in ('85100','85200','85310','85320','85410','85421','85422','85520','85590','86102','86201','86220','86230','87100','87200','87300')
	or SIC2007_Code3__c in ('87900','88100','88910','88990','91040','94910','96030'))
	and LEFT(l.PostalCode,4) not in ('BD13','BD16','BD17','BD18','BD97','BD98','LS21','LS29','EX31','EX33','EX34','EX35','EX39')
	and LEFT(l.postalCode,4) not between 'BD20' and 'BD24'
	and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
	and LEFT(l.PostalCode,4) not between 'EX20' and 'EX23'
	and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
	and l.Area_Code__c not in ('KW','IV','BT','LN','SA','LD','HR','TR','PL','TQ','DT') then 1 else 0 end) AffinityKey,
	SUM(case when l.Affinity_Cold__c = 'Affinity - Database' and l.Phone is not NULL

	and LEFT(l.PostalCode,4) not in ('BD13','BD16','BD17','BD18','BD97','BD98','LS21','LS29','EX31','EX33','EX34','EX35','EX39')
	and LEFT(l.postalCode,4) not between 'BD20' and 'BD24'
	and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
	and LEFT(l.PostalCode,4) not between 'EX20' and 'EX23'
	and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
	and l.Area_Code__c not in ('KW','IV','BT','LN','SA','LD','HR','TR','PL','TQ','DT') then 1 else 0 end) AffinityDB

FROM 
Salesforce..Lead l
inner join Salesforce..[User] u 
on l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS

WHERE 
l.[Status] = 'open'

GROUP BY 
u.Name