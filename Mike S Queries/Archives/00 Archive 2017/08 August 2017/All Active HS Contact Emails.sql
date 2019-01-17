SELECT 
a.Id, 
a.Name Company, 
c.Name Contact, 
c.Email

FROM 
Salesforce..Account a
inner join Salesforce..Contact c ON a.Id = c.AccountId

WHERE 
Serivces_Taken__c in ('EL & HR / H&S','EL & HR / H&S and CQC','H&S','H&S and CQC') 
and
HSServiceTaken__c = 'true'
and 
ISNULL(Email_Opt_Out__c, 'FALSE') = 'FALSE'
and 
ISNULL(c.Email,'') <> ''
and
c.Email not like '%citation%'
and
SalesforceReporting.dbo.CleanEmail(Email) = 1
and 
Citation_Client__c = 'true'
and
ActiveComplaint__c is null
and 
(
ISNULL(c.Helpline_PEL__c,'') <> 'Yes' 
or 
	(
	c.Helpline_PEL__c = 'Yes' 
	and 
		(
		c.Helpline_H_S__c = 'Yes' 
		or 
		c.Main_User__c = 'Yes' 
		or 
		Online_Super_User__c = 'Yes'
		)
	)
)