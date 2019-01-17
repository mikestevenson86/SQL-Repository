DECLARE @INT INT
SET @INT = 30
WHILE @INT > 0

BEGIN

SELECT GETDATE() - @INT CDate,COUNT(lh.LeadID) +
(
SELECT COUNT(ID)
FROM Salesforce..Lead l
WHERE l.[Status] = 'open'
	and	l.FT_Employees__c between 5 and 200
	and l.SIC2007_Code__c not in ('A','B','D','E','K','R')
	and l.SIC2007_Code3__c not in ('43110','49100','49200','49311','49320','50100','50200','50300')
	and l.SIC2007_Code3__c not in ('50400','51101','51102','51210','51220','52211','52220','52230')
	and l.SIC2007_Code3__c not in ('56101','69101','69109','69202','69203','74901','77341','77342')
	and l.SIC2007_Code3__c not in ('77351','77352','77390','79110','79120','82200','82911','82912')
	and l.SIC2007_Code3__c not in ('86101','86210','94110','94120','94200','94910','94920','94990','99999','69102','49320','86230')
	and l.Phone is not NULL
	and LEFT(l.PostalCode,4) not in ('BD13','BD16','BD17','BD18','BD97','BD98','LS21','LS29','EX31','EX33','EX34','EX35','EX39')
	and LEFT(l.postalCode,4) not between 'BD20' and 'BD24'
	and LEFT(l.PostalCode,4) not between 'PA20' and 'PA80'
	and LEFT(l.PostalCode,4) not between 'EX20' and 'EX23'
	and LEFT(l.PostalCode,4) not between 'NP1' and 'NP20'
	and l.Area_Code__c not in ('PO','KW','IV','BT','LN','SA','LD','HR','TR','PL','TQ','DT')
) Leads
FROM Salesforce..LeadHistory lh
WHERE lh.CreatedDate >= GETDATE()- @INT and lh.OldValue = 'open'

SET @INT = @INT-1

END