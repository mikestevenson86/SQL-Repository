SELECT Area_Code__c, COUNT(ID) Prospects
FROM Salesforce..Lead
WHERE 
/*(
PostalCode like 'SK%'
or PostalCode like 'WA%' 
or PostalCode like 'M1%'
or PostalCode like 'M2%'
or PostalCode like 'M3%'
or PostalCode like 'M4%'
or PostalCode like 'M5%'
or PostalCode like 'M6%'
or PostalCode like 'M7%'
or PostalCode like 'M8%'
or PostalCode like 'M9%'
) and */SIC2007_Code3__c in ('85100','88910') and Status = 'Open'
GROUP BY Area_Code__c
ORDER BY Prospects DESC

SELECT Area_Code__c, COUNT(ID) Prospects
FROM Salesforce..Lead
WHERE 
/*(
PostalCode like 'SK%'
or PostalCode like 'WA%' 
or PostalCode like 'M1%'
or PostalCode like 'M2%'
or PostalCode like 'M3%'
or PostalCode like 'M4%'
or PostalCode like 'M5%'
or PostalCode like 'M6%'
or PostalCode like 'M7%'
or PostalCode like 'M8%'
or PostalCode like 'M9%'
) and */SIC2007_Code3__c in ('86102','87100','87200','87300','87900','88990') and Status = 'Open'
GROUP BY Area_Code__c
ORDER BY Prospects DESC