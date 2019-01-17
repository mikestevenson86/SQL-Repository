SELECT 
oc.ContractNumber OLD_ContractNumber, 
oc.StartDate OLD_ContractStartDate, 
oc.Contract_Value__c OLD_ContractValue, 
oc.Cancellation_Reason__c OLD_CancelReason, 
oc.Cancellation_Date__c OLD_CancelDate, 
oo.Name OLD_OpportunityName,
oo.Type OLD_OpportunityType,
oou.Name OLD_OppOwner,
ISNULL(oo.Amount, 0) + ISNULL(oo.FRA_Total_Amount__c, 0) + ISNULL(oo.XCD_PP_total__c, 0) + ISNULL(oo.XCD_HR_total__c, 0) + ISNULL(oo.XCD_HS_total__c, 0) OLD_OppValue,
nc.ContractNumber NEW_ContractNumber, 
nc.StartDate NEW_ContractStartDate, 
nc.Contract_Value__c NEW_ContractValue,
nc.Status NEW_Status,
o.Name NEW_OpportunityName, 
ou.Name NEW_OppOwner,
rt.Name NEW_OppRecordType, 
ISNULL(o.Amount, 0) + ISNULL(o.FRA_Total_Amount__c, 0) + ISNULL(o.XCD_PP_total__c, 0) + ISNULL(o.XCD_HR_total__c, 0) + ISNULL(o.XCD_HS_total__c, 0) NEW_OppValue,
o.Type NEW_OppType, 
a.Id AccountId,
a.Name AccountName, 
au.Name AccOwner

FROM 
Salesforce..Contract oc
left outer join Salesforce..Account a ON oc.AccountId = a.Id
left outer join Salesforce..Contract nc ON oc.AccountId = nc.AccountId
left outer join Salesforce..Opportunity o ON nc.Source_Opportunity__c = o.Id
left outer join Salesforce..Opportunity oo ON oc.Source_Opportunity__c = oo.Id
left outer join Salesforce..[User] oou ON oo.OwnerId = oou.Id
left outer join Salesforce..[User] ou ON o.OwnerId = ou.Id
left outer join Salesforce..[User] au ON a.OwnerId = au.Id
left outer join Salesforce..RecordType rt ON o.RecordTypeId = rt.Id

WHERE 
oc.Cancellation_Date__c is not null
and
nc.StartDate = oc.Cancellation_Date__c

ORDER BY
OLD_CancelDate