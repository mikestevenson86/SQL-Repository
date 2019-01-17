SELECT l.ID, Field, OldValue
FROM Salesforce..LeadHistory lh
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
inner join Salesforce..Lead l ON lh.LeadId = l.Id
WHERE CONVERT(date, lh.CreatedDate) between '2017-11-09' and '2017-11-14' and l.Status in ('Approved') and u.Name = 'Mike Stevenson'
and CONVERT(time, lh.CreatedDate) between '00:00:00.000' and '06:00:00.000'