SELECT

l.id [Salesforce ID],
l.[status] [Prospect Status],
IsNull(l.Suspended_closed_reason__c,'No Summary') [Status Summary],
case when IDG_FK__c is not null then 'IDG' when THL_FK__c is not null then 'Thompson' else 'Neither' end Source,
bdm.name [BDM],
IsNull(l.OutCode__c,'No Postcode') AreaCode,
case when l.SIC2007_Code__c not in ('A','B','D','E','K','R')
and l.SIC2007_Code3__c not in ('43110','49100','49200','49311','49320','50100','50200','50300')
and l.SIC2007_Code3__c not in ('50400','51101','51102','51210','51220','52211','52220','52230')
and l.SIC2007_Code3__c not in ('56101','69101','69109','69202','69203','74901','77341','77342')
and l.SIC2007_Code3__c not in ('77351','77352','77390','79110','79120','82200','82911','82912')
and l.SIC2007_Code3__c not in ('86101','86210','94110','94120','94200','94910','94920','94990','99999','69102','49320','86230') then 1 else 0 end [Is SIC Criteria?],
case when l.OutCode__c not in ('BD13','BD16','BD17','BD18','BD20','BD21','BD22','BD23','BD24','BD97','BD98','LS21','LS29')
and  l.OutCode__c not in ('PA20','PA21','PA22','PA23','PA24','PA25','PA26','PA27','PA28','PA29','PA30','PA31','PA32','PA33','PA34','PA35','PA36','PA37','PA38')
and l.OutCode__c not in ('PA41','PA42','PA43','PA44','PA45','PA46','PA47','PA48','PA49','PA60','PA61','PA62','PA63','PA64','PA65','PA66','PA67','PA68','PA69')
and l.OutCode__c not in ('PA70','PA71','PA72','PA73','PA74','PA75','PA76','PA77','PA78','DT','TQ','TR','PL','EX20','EX21','EX22','EX23','EX31','EX33','EX34')
and l.OutCode__c not in ('EX35','EX39','LN','SA','LD','HR','BT','AB','IV','KW','NP21','NP22','NP23','NP24','SY6','SY7','SY8','SY9','SY10','SY15','SY16','SY17')
and l.OutCode__c not in ('SY18','SY19','SY20','SY21','PA39','PA40','PA50','PA51','PA52','PA53','PA54','PA55','PA56','PA57','PA58','PA59','CF31','CF32','CF33')
and l.OutCode__c not in ('CF34','CF35','CF36','CF37','CF38','CF39','CF61','CF62','CF63','CF64','CF72','CF81','CF82','CF83','CF91','CF95','CF99') 
then 1 else 0 end [Is Post Code Criteria?],
case when l.Total_Employees__c between 5 and 200 then 1 else 0 end [Is Employee Count Crit?]

FROM

Salesforce..Lead l
inner join Salesforce..[User] bdm on l.OwnerId collate latin1_general_CS_AS = bdm.Id collate latin1_general_CS_AS

ORDER BY [status], Source, BDM, AreaCode
