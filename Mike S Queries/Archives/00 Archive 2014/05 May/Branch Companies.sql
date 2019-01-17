use Salesforce

SELECT l.id, l.Company, l.[status], l.Suspended_Closed_Reason__c
FROM Lead l
WHERE 
			Company like '%The%Princes%Trust%' or
			Company like '%Bolton%Metropolitan%Borough%Council%' or
			Company like '%Victim%Support%' or
			Company like '%Harvey%Thompson%Ltd%' or
			Company like '%P C%World%' or
			Company like '%PC%World%' or
			Company like '%Royal%Mail%Group%' or
			Company like '%Kwik%Fit%' or
			Company like '%Reed%Employment%PLC%' or
			Company like '%American%Golf%Ltd%' or
			Company like '%The%Money%Shop%' or
			Company like '%Mencap%' or
			Company like '%The%Co-operative%food%' or
			Company like '%Currys%' or
			Company like '%Learn%Direct%' or
			Company like '%Hays%Specialist%Recruitment%' or
			Company like '%Jewson%' or
			Company like '%Holland%and%Barrett%' or
			Company like '%The%Body%Shop%' or
			Company like '%Bedfordshire%Police%' or
			Company like '%Manpower%' or
			Company like '%Royal%Mail%' or
			Company like '%Perrys%' or
			Company like '%Autoglass%' or
			Company like '%Sun%Valley%Amusements%' or
			Company like '%Heaven%v%' or
			Company like '%Age%Uk%' or
			Company like '%Nandos%'or 
			Company like '%H%M%Prison%'or
			Company like '%JobCente%Plus%'
		  OR Company LIKE '%KFC%'
          OR Company LIKE '%McDonalds%'
          OR Company LIKE '%burger%king%'
          OR Company LIKE '%subway%'
          OR Company LIKE '%specsavers%'
          OR Company LIKE '%boots%'
          OR Company LIKE '%optical%express%'
          OR Company LIKE '%vision%express%'
          OR Company LIKE '%premier%inn%'
          OR Company LIKE '%holiday%inn%'
          OR Company LIKE '%tesco%'
          OR Company LIKE '%asda%'
          OR Company LIKE '%morrisons%'
          OR Company LIKE '%sainsburys%'
          OR Company LIKE '%asda%'
          OR Company LIKE '%waitroes%'
          --OR Sector__c LIKE'%Probation%'
          OR Company LIKE '%Probation%'
          OR Company LIKE '%HMP%'
          OR Company LIKE '%waitrose%'
ORDER BY Suspended_Closed_Reason__c