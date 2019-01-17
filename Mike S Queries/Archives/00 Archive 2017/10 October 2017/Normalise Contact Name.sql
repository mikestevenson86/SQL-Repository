SELECT c.FirstName, UPPER(LEFT(c2.FirstName,1))+LOWER(SUBSTRING(c2.FirstName,2,LEN(c2.FirstName)))
FROM Salesforce..Contact c
inner join Salesforce..Contact c2 ON c.Id = c2.Id 
WHERE c.FirstName collate latin1_general_CS_AS <> UPPER(LEFT(c2.FirstName,1))+LOWER(SUBSTRING(c2.FirstName,2,LEN(c2.FirstName))) collate latin1_general_CS_AS

SELECT c.LastName, UPPER(LEFT(c2.LastName,1))+LOWER(SUBSTRING(c2.LastName,2,LEN(c2.LastName)))
FROM Salesforce..Contact c
inner join Salesforce..Contact c2 ON c.Id = c2.Id 
WHERE c.LastName collate latin1_general_CS_AS <> UPPER(LEFT(c2.LastName,1))+LOWER(SUBSTRING(c2.LastName,2,LEN(c2.LastName))) collate latin1_general_CS_AS