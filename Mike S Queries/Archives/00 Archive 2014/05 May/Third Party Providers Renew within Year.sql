SELECT id,Current_Third_Party_Product__c [Current Provider], CONVERT(char(10),Renewal_Date__c,126) [Renewal Date]
FROM Salesforce..Lead
WHERE Current_Third_Party_Product__c <> 'none' and Renewal_Date__c <= GETDATE()+365 and Renewal_Date__c >=GETDATE()
ORDER BY Renewal_Date__c