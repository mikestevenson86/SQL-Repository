SELECT
WhatId,
Subject,
Next_Action_Date__c,
Status

INTO
#LastTask

FROM
(
	SELECT
	WhatId, Subject, Status, Next_Action_Date__c, ROW_NUMBER () OVER (PARTITION BY WhatId ORDER BY CreatedDate DESC) rn

	FROM
	Salesforce..Task t

	WHERE
	WhatId like '006D%'
) detail

WHERE
rn = 1

SELECT 
o.Id, 
a.Name [Company Name], 
o.Certification__c Certification, 
o.[Type], 
o.LeadSource [Prospect Source], 
o.Next_Action_Due_Date__c [Next Action Due Date], 
o.CreatedDate [Created Date], 
o.OpportunityAge__c Age, 
o.CloseDate [Close Date], 
o.StageName Stage, 
o.Probability,
lt.Subject,
lt.Next_Action_Date__c [Due Date],
lt.Status

FROM Salesforce..Opportunity o
inner join Salesforce..RecordType rt ON o.RecordTypeId = rt.Id
inner join Salesforce..[User] u ON o.OwnerId = u.Id
inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
inner join Salesforce..Account a ON o.AccountId = a.Id
left outer join #LastTask lt ON o.Id = lt.WhatId

WHERE 
rt.Name = 'QMS' 
and 
StageName in ('Pre-Quote QMS','Quoated QMS','NSF Received','CCF Received','Proforma Generated','Deposit Received')
and 
uMan.Name = 'Tonia English' 
and 
u.Name <> 'Donna Williams'

DROP TABLE #LastTask