IF OBJECT_ID('') IS NOT NULL
BEGIN
	DROP TABLE SalesforceReporting..Cisco_SFDC_Bridge
END

	SELECT Phone, RIGHT(Id,LEN(Id)-1) Id
	INTO SalesforceReporting..Cisco_SFDC_Bridge
	FROM
	(
		SELECT Phone, MIN([RANK]) Id
		FROM
		(
			SELECT CallingPhone Phone, '1'+MAX(l.ID) [RANK]
			FROM SalesforceReporting..Contact_Centre cc
			inner join Salesforce..Lead l ON REPLACE(case when cc.CallingPhone like '0%' then cc.CallingPhone else '0'+cc.CallingPhone end,' ','')
												= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
			GROUP BY CallingPhone
			UNION
			SELECT CallingPhone, '2'+MAX(l.ID) [RANK]
			FROM SalesforceReporting..Contact_Centre cc
			inner join Salesforce..Lead l ON REPLACE(case when cc.CallingPhone like '0%' then cc.CallingPhone else '0'+cc.CallingPhone end,' ','')
												= REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
			GROUP BY CallingPhone
			UNION
			SELECT CallingPhone, '3'+MAX(l.ID) [RANK]
			FROM SalesforceReporting..Contact_Centre cc
			inner join Salesforce..Lead l ON REPLACE(case when cc.CallingPhone like '0%' then cc.CallingPhone else '0'+cc.CallingPhone end,' ','')
												= REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
			GROUP BY CallingPhone
			UNION
			SELECT CalledPhone Phone, '1'+MAX(l.ID) [RANK]
			FROM SalesforceReporting..Contact_Centre cc
			inner join Salesforce..Lead l ON REPLACE(case when cc.CalledPhone like '0%' then cc.CalledPhone else '0'+cc.CalledPhone end,' ','')
												= REPLACE(case when l.Phone like '0%' then l.Phone else '0'+l.Phone end,' ','')
			GROUP BY CalledPhone
			UNION
			SELECT CalledPhone, '2'+MAX(l.ID) [RANK]
			FROM SalesforceReporting..Contact_Centre cc
			inner join Salesforce..Lead l ON REPLACE(case when cc.CalledPhone like '0%' then cc.CalledPhone else '0'+cc.CalledPhone end,' ','')
												= REPLACE(case when l.MobilePhone like '0%' then l.MobilePhone else '0'+l.MobilePhone end,' ','')
			GROUP BY CalledPhone
			UNION
			SELECT CalledPhone, '3'+MAX(l.ID) [RANK]
			FROM SalesforceReporting..Contact_Centre cc
			inner join Salesforce..Lead l ON REPLACE(case when cc.CalledPhone like '0%' then cc.CalledPhone else '0'+cc.CalledPhone end,' ','')
												= REPLACE(case when l.Other_Phone__c like '0%' then l.Other_Phone__c else '0'+l.Other_Phone__c end,' ','')
			GROUP BY CalledPhone
		) detail
		GROUP BY Phone
	) detail