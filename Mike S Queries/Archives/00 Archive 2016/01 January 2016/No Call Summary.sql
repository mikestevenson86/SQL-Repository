SELECT 
case when l.Phone is null or l.Phone = '' then 'No Phone'
when Toxic_SIC__c = 'false' or FT_Employees__c < 5 or FT_Employees__c > 225 or FT_Employees__c is null or SIC2007_Code3__c is null or
		LEFT(l.PostalCode,4)  between 'PA20' and 'PA80'
		or LEFT(l.PostalCode,4)  between 'NP21' and 'NP24'
		or LEFT(l.PostalCode,4)  between 'SA16' and 'SA99'
		or LEFT(l.PostalCode,4)  between 'IV10' and 'IV39'
		or LEFT(l.PostalCode,4)  between 'PO30' and 'PO41'
		or l.Area_Code__c in ('KW','BT','LD','ZE','GY','JE','IM','HS') then 'Out of Criteria'
when IsTPS__c = 'Yes' then 'TPS' 
when Suspended_Closed_Reason__c = 'Bad Company' or Suspended_Closed_Reason__c = 'Branch'
or l.Website  like '%.gov.uk%' or l.Email  like '%gov.uk%'
		
		or
		l.Website  like '%.nhs.uk%' or l.Email  like '%nhs.uk%'
		
		or
		l.Website  like '%.royalmail.co%' or l.Email  like '%royalmail.co%'
		
		or
		l.Website  like '%hpcha.org%' or l.Email  like '%hpcha.org%'
		
		or
		l.Website  like '%o2.co%' or l.Email  like '%o2.co%' then 'Bad Company'
end Reason,
COUNT(Id)
FROM Salesforce..Lead l
left outer join SalesforceReporting..call_history fv1 ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(fv1.lm_filler2,15) collate latin1_general_CS_AS and DATEPART(YEAR, fv1.act_date) = 2015
left outer join Enterprise..call_history fv2 ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(fv2.lm_filler2,15) collate latin1_general_CS_AS and DATEPART(YEAR, fv2.act_date) = 2015
left outer join SalesforceReporting..call_history fr1 ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(fr1.lm_filler2,15) collate latin1_general_CS_AS and DATEPART(YEAR, fr1.act_date) = 2014
left outer join Enterprise..call_history fr2 ON LEFT(l.Id, 15) collate latin1_general_CS_AS = LEFT(fr2.lm_filler2,15) collate latin1_general_CS_AS and DATEPART(YEAR, fr2.act_date) = 2014
WHERE (fv1.seqno is not null or fv2.seqno is not null) and fr1.seqno is null and fr2.seqno is null
GROUP BY 
case when l.Phone is null or l.Phone = '' then 'No Phone'
when Toxic_SIC__c = 'false' or FT_Employees__c < 5 or FT_Employees__c > 225 or FT_Employees__c is null or SIC2007_Code3__c is null or
		LEFT(l.PostalCode,4)  between 'PA20' and 'PA80'
		or LEFT(l.PostalCode,4)  between 'NP21' and 'NP24'
		or LEFT(l.PostalCode,4)  between 'SA16' and 'SA99'
		or LEFT(l.PostalCode,4)  between 'IV10' and 'IV39'
		or LEFT(l.PostalCode,4)  between 'PO30' and 'PO41'
		or l.Area_Code__c in ('KW','BT','LD','ZE','GY','JE','IM','HS') then 'Out of Criteria'
when IsTPS__c = 'Yes' then 'TPS' 
when Suspended_Closed_Reason__c = 'Bad Company' or Suspended_Closed_Reason__c = 'Branch'
or l.Website  like '%.gov.uk%' or l.Email  like '%gov.uk%'
		
		or
		l.Website  like '%.nhs.uk%' or l.Email  like '%nhs.uk%'
		
		or
		l.Website  like '%.royalmail.co%' or l.Email  like '%royalmail.co%'
		
		or
		l.Website  like '%hpcha.org%' or l.Email  like '%hpcha.org%'
		
		or
		l.Website  like '%o2.co%' or l.Email  like '%o2.co%' then 'Bad Company'
end