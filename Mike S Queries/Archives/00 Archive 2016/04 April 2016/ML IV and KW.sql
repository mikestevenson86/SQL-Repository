SELECT [URN] Prospect_External_Id__c
      ,[Business Name] Company
      ,[Address Line 1] + ' ' + [Address Line 2] + ' ' + [Locality] Street
      ,[Town] City
      ,[County] State
      ,[Postcode] PostalCode
      ,[Telephone Number] Phone
      ,case when [tps] = 'Y' or [ctps] = 'Y' then 'Yes' else 'No' end IsTPS__c
      ,[Contact title] Salutation
      ,case when [Contact forename] = '' then 'BLANK' else [Contact forename] end FirstName
      ,case when [Contact surname] = '' then 'BLANK' else [Contact surname] end LastName
      ,[Contact position] Position__c
      ,[web address] Website
      ,[Nat Employees] FT_Employees__c
      ,sc.SIC_Code SIC2007_Code__c
      ,sc.SIC2_Description SIC2007_Description__c
      ,[UK 07 SIC Code 2 digit] SIC2007_Code2__c
      ,[UK 07 SIC Code 2 digit desc] SIC2007_Description2__c
      ,[UK 07 Sic Code] SIC2007_Code3__c
      ,[UK 07 Sic Desc] SIC2007_Description3__c
      ,case when [Contact email address] = '' then [company email address] else [Contact email address] end Email
FROM MarketLocation..citation_full_data_032016 c
left outer join SalesforceReporting..SIC2007Codes sc ON c.[UK 07 Sic Code] = sc.SIC3_Code
WHERE 
(
LEFT(Postcode, 4) in ('IV10','IV11','IV13','IV14','IV15','IV16','IV17','IV18','IV19','IV20','IV21','IV22','IV23','IV24',
'IV25','IV26','IV27','IV29','IV33','IV34','IV35','IV37','IV38','IV40','IV41','IV42','IV43','IV44','IV45','IV46','IV47','IV48','IV49',
'IV51','IV55','IV56') or
(
LEFT(PostCode, 2) = 'KW' and LEFT(PostCode, 4) not in ('KW14','KW15','KW16')
)
)
and
(
	(
	[Nat Employees] >= 5 and [Nat Employees] < 225 and c.[UK 07 SIC Code 2 digit] not in (35,36,37,38,39,5,55,56,6,64,65,66,7,8,84,9,90,91,92,93) 
	and c.ctps <> 'Y' and tps <> 'Y' and [UK 07 Sic Code] not in (1629,91100,20130,20140,20150,20160,20200,203001,42120,43110,47300,49100,19200,49311,49319,49320,
	64110,64191,64192,64205,64910,64921,64922,69101,69102,69109,80300,81223,82200,86101,86210,94910,99999,50100,50200,50300,50400,51220,52211) 
	and [UK 07 Sic Code] <> ''
	) or
	(
	[Nat Employees] >= 4 and [Nat Employees] < 225 and c.ctps <> 'Y' and tps <> 'Y' and [UK 07 Sic Code] in (1130,1190,46220,46310,46610,81300,20412,81210,81221,81222,81291,81299,96010)
	) or
	(
	[Nat Employees] >= 3 and [Nat Employees] < 225 and c.ctps <> 'Y' and tps <> 'Y' and [UK 07 Sic Code] in (86230,96030,85100,88910,21100,46460,47730,75000)
	)
)