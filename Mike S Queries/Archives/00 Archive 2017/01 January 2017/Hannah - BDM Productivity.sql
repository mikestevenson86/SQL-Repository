SELECT 
Subject, 
u.Name, 
e.Type, 
e.Event_Status__c, 
ActivityDate, 
StartDateTime, 
EndDateTime,
case when (Subject like 'holiday%' or Subject like '| Holiday%') then 'Holiday'
when Subject like '%sick%' then 'Sick'
when DateMade__c is not null and 
(
Subject like '%outbound%1%' or
Subject like '%outbound%2%' or
Subject like '%outbound%3%' or
Subject like '%outbound%4%' or
Subject like '%inbound%1%' or
Subject like '%inbound%2%' or
Subject like '%inbound%3%' or
Subject like '%inbound%4%' or
Subject like '%seminar%appointment%1%' or
Subject like '%seminar%appointment%2%' or
Subject like '%seminar%appointment%3%' or
Subject like '%seminar%appointment%4%'
)
then 'Appointment'
when Type = 'Meeting' then 'Meeting' else 'Other' end EventType

FROM 
Salesforce..[Event] e
inner join Salesforce..[User] u ON e.OwnerId = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id

WHERE
p.Name = 'Citation BDM'