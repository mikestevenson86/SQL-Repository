SELECT l.Id, Company, FirstName, LastName, Position__c, TEXT_BDM__c BDM, Status, Suspended_Closed_Reason__c, [Nat Employees], 
SIC2007_Code3__c, SIC2007_Description3__c, CitationSector, Source__c, Data_Supplier__c
FROM Salesforce..Lead l 
inner join [LSAUTOMATION].LEADS_ODS.ml.MainDataSet ml ON l.Market_Location_URN__c collate latin1_general_CI_AS = ml.URN collate latin1_general_CI_AS
inner join [LSAUTOMATION].LEADS_ODS.dbo.LeadsSingleViewAuto lsv ON ml.URN = lsv.ML_URN
inner join SalesforceReporting..SIC2007Codes sc ON l.SIC2007_Code3__c = sc.SIC3_Code
WHERE Suspended_Closed_Reason__c in ('Under Criteria'/*,'Over Criteria','Sole Trader'*/) and Status in ('Closed','Suspended')
and Source__c in ('ML_Updates_FEB17','ML_Updates_MAR17')
--and ml.Update_Band in ('A','B')
and 
(
[Nat Employees] between 6 and 225 
or
(CitationSector__c = 'CLEANING' and [Nat Employees] between 4 and 225)
or
(CitationSector__c = 'DENTAL PRACTICE' and [Nat Employees] between 3 and 225)
or
(CitationSector__c = 'HORTICULTURE' and [Nat Employees] between 4 and 225)
or
(CitationSector__c = 'DAY NURSERY' and [Nat Employees] between 3 and 225)
or
(CitationSector__c like '%FUNERAL%' and [Nat Employees] between 3 and 225)
or
(CitationSector__c = 'PHARMACY' and [Nat Employees] between 3 and 225)
)
and
(
lsv.[ML_DATECREATED] > l.Status_Changed_Date__c or lsv.[ML_DATEUPDATED] > l.Status_Changed_Date__c
)
and ISNULL(sc.CitationSector,'') <> 'CARE' 
and TEXT_BDM__c in ('Angela Prior','Cormac McGreevey','William McFaulds','Dominic Miller','Scott Roberts','Alan Butler',
'Simon Burlison','Gary Smith','Marina Ashman')