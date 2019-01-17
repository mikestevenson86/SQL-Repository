SELECT
a.Id,
a.Name,
a.s__c Segmentation,
a.CitationSector__c,
a.Citation_Client__c,
a.IsActive__c Active,
a.HR_EL_Service_Taken__c,
a.H_S_Service_Taken__c,
c.Helpline_PEL__c,
c.Helpline_H_S__c,
c.Main_User__c,
c.Online_Super_User__c,
c.AdviceCard__c,
c.FirstName,
c.LastName,
c.Email,
c.HasOptedOutOfEmail

FROM
Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
inner join Salesforce..Contract con ON a.Id = con.AccountId

WHERE
c.HasOptedOutOfEmail <> 'true'
and
ISNULL(c.Email,'') <> ''
and
c.Email not like '%citation%'
and
a.Citation_Client__c = 'true'
and
con.Services_Taken_EL__c = 'true'
and
c.Active__c = 'true'
and
(
	c.PEL_Contact__c = 1
	or
	c.Online_Super_User__c = 'Yes'
	or
	c.Main_User__c = 'Yes'
	or
	c.Migration_Contact__c = 'true'
	or
	c.AdviceCard__c = 'true'
)
and
con.Status = 'Active'

GROUP BY
a.Id,
a.Name,
a.s__c,
a.CitationSector__c,
a.Citation_Client__c,
a.IsActive__c,
a.HR_EL_Service_Taken__c,
a.H_S_Service_Taken__c,
c.Helpline_PEL__c,
c.Helpline_H_S__c,
c.Main_User__c,
c.Online_Super_User__c,
c.AdviceCard__c,
c.FirstName,
c.LastName,
c.Email,
c.HasOptedOutOfEmail