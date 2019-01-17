SELECT Status, Suspended_closed_Reason__c, ISNULL(u.Name, 'Unassigned'), OutCode__c,
case when FT_Employees__c between 5 and 225 and
SIC2007_Code3__c not in 
('1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','49311','49319','49320','64192',
'64205','64910','64921','64922','64110','64191','69101','69102','69109','80300','81223','82200','86101','86210','94910','99999') and
SIC2007_Code__c not in ('B','D','E','K','R','I') and
IsTPS__c = 'No' then 'Crit' else 'NonCrit' end Criteria,
COUNT(l.Id)
FROM Salesforce..Lead l
left outer join Salesforce..[User] u ON l.OwnerId = u.Id
WHERE
(
l.PostalCode like 'KW%' or
l.PostalCode like 'IV%' or
l.PostalCode like 'AB%' or
l.PostalCode like 'PH%' or
l.PostalCode like 'DD%' or
l.PostalCode like 'FK%' or
l.PostalCode like 'KY%' or
l.PostalCode like 'PA%' or
l.PostalCode like 'G1%' or
l.PostalCode like 'G2%' or
l.PostalCode like 'G3%' or
l.PostalCode like 'G4%' or
l.PostalCode like 'G5%' or
l.PostalCode like 'G6%' or
l.PostalCode like 'G7%' or
l.PostalCode like 'G8%' or
l.PostalCode like 'G9%' or
l.PostalCode like 'EH%' or
l.PostalCode like 'ML%' or
l.PostalCode like 'KA%' or
l.PostalCode like 'TD%' or
l.PostalCode like 'DG%'
)
and RecordTypeId = '012D0000000NbJsIAK'
GROUP BY Status, Suspended_closed_Reason__c, ISNULL(u.Name, 'Unassigned'), OutCode__c,
case when FT_Employees__c between 5 and 225 and
SIC2007_Code3__c not in 
('1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','49311','49319','49320','64192',
'64205','64910','64921','64922','64110','64191','69101','69102','69109','80300','81223','82200','86101','86210','94910','99999') and
SIC2007_Code__c not in ('B','D','E','K','R','I') and
IsTPS__c = 'No' then 'Crit' else 'NonCrit' end
ORDER BY Status, Suspended_closed_Reason__c, ISNULL(u.Name, 'Unassigned'), OutCode__c,
case when FT_Employees__c between 5 and 225 and
SIC2007_Code3__c not in 
('1629','20130','20140','20150','20160','20200','20301','42120','43110','47300','49100','49200','49311','49319','49320','64192',
'64205','64910','64921','64922','64110','64191','69101','69102','69109','80300','81223','82200','86101','86210','94910','99999') and
SIC2007_Code__c not in ('B','D','E','K','R','I') and
IsTPS__c = 'No' then 'Crit' else 'NonCrit' end