-- NVM Agent Summary for Yesterday
SELECT u.Name, (NVMStatsSF__Inbound_Call_Time__c + NVMStatsSF__Outbound_Call_Time__c)/60 Total, 
NVMStatsSF__Inbound_Call_Time__c, NVMStatsSF__Outbound_Call_Time__c, 
NVMStatsSF__Inbound_Call_Time__c + NVMStatsSF__Outbound_Call_Time__c Total
FROM Salesforce..NVMStatsSF__NVM_Agent_Summary__c nvm
inner join Salesforce..[User] u ON nvm.NVMStatsSF__Agent__c = u.Id
WHERE CONVERT(date, nvm.NVMStatsSF__Date__c) = '2018-01-23'
ORDER BY u.Name

-- NVM Call Summary for Yesterday
SELECT u.Name, SUM(nvm.NVMStatsSF__Agent_Talk_Time__c)/60 TotalTalkTime, SUM(nvm.NVMStatsSF__Agent_Talk_Time__c), 
SUM(nvm.NVMStatsSF__Total_Call_Duration__c)/60 TotalCallTime
FROM Salesforce..NVMStatsSF__NVM_Call_Summary__c nvm
inner join Salesforce..[User] u ON nvm.NVMStatsSF__Agent__c = u.Id
WHERE CONVERT(date, NVMStatsSF__CallTime__c) = '2018-01-23'
GROUP BY u.Name
ORDER BY u.Name

-- Tasks for Yesterday that are completed, and call type is Inbound or Outbound (as per criteria used for linked report in Amanda's Talk Time doc)
SELECT u.Name, SUM(t.CallDurationInSeconds)/60
FROM Salesforce..Task t
inner join Salesforce..[User] u ON t.OwnerId = u.Id
WHERE CONVERT(date, t.NVMContactWorld__CW_Call_Start_Time__c) = '2018-01-23' and CallType in ('Outbound','Inbound') and t.Status = 'Completed'
GROUP BY u.Name
ORDER BY u.Name