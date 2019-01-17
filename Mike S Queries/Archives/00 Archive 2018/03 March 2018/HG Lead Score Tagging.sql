exec Salesforce..SF_Refresh 'Salesforce','Lead'

SELECT l.Id Lead_Id, l.TEXT_BDM__c BDM, h.ELTV, 0 Processed, ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY h.ELTV desc) Ranking
FROM HGLeadScoring..LeadScores H
LEFT OUTER JOIN Salesforce..Lead L on H.Lead_ID = L.Id
LEFT OUTER JOIN Salesforce..RecordType T on L.RecordTypeId = T.Id 
WHERE 
L.IsConverted = 'false'
/*
and 
T.Name IN
(
	'Citation Cross Sell',
	'Citation Employee Referral Record',
	'Citation Partner Referral',
	'Citation Referral Record',
	'Citation Upsell Client',
	'Citation Winback Client',
	'Default Citation Record Type'
)
and 
status in ('Appointment','Data Quality','Pended')
*/
and 
l.TEXT_BDM__c in ('Justin McCormick','Alan Butler','Jason Emanuel','Alastair Stevens')

--Refinement of 98 k begins here!!!!

--Is Default Citation and Open
and RecordTypeId = '012D0000000NbJsIAK'
and Status = 'open'

--Not matching list of 62 Toxic SIC Codes
and
(
SIC2007_Code3__c is null 
or 
SIC2007_Code3__c not in
	(
		'1629','20130','20140','20150','20160','20200','35110','35120','35130','35140','35210','35220','35230','35300','36000','37000','38110','38120',
		'38220','38310','38320','39000','42120','43110','47300','49100','49200','49311','49319','49320','50100','50200','50300','50400','51220','52211',
		'55202','55209','55300','64110','64191','64192','69101','69102','69109','80300','84210','84220','84230','84240','84250','84300','86101','86210',
		'90040','91011','91012','91020','91030','91040','94910','99999'
	)
)

--Lead Source is not Cross Sell
and isnull(LeadSource,'') not like '%cross sell - Citation%'
and isnull(LeadSource,'') not like '%cross sell - qms%'

--Record has a BDM Assigned
and ISNULL(TEXT_BDM__c, '') not in 
(
	'Unassigned BDM', 'Salesforce Admin', '', 'Jaquie Watt', 'Jo Brown', 'Justin Robinson', 'Louise Clarke', 'Mark Goodrum', 'Matthew Walker', 
	'Mike Stevenson', 'Peter Sherlock', 'Susan Turner', 'Tushar Sanghrajka'
)

--Citation Sector is Not Education
and isnull(CitationSector__c,'') <> 'EDUCATION' 

--Is Within FTE & Sector/Area criteria
and           
(
              
              (FT_Employees__c between 6 and 225 )
              or (FT_Employees__c between 5 and 225 and (TEXT_BDM__c = 'WILLIAM MCFAULDS' OR TEXT_BDM__c = 'SCOTT ROBERTS' OR TEXT_BDM__c = 'DOMINIC MILLER'))
              or (FT_Employees__c between 6 and 225 and (TEXT_BDM__c = 'GARY SMITH'))
              or (FT_Employees__c between 10 and 225 and (SIC2007_Code3__c in (56101,55900,55100,56302)))
              or (FT_Employees__c between 4 and 225 and (isnull(CitationSector__c,'') in ('cleaning','HORTICULTURE')))
              or (FT_Employees__c between 3 and 225 and (isnull(CitationSector__c,'') in ('DAY NURSERY')))
              or (FT_Employees__c between 3 and 225 and (isnull(CitationSector__c,'') like +'%FUNERAL%'))
                         
)

--Is not flagged/excluded as a Toxic record, unless it is 10+FTE in Accomodation Citation Sector
and ((Toxic_SIC__c <> 'true') or (Toxic_SIC__c = 'true' and CitationSector__c = 'accomodation' and (SIC2007_Code3__c in ('55100','56101','26302') and (FT_Employees__c between 10 and 225))  ))

--Is Not flagged as TPS/CTPS
and isnull(IsTPS__c,'') <> 'yes'

--Has a SIC Code
and isnull(SIC2007_Code3__c,0) <> 0

--Has a Phone number
and (isnull(Phone,'') <> ' ' and isnull(Phone,'') <> '')
