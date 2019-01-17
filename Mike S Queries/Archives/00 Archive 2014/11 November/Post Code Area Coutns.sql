SELECT LEFT(PostalCode,CHARINDEX(' ',PostalCode)) PostCodeArea, COUNT(Id) Prospects
FROM Salesforce..Lead
WHERE PostalCode like 'PE%'
GROUP BY LEFT(PostalCode,CHARINDEX(' ',PostalCode))
