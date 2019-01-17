
Select SalesforceID_18char__c, Market_Location_URN__c, Co_Reg__c ,Company,PostalCode, Phone, TEXT_BDM__c, CitationSector__c, ML_Business_Type__c ,Status, Suspended_Closed_Reason__c, FT_Employees__c, SIC2007_Code3__c,Source__c, Data_Supplier__c
From Salesforce..Lead
where
RecordTypeId = '012D0000000NbJsIAK'
and status not in ('Approved', 'Pended','Data Quality')  
--and Phone is not null
--order by Phone asc

and 
(
(phone = '0')
or
(phone like '% %')
or
(phone like '%0 %')
or
(phone like '010%')
or
(phone like '00%')
or
(Phone like '1%' or Phone like '2%' or Phone like '3%' or Phone like '4%' or Phone like '5%' or Phone like '6%' or Phone like '7%' or Phone like '8%' or Phone like '9%' ) 
or
(Phone like '%(%' or Phone like '%)%' or Phone like '%-%' or Phone like '%+%' or Phone like '%/%' or Phone like '%?%' or Phone like '%.%')
or 
(Phone like '%a%' or Phone like '%b%' or Phone like '%c%' or Phone like '%d%' or Phone like '%e%' or Phone like '%f%' or Phone like '%g%' or Phone like '%h%' or Phone like '%i%' or Phone like '%j%' or
Phone like '%k%' or Phone like '%l%' or Phone like '%m%' or Phone like '%n%' or Phone like '%o%' or Phone like '%p%' or Phone like '%q%' or Phone like '%r%' or Phone like '%s%' or Phone like '%t%' or
Phone like '%u%' or Phone like '%v%' or Phone like '%w%' or Phone like '%x%' or Phone like '%y%' or Phone like '%z%')


)
