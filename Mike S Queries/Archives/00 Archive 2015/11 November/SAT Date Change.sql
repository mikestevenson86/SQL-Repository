SELECT CONVERT(date, oh.CreatedDate) ChangeDate, CONVERT(time, oh.CreatedDate) ChangeTime, OpportunityId, u.Name, OldValue, NewValue
FROM Salesforce..OpportunityFieldHistory oh
inner join Salesforce..[User] u ON oh.CreatedById = u.Id
WHERE Field = 'SAT_Date__c' and DATEPART(Year,CONVERT(date, oh.CreatedDate)) = 2015
ORDER BY CONVERT(date, oh.CreatedDate), CONVERT(time, oh.CreatedDate)