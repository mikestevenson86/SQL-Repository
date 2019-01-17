SELECT Id, 
case when Area_Code__c in ('AB','DD','DG','EH','FK','G','HS','IV','KA','KW','KY','ML','PA','PH','TD','ZE') then 'Scotland'
when Area_Code__c = 'BT' then 'Northern Ireland'
when Area_Code__c in ('CF','LD','LL','NP','SA','SY') then 'Wales' else 'England' end Country
FROM Salesforce..Lead
WHERE (Country not in ('England','Scotland','Wales','Northern Ireland') or Country is null) and Status <> 'Approved'