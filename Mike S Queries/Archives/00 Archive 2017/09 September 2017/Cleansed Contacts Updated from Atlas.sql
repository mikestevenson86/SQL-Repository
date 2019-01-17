IF OBJECT_ID('tempdb..#Mels') IS NOT NULL
	BEGIN
		DROP TABLE #Mels
	END

IF OBJECT_ID('tempdb..#Mikes') IS NOT NULL
	BEGIN
		DROP TABLE #Mikes
	END

SELECT ch.Id, ch.ContactId, u.Name, Field, ch.CreatedDate
INTO #Mels
FROM Salesforce..ContactHistory ch
inner join Salesforce..[User] u ON ch.CreatedById = u.Id
inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
WHERE uMan.Name = 'Melanie Johnston' or u.Name = 'Melanie Johnston' or u.Name = 'Carl Lord'

SELECT ch.Id, ch.ContactId, u.Name, Field, ch.CreatedDate
INTO #Mikes
FROM Salesforce..ContactHistory ch
inner join Salesforce..[User] u ON ch.CreatedById = u.Id
inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
WHERE u.Name = 'Mike Stevenson'

SELECT ml.Name, ml.ContactID, ml.CreatedDate, mk.CreatedDate, ch.Field, ch.OldValue, ch.NewValue, 
c.Salutation, c.FirstName, c.LastName, c.Phone, c.Email
FROM #Mels ml
left outer join Salesforce..Contact c ON ml.ContactId = c.Id
left outer join Salesforce..ContactHistory ch ON ml.Id = ch.Id
left outer join #Mikes mk ON ml.ContactId = mk.ContactId
							and ml.Field = mk.Field
WHERE mk.CreatedDate > ml.CreatedDate and ml.Field in ('FirstName','LastName','Email')