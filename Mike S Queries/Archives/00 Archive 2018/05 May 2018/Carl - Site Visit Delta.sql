exec Salesforce..SF_Refresh 'Salesforce','SiteVisit__c'

SELECT a.Name, sva.VisitNumber__c, sva.TypeOfVisit__c, sva.VisitDate__c, sva.Postcode, sv.Id, sv.CreatedDate
	
FROM SalesforceReporting..SiteVisitsALL sva
left outer join Salesforce..SiteVisit__c sv ON LEFT(sva.Account__c, 15) collate latin1_general_CS_AS = LEFT(sv.Account__c, 15) collate latin1_general_CS_AS
											and sva.AccountSite__c = sv.AccountSite__c
											and sva.MainContact__c = sv.MainContact__c
											and sva.Consultant__c = sv.Consultant__c
											and sva.VisitNumber__c = sv.VisitNumber__c
											and sva.VisitDate__c = sv.VisitDate__c
											and sva.TypeOfVisit__c = sv.TypeOfVisit__c
left outer join Salesforce..Account a ON LEFT(sva.Account__c, 15) collate latin1_general_CS_AS = LEFT(a.Id, 15) collate latin1_general_CS_AS
WHERE sva.Account__c is not null and sva.AccountSite__c is not null and sva.MainContact__c is not null and sva.Consultant__c is not null 
and sva.VisitDate__c >= '2018-05-21'
and a.Name + '|' + sva.TypeOfVisit__c + '|' + CONVERT(VarChar,sva.VisitDate__c,103) + '|' + sva.VisitNumber__c in
(
'Cambrian Marketing Ltd & Severn Vision Ltd t/a Three-Sixty & Calotherm|H&S|14/05/2018|2nd Visit',
'Innerglass Ltd incorporating London Bar & Kitchen Ltd|H&S|21/05/2018|1st Visit',
'Woodward & Taylor Ltd|H&S|21/05/2018|1st Visit',
'Woodward & Taylor Ltd|H&S|21/05/2018|Install',
'ICAX Limited|H&S|21/05/2018|Install',
'Integra|PEL|21/05/2018|Telephone Install',
'Sarac Engineering LLP|H&S|21/05/2018|1st Visit',
'LMA Services Limited|H&S|21/05/2018|3rd Visit',
'Forever Independent Limited|H&S|21/05/2018|Install',
'In-house Care Services Ltd|PEL|21/05/2018|Install',
'Severino Ltd|H&S|21/05/2018|1st Visit',
'Wood Waste Recycling Limited|H&S|22/05/2018|3rd Visit',
'MTS Nationwide Limited|H&S|22/05/2018|1st Visit',
'MTS Nationwide Limited|H&S|22/05/2018|Install',
'Ravenswood Care Home|H&S|22/05/2018|3rd Visit',
'Hollowood Chemists Ltd|H&S|22/05/2018|5th Visit',
'David Drummond (Drummond Wools)|H&S|22/05/2018|3rd Visit',
'S & S Wines Ltd|H&S|22/05/2018|3rd Visit',
'N J E Cleaning Services Ltd|H&S|22/05/2018|Install',
'THS Industrial Textiles Limited|PEL|22/05/2018|1st Visit',
'Feel Fit Gym Ltd|H&S|22/05/2018|Install',
'Meadow Lodge Care Home|H&S|23/05/2018|5th Visit',
'P & R Services (Southampton) Ltd|H&S|23/05/2018|3rd Visit',
'S.Thorogood & Sons (Covent Garden) Ltd|H&S|23/05/2018|2nd Visit',
'Ferndale Care Services Limited|H&S|23/05/2018|1st Visit',
'K S E Services Ltd|H&S|23/05/2018|1st Visit',
'P E Jones & Partner|H&S|23/05/2018|2nd Visit',
'Lloyd Woodworking Ltd|H&S|23/05/2018|4th Visit',
'Cotswold Fasteners|H&S|23/05/2018|2nd Visit',
'The Grove PreSchool & Nursery|PEL|23/05/2018|Renewal Review - Visit',
'Home Matters Supporting People Ltd|H&S|23/05/2018|3rd Visit',
'Alarmtec Ltd|H&S|23/05/2018|2nd Visit',
'Links HVAC Ltd|H&S|23/05/2018|2nd Visit',
'Kingston Landscape Group Ltd|H&S|23/05/2018|Install',
'N Alderson Funeral Directors Limited|H&S|23/05/2018|Install',
'N Alderson Funeral Directors Limited|H&S|23/05/2018|Install',
'STQ Vantage|H&S|23/05/2018|4th Visit',
'Whitehall Landscapes & Groundcare Contractors Ltd|H&S|23/05/2018|1st Visit',
'Derek Rose Ltd|H&S|23/05/2018|3rd Visit',
'Neelam Hair & Beauty|H&S|23/05/2018|3rd Visit',
'Insight Health Limited|H&S|23/05/2018|2nd Visit',
'Grabserve Limited|PEL|23/05/2018|Install',
'Reward Manufacturing Co Ltd|H&S|23/05/2018|1st Visit',
'Hoghton Tower Ltd & Hoghton Tower Preservation Trust|H&S|23/05/2018|2nd Visit',
'Pear Tree Nursery|H&S|23/05/2018|2nd Visit',
'Quartex Components Ltd|PEL|23/05/2018|Install',
'TCHC LTD|PEL|23/05/2018|Telephone Install',
'JBT Leisure t/a The Portcullis|PEL|23/05/2018|Install',
'J D Roach (Builders) Ltd|H&S|23/05/2018|1st Visit',
'Fabwell Ltd|H&S|23/05/2018|Install',
'Vertex I.T Solutions Ltd|PEL|23/05/2018|1st Visit',
'Sidmouth Tyres & Exhausts Ltd|PEL|23/05/2018|Install',
'Whiterose Funerals and Memorials Ltd|H&S|23/05/2018|Install',
'Hyde Road Wheels & Tyres Ltd|PEL|23/05/2018|1st Visit',
'Evergreen Renewable Energy|H&S|24/05/2018|Install',
'Selhurst Timber Ltd|H&S|24/05/2018|3rd Visit',
'24 Productions Ltd|PEL|24/05/2018|Install',
'Good Kilter Limited|H&S|24/05/2018|Install',
'The Golf Hotel|PEL|24/05/2018|Telephone Install',
'Picturedrome Electric Theatre Co Ltd (Site 1)|H&S|24/05/2018|4th Visit',
'J S Environmental Ltd|H&S|24/05/2018|3rd Visit',
'S B Joinery UK Ltd|H&S|24/05/2018|3rd Visit',
'Deepwater EU Ltd|PEL|24/05/2018|Telephone Install',
'Deepwater EU Ltd|H&S|24/05/2018|Install',
'Belmar & Liston Funeral Directors|H&S|24/05/2018|1st Visit',
'Belmar & Liston Funeral Directors|H&S|24/05/2018|Install',
'Global Coal Ltd|H&S|24/05/2018|1st Visit',
'Realco Equipment Ltd|H&S|24/05/2018|4th Visit',
'Fridge Rentals Ltd|PEL|24/05/2018|Install',
'Bericote Park Ltd|PEL|24/05/2018|Telephone Install',
'Sterling Roofing Solutions Ltd|PEL|24/05/2018|Renewal Review - Visit',
'NRS Wastecare Ltd|PEL|24/05/2018|Install',
'Craig Engineering  (HX) Limited|H&S|24/05/2018|3rd Visit',
'Henleys Medical Supplies Ltd|H&S|24/05/2018|2nd Visit',
'The Faith Mission|H&S|24/05/2018|1st Visit',
'L W C Engineering Ltd|PEL|24/05/2018|Install',
'Matthew Wood Architects Ltd|H&S|24/05/2018|2nd Visit',
'Meon ltd.|H&S|24/05/2018|1st Visit',
'All Saints CEVA Primary School|H&S|24/05/2018|1st Visit',
'Venture Security Management Ltd|H&S|24/05/2018|Install',
'Project Three Automotive Ltd|H&S|24/05/2018|1st Visit',
'Aspull Electrical Services Ltd|H&S|24/05/2018|1st Visit',
'Mayfair Residential Home ltd|PEL|24/05/2018|1st Visit',
'Hampshire Property Maintenance Ltd|H&S|24/05/2018|1st Visit',
'British Promotional Merchandise Association Ltd|PEL|25/05/2018|Install'
)
ORDER BY sva.VisitDate__c, a.Name, sva.Postcode