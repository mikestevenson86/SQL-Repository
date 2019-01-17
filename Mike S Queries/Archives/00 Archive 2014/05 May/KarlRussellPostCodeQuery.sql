SELECT outcode__c, COUNT(id) records
FROM Salesforce..Lead
WHERE
PostalCode like 'AB%' or
PostalCode like 'IV%' or
PostalCode like 'DD%' or
PostalCode like 'PH%' or
PostalCode like 'KY%' or
PostalCode like 'FK%' or
PostalCode like 'EH%' or
PostalCode like 'ML%' or
PostalCode like 'G1%' or
PostalCode like 'G2%' or
PostalCode like 'G3%' or
PostalCode like 'G4%' or
PostalCode like 'G5%' or
PostalCode like 'G6%' or
PostalCode like 'G7%' or
PostalCode like 'G8%' or
PostalCode like 'G9%' or
PostalCode like 'PA%' or
PostalCode like 'KA%' or
PostalCode like 'DG%' or
PostalCode like 'TD%'
GROUP BY OutCode__c
ORDER BY OutCode__c