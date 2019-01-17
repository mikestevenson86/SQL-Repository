SELECT u.id
FROM Salesforce..[User] u
WHERE u.Name = 'Dean Davies'

SELECT l.id, '005D00000038wGNIAY' ownerid
FROM Salesforce..Lead l
inner join Salesforce..[User] u on l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE u.Name <> 'Dean Davies' and (
l.PostalCode like 'OX5 %' or
l.PostalCode like 'OX6 %' or
l.PostalCode like 'OX7 %' or
l.PostalCode like 'OX15%' or
l.PostalCode like 'OX16%' or
l.PostalCode like 'OX17%' or
l.PostalCode like 'OX18%' or
l.PostalCode like 'OX20%' or
l.PostalCode like 'OX25%' or
l.PostalCode like 'OX26%' or
l.PostalCode like 'OX27%' or
l.PostalCode like 'OX28%')