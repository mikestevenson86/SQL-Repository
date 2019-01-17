SELECT 
case when SIC2007_Code3__c = 85200 then 'Primary School'
when SIC2007_Code3__c = 85310 then 'Secondary School'
when SIC2007_Code3__c = 85320 then 'Academy/Technical and Vocational Secondary School' else 'Other' end School,
[Status],
COUNT(id) Prospects

FROM 
Salesforce..Lead

WHERE 
SIC2007_Code2__c = 85 

GROUP BY 
case when SIC2007_Code3__c = 85200 then 'Primary School'
when SIC2007_Code3__c = 85310 then 'Secondary School'
when SIC2007_Code3__c = 85320 then 'Academy/Technical and Vocational Secondary School' else 'Other' end,
[status]

ORDER BY 
case when SIC2007_Code3__c = 85200 then 'Primary School'
when SIC2007_Code3__c = 85310 then 'Secondary School'
when SIC2007_Code3__c = 85320 then 'Academy/Technical and Vocational Secondary School' else 'Other' end,
[status]