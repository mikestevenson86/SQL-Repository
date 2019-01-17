IF OBJECT_ID('SalesforceReporting..CurrentState') IS NOT NULL
	BEGIN
		DROP TABLE SalesforceReporting..CurrentState
	END

SELECT 
l.Id,
ISNULL(rt.Name, '') RecordType, 
case when ISNULL(SIC2007_Code3__c, 0)  in 
(
	1629,20130,20140,20150,20160,20200,20301,42120,43110,47300,49100,49200,64910,49311,64921,49319,64922,49320,64192,64110,64205,64191,69101,69102,69109,
	80300,81223,86101,86210,94910,50100,50200,50300,50400,51220,9100,52211,99999,84210,84220,84230,84240,84250,84300,86220,90040,91011,91012,91020,91030,
	91040,93120,93130,93191,93199,93210,93290,5101,5102,5200,6100,6200,7100,7210,7290,8110,8120,8910,8920,8930,8990,9100,9900,35110,35120,35130,35140,
	35210,35220,35230,35300,36000,37000,38110,38120,38210,38220,38310,38320,39000,55100,55201,55202,55209,55300,55900,56101,56102,56103,56210,56290,56301,
	56302,64110,64191,64192,64201,64202,64203,64204,64205,64209,64301,64302,64303,64304,64305,64306,64910,64921,64922,64929,64991,64992,64999,65110,65120,
	65201,65202,65300,66110,66120,66190,66210,66220,66290,66300
) then 'Yes' else 'No' end ToxicSIC,
ISNULL(FT_Employees__c, 0) FT_Employees__c,
ISNULL(CitationSector__c, '') CitationSector__c,
ISNULL(SIC2007_Code3__c, 0) SIC2007_Code3__c,
ISNULL(OwnerId, '') OwnerId,
ISNULL(l.Phone, '') Phone,
ISNULL(IsTPS__c, '') IsTPS__c,
ISNULL(LeadSource, '') LeadSource

INTO
SalesforceReporting..CurrentState

FROM
Salesforce..Lead l
left outer join Salesforce..RecordType rt ON l.RecordTypeId = rt.Id
left outer join Salesforce..[User] u ON l.OwnerId = u.Id