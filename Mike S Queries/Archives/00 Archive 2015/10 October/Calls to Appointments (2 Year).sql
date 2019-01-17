SELECT 
SIC2007_Code__c, 
COUNT(Id) Appts

INTO 
#Appts

FROM 
Salesforce..Lead

WHERE 
Date_Made__c >= DATEADD(Year,-1,GETDATE()) 
and 
MADE_Criteria__c in ('Inbound  - 1','Inbound  - 2','Inbound  - 4','Outbound - 1','Outbound - 2','Outbound - 4','Seminars - Appointment')

GROUP BY 
SIC2007_Code__c

--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
detail.SIC2007_Code__c [SIC Code 1], 
sc.Description, 
SUM(Calls) Calls, 
ap.Appts

FROM
	(
	SELECT SIC2007_Code__c, COUNT(seqno) Calls
	FROM Enterprise..call_history ch
	inner join Salesforce..Lead l ON LEFT(lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
	WHERE call_type in (0,2,4) and act_date >= DATEADD(Year,-1,GETDATE())
	GROUP BY SIC2007_Code__c
	UNION
	SELECT SIC2007_Code__c, COUNT(seqno) Calls
	FROM SalesforceReporting..call_history ch
	inner join Salesforce..Lead l ON LEFT(lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
	WHERE call_type in (0,2,4) and act_date >= DATEADD(Year,-1,GETDATE())
	GROUP BY SIC2007_Code__c
	) detail
	
left outer join #Appts ap ON detail.SIC2007_Code__c= ap.SIC2007_Code__c
inner join SalesforceReporting..SIC1 sc ON detail.SIC2007_Code__c = sc.[SIC Code 1]

GROUP BY 
detail.SIC2007_Code__c, 
sc.Description, 
ap.Appts

ORDER BY 
detail.SIC2007_Code__c

DROP TABLE #Appts