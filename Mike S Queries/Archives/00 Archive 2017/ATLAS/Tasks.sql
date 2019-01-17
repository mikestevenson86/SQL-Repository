SELECT
case when [Priority] = 1 then 'High'
when [Priority] = 2 then 'Medium'
when [Priority] = 3 then 'Low' end [Priority],
title Observation,
description Recommendation,
u.FirstName + ' ' + u.SecondName [Assigned To],
DueDate Deadline,
ais.Name [Status],
PercentageCompleted [% Complete],
case when PercentageCompleted = 100 then AcknowledgeDate else '' end [Completion Date],
CostOfRectification

FROM
TaskActivities ta
inner join Shared.Users u ON ta.AssignedTo = u.Id
inner join Shared.ActivityInstanceStatus ais ON ta.Status = ais.Code

WHERE Month(DueDate) = Month(GETDATE()) and Year(DueDate) = Year(GETDATE())