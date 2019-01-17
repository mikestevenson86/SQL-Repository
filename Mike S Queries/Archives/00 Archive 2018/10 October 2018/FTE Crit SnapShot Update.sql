ALTER TABLE LeadChangeReview..Lead_SnapShots_May2018 ADD FTE_Crit__c varchar(5)

ALTER INDEX ALL ON LeadChangeReview..Lead_SnapShots_May2018 REBUILD

UPDATE LeadChangeReview..Lead_SnapShots_May2018 
SET FTE_Crit__c =
case when 
(
(FT_Employees__c >= 6 and FT_Employees__c <= 225)
or
(FT_Employees__c = 5 and TEXT_BDM__c in ('William McFaulds','Scott Roberts','Dominic Miller','Angela Prior','Cormac McGreevey'))
or
(CitationSector__c in ('CLEANING','HORTICULTURE','CARE') and FT_Employees__c >= 4 and FT_Employees__c <= 255)
or
(CitationSector__c in ('DENTAL PRACTICE','DAY NURSERY','FUNERAL SERVICES') and FT_Employees__c >= 3 and FT_Employees__c <= 225)
)
and
CitationSector__c <> 'EDUCATION'
and
Toxic_SIC__c <> 'true' then 'true' else 'false' end 