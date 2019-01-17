SELECT LeadId, u.Name Changer, lh.CreatedDate DateChanged, ISNULL(OldValue, '') OldValue, ISNULL(NewValue, '') NewValue
FROM Salesforce..LeadHistory lh
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
WHERE Field = 'LeadSource' and u.Name like '%pardot%'
ORDER BY lh.CreatedDate desc