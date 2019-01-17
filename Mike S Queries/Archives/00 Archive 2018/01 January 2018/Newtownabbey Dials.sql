SELECT 
l.Id LeadId, 
l.Company,
u.Name Agent,
dl.Name DialList, 
t.NVMContactWorld__CW_Call_Start_Time__c CallStartTime,
t.NVMContactWorld__CW_Call_End_Time__c CallEndTime,
t.Status__c CallStatus,
t.Suspended_Close__c CallClosedReason,
l.Status CurrentStatus,
l.Suspended_Closed_Reason__c CurrentClosedReason

FROM 
Salesforce..Lead l
left outer join Salesforce..NVMStatsSF__NVM_Call_Summary__c nvm ON l.Id = nvm.NVMStatsSF__Related_Lead__c
left outer join Salesforce..[User] u ON nvm.NVMStatsSF__Agent__c = u.ID
left outer join Salesforce..Task t ON nvm.NVMStatsSF__TaskID__c = t.Id
left outer join Salesforce..NVMConnect__DialList__c dl ON t.NVMConnect__DialList__c = dl.Id

WHERE 
Source__c = 'ML_Events_Newtownabbey_20180104'
and
nvm.NVMStatsSF__Related_Lead__c is not null
and
u.Id is not null