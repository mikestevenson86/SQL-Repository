		SELECT 
		Id [SFDC Id],
		'https://eu1.salesforce.com/'+Id [SFDC URL],
		Company [Company Name],
		Suspended_Closed_Reason__c [Suspended/Closed Reason],
		SIC2007_Code3__c [SIC Code Level 3],
		SIC2007_Description3__c [SIC Code Level 3 Description],
		FT_Employees__c [FT Employees],
		Total_Employees__c [Total Employees],
		Phone,
		PostalCode,
		Notes__c [SF Notes]
		
		FROM 
		Salesforce..Lead
		
		WHERE
		IsTps__c is null and
		[Status] = 'Closed' 
		and FT_Employees__c between 6 and 225
		and SIC2007_Code__c not in ('A','B','D','E','K','R')
		and SIC2007_Code3__c not in ('1629','9100','20150','20160','20200','20301','20412','35110','43110','47300','49100','49200','49311','49319')
		and SIC2007_Code3__c not in ('50100','50200','50300','50400','51211','64110','64191','69101','69102','69109','82200','86101','86210','99999')
		and Phone is not NULL
		and LEFT(PostalCode,4) not in ('EX31','EX33','EX34','EX35','EX39')
		and LEFT(PostalCode,4) not between 'PA20' and 'PA80'
		and LEFT(PostalCode,4) not between 'NP1' and 'NP20'
		and Area_Code__c not in ('KW','IV','BT','SA','LD','TR')