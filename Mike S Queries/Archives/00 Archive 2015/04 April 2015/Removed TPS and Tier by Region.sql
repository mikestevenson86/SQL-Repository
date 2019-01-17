SELECT 

case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end Region,
Source__c,
COUNT(l.Id)
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..UserRole ur ON u.UserRoleId = ur.Id
WHERE Source__c in ('Removed TPS','Removed Tier 4') and
(SIC2007_Code3__c in
(
'1110',
'1190',
'1410',
'1500',
'1629',
'1630',
'2300',
'3120',
'9100',
'10110',
'10710',
'10810',
'10860',
'10890',
'10920',
'11020',
'11050',
'11111',
'13100',
'13300',
'13910',
'13923',
'13939',
'14120',
'14190',
'15110',
'17219',
'17230',
'17290',
'18121',
'18129',
'18130',
'18203',
'20150',
'20200',
'20301',
'20420',
'20590',
'23190',
'23320',
'23410',
'23420',
'23490',
'23520',
'23610',
'23690',
'24100',
'24420',
'25110',
'25500',
'25720',
'25730',
'25990',
'26110',
'26309',
'26400',
'26511',
'26702',
'27120',
'27400',
'27510',
'27900',
'28230',
'28250',
'28290',
'28301',
'28990',
'30920',
'31010',
'31020',
'31090',
'32120',
'32300',
'32990',
'33120',
'33200',
'36000',
'37000',
'38210',
'38320',
'41100',
'41202',
'42990',
'43210',
'43220',
'43290',
'43320',
'43330',
'43341',
'43342',
'43999',
'49319',
'49320',
'49390',
'49410',
'49420',
'51210',
'52103',
'52219',
'52220',
'52230',
'52243',
'52290',
'53100',
'55100',
'55202',
'55300',
'55900',
'56101',
'56102',
'56103',
'56210',
'56290',
'56301',
'56302',
'58190',
'59200',
'60200',
'61900',
'62012',
'62020',
'62090',
'63110',
'64191',
'64192',
'64929',
'64999',
'65202',
'66190',
'66290',
'68202',
'68209',
'68310',
'68320',
'69102',
'69109',
'69201',
'69202',
'69203',
'70210',
'70229',
'71111',
'71112',
'71121',
'71122',
'71129',
'72200',
'73110',
'73200',
'74100',
'74209',
'75000',
'84110',
'84120',
'84210',
'84220',
'84230',
'84240',
'84250',
'85100',
'85200',
'85310',
'85422',
'85530',
'85590',
'86101',
'86102',
'86220',
'86230',
'86900',
'87900',
'88990',
'90030',
'90040',
'91011',
'91012',
'91020',
'91030',
'92000',
'93110',
'93120',
'93130',
'93199',
'93210',
'93290',
'94110',
'94120',
'94200',
'94910',
'94920',
'94990',
'95110',
'95220',
'95230',
'95240',
'96010',
'96020',
'96030',
'96040',
'96090',
'97000',
'99000'
) or SIC2007_Code__c in ('G','N')
) and (RecordTypeId = '012D0000000NbJsIAK' or RecordTypeId is null)
GROUP BY
case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end,
Source__c