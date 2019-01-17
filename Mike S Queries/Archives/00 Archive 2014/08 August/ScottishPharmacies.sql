		SELECT 
		l.Id

		INTO 
		#ScotLeads

		FROM 
		Salesforce..Lead l

		WHERE 
		(
		PostalCode like 'AB%' or
		PostalCode like 'DD%' or
		PostalCode like 'DG%' or
		PostalCode like 'EH%' or
		PostalCode like 'FK%' or
		PostalCode like 'G1%' or
		PostalCode like 'G2%' or
		PostalCode like 'G3%' or
		PostalCode like 'G4%' or
		PostalCode like 'G5%' or
		PostalCode like 'G6%' or
		PostalCode like 'G7%' or
		PostalCode like 'G8%' or
		PostalCode like 'G9%' or
		PostalCode like 'HS%' or
		PostalCode like 'IV%' or
		PostalCode like 'KA%' or
		PostalCode like 'KW%' or
		PostalCode like 'KY%' or
		PostalCode like 'ML%' or
		PostalCode like 'PA%' or
		PostalCode like 'PH%' or
		PostalCode like 'TD%' or
		PostalCode like 'ZE%'
		) and 
		SIC2007_Code3__c in ('26701','46460','47730','47749','21100','21200')

		SELECT
		detail.lm_filler2 SFDC_Id, 
		SUM(detail.Records) Calls

		INTO
		#Temp

		FROM
		(
		SELECT 
		ch1.lm_filler2, COUNT(ch1.seqno) Records
		FROM 
		Enterprise..call_history ch1
		inner join #ScotLeads sl ON ch1.lm_filler2 collate latin1_general_CS_AS = sl.Id collate latin1_general_CS_AS
		WHERE act_date >= '2014-07-14' and call_type in (0,2,4)
		GROUP BY 
		ch1.lm_filler2
		UNION
		SELECT 
		ch2.lm_filler2, COUNT(ch2.seqno) Records
		FROM 
		SalesforceReporting..call_history ch2
		inner join #ScotLeads sl ON ch2.lm_filler2 collate latin1_general_CS_AS = sl.Id collate latin1_general_CS_AS
		WHERE act_date >= '2014-07-14' and call_type in (0,2,4)
		GROUP BY 
		ch2.lm_filler2
		) detail
		GROUP BY 
		detail.lm_filler2

		SELECT 
		l.Id SFDC_Id, 
		l.Company, l.Street + ', ' + l.City + ', ' + l.PostalCode [Address], 
		l.SIC2007_Code3__c [SIC Code], 
		l.SIC2007_Description3__c [SIC Code Description],
		t.Calls

		FROM 
		Salesforce..Lead l

		inner join #Temp t ON l.Id collate latin1_general_CS_AS = t.SFDC_Id collate latin1_general_CS_AS

		DROP TABLE #ScotLeads
		DROP TABLE #Temp