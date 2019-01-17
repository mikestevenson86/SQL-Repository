exec Salesforce..SF_Refresh 'Salesforce','Task'

SELECT l.Id, OutboundCallCount__c, COUNT(ncs.Id) Outbound_Calls
FROM Salesforce..Lead l
left outer join Salesforce..NVMStatsSF__NVM_Call_Summary__c ncs ON l.Id = ncs.NVMStatsSF__Related_Lead__c 
																and NVMStatsSF__Interaction_Type__c = 'Outbound Call' 
WHERE OutboundCallCount__c > 0
GROUP BY l.Id, OutboundCallCount__c
ORDER BY l.Id

SELECT l.Id, OutboundAnswerMachineCallCount__c, COUNT(t.Id) Outbound_AnswerMachine
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'Answer Machine' and Subject like 'Outbound call to%'
WHERE OutboundAnswerMachineCallCount__c > 0
GROUP BY l.Id, OutboundAnswerMachineCallCount__c
ORDER BY Id

SELECT l.Id, OutboundBusyCount__c, COUNT(t.Id) Outbound_Busy
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'Busy' and Subject like 'Outbound call to%'
WHERE OutboundBusyCount__c > 0
GROUP BY l.Id, OutboundBusyCount__c
ORDER BY l.Id

SELECT l.Id, OutboundDMUnavailableCount__c, COUNT(t.Id) Outbound_DMU
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'DMU' and Subject like 'Outbound call to%'
WHERE OutboundDMUnavailableCount__c > 0
GROUP BY l.Id, OutboundDMUnavailableCount__c
ORDER BY l.Id

SELECT l.Id, OutboundDisconnectCallCount__c, COUNT(t.Id) Outbound_Disconnect
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'Disconnect' and Subject like 'Outbound call to%'
WHERE OutboundDisconnectCallCount__c > 0
GROUP BY l.Id, OutboundDisconnectCallCount__c
ORDER BY l.Id

SELECT l.Id, OutboundGKCount__c, COUNT(t.Id) Outbound_GK
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'Gatekeeper Refusal' and Subject like 'Outbound call to%'
WHERE OutboundGKCount__c > 0
GROUP BY l.Id, OutboundGKCount__c
ORDER BY l.Id

SELECT l.Id, OutboundHoldDropCount__c, COUNT(t.Id) Outbound_HoldDrop
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'Busy' and Subject like 'Outbound call to%'
WHERE OutboundHoldDropCount__c > 0
GROUP BY l.Id, OutboundHoldDropCount__c
ORDER BY l.Id

SELECT l.Id, OutboundNoAnswerCount__c, COUNT(t.Id) Outbound_NoAnswer
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Suspended_Close__c = 'No Answer' and Subject like 'Outbound call to%'
WHERE OutboundNoAnswerCount__c > 0
GROUP BY l.Id, OutboundNoAnswerCount__c
ORDER BY l.Id

SELECT l.Id, InboundCallCount__c, COUNT(t.Id) Inbound_Calls
FROM Salesforce..Lead l
left outer join Salesforce..Task t ON l.Id = t.WhoId and Subject like 'Inbound Call from%'
WHERE InboundCallCount__c > 0
GROUP BY l.Id, InboundCallCount__c
ORDER BY l.Id