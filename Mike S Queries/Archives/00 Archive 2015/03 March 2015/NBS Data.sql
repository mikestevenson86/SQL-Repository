SELECT Id, Company, Name, Street, City, State, Country, PostalCode, Phone, Email, Website, 
case when af.Sector = 'Care' then 'Care'
when af.Sector = 'Engineering' then 'Engineering'
when l.SIC2007_Code__c = 'C' then 'Manufacturing'
when l.SIC2007_Code__c = 'F' then 'Construction'
when af.Sector = 'HTA' then 'Landscaping'
when af.Sector = 'BICS' then 'Cleaning' end Type,
SIC2007_Code__c, SIC2007_Description__c, SIC2007_Code2__c, SIC2007_Description2__c, SIC2007_Code3__c, SIC2007_Description3__c

FROM Salesforce..Lead l
left outer join SalesforceReporting..AffinitySICCodes af ON l.SIC2007_Code3__c = af.[SIC Code 2007]

WHERE 
(af.Sector in ('Care','Engineering','BICS','HTA') or l.SIC2007_Code__c in ('C','F'))
and
FT_Employees__c between 5 and 100
and
Suspended_Closed_Reason__c not in ('Do Not Call','Ceased Trading','Duplicate','Branch','Local Authority','Sole Trader')
and
LEFT(l.PostalCode, 2) in ('SK','S1','S2','S3','S4','S5','S6','S7','S8','S9','DE','ST','CW','WA','M1','M2','M3','M4','M5','M6','M7','M8','M9','OL','HD')