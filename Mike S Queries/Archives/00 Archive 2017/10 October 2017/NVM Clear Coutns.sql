SELECT 
l.Id,
0 InboundCallCount__c,
0 OutboundCallCount__c,
0 OutboundAnswerMachineCallCount__c,
0 OutboundDisconnectCallCount__c,
0 OutboundBusyCount__c,
0 OutboundNoAnswerCount__c,
0 OutboundDMUnavailableCount__c,
0 OutboundGKCount__c
FROM Salesforce..Lead l
inner join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
WHERE
rt.Name = 'Default Citation Record Type' and
(
InboundCallCount__c is null or
OutboundCallCount__c is null or
OutboundAnswerMachineCallCount__c is null or
OutboundDisconnectCallCount__c is null or
OutboundBusyCount__c is null or
OutboundNoAnswerCount__c is null or
OutboundDMUnavailableCount__c is null or
OutboundGKCount__c is null
) 
and Status not in ('Approved','Data Quality','Pended')
and ISNULL(LeadSource,'') not in
(
'Web (Imp Guide)',
'Web (Auto-Quote)',
'Web (Call back Form)',
'Web (Incoming Call)',
'Client Referral (Voucher)',
'Client Referral (Wine)',
'Ref_Emp_QMS',
'Canvassing (Self-Generated)',
'Existing (Appointment)',
'Existing (Sales Visit)',
'Website',
'PPC'
) 
and TEXT_BDM__c in ('Mark Kelsall','Gary Smith')