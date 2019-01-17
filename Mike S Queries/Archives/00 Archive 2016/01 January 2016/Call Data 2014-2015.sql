SELECT
[SFDC ID],
TSR,
Agent,
TelNumber,
Conversion,
[SIC Code 3],
sc.SIC3_Description [SIC Description 3],
[Citation Sector],
[Client Position],
CallDateTime [Call Date and Time],
CallCategory  [Call Category],
time_connect [Call Length],
time_hold [Hold Length]
FROM
(
	SELECT 
	l.Id [SFDC ID], 
	TSR,
	ISNULL(u.Name, ch.tsr) Agent, 
	'0'+CONVERT(VarChar,ch.areacode)+'-'+CONVERT(VarChar, ch.phone) TelNumber, 
	case when l.ConvertedAccountId is not null then 'Yes' else 'No' end Conversion,
	l.SIC2007_Code3__c [SIC Code 3],
	l.CitationSector__c [Citation Sector], 
	l.Position__c [Client Position],  
	act_date,
	act_time,
	CONVERT(VarChar, act_date, 103) + ' ' + case when LEN(act_time) = 5 then
	'0'+LEFT(CONVERT(VarChar, act_time),1)+':'+RIGHT(LEFT(CONVERT(VarChar, act_time),3),2)+':'+RIGHT(CONVERT(VarChar, act_time),2)
	else
	LEFT(CONVERT(VarChar, act_time),2)+':'+RIGHT(LEFT(CONVERT(VarChar, act_time),3),2)+':'+RIGHT(CONVERT(VarChar, act_time),2) 
	end CallDateTime, 
	ch.status + ' ' + ch.addi_status CallCategory, 
	time_connect, 
	time_hold

	FROM 
	SalesforceReporting..call_history ch
	left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
	left outer join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c

	WHERE 
	act_date between '2014-07-01' and '2014-09-30' and call_type in (0,2,4)

UNION

	SELECT
	l.Id [SFDC ID], 
	TSR,
	ISNULL(u.Name, ch.tsr) Agent,
	'0'+CONVERT(VarChar,ch.areacode)+'-'+CONVERT(VarChar, ch.phone) TelNumber,
	case when l.ConvertedAccountId is not null then 'Yes' else 'No' end Conversion,
	l.SIC2007_Code3__c [SIC Code 3],
	l.CitationSector__c [Citation Sector], 
	l.Position__c [Client Position],
	act_date, 
	act_time, 
	CONVERT(VarChar, act_date, 103) + ' ' + case when LEN(act_time) = 5 then
	'0'+LEFT(CONVERT(VarChar, act_time),1)+':'+RIGHT(LEFT(CONVERT(VarChar, act_time),3),2)+':'+RIGHT(CONVERT(VarChar, act_time),2)
	else
	LEFT(CONVERT(VarChar, act_time),2)+':'+RIGHT(LEFT(CONVERT(VarChar, act_time),3),2)+':'+RIGHT(CONVERT(VarChar, act_time),2) 
	end CallDateTime, 
	ch.status + ' ' + ch.addi_status CallCategory, 
	time_connect, 
	time_hold

	FROM 
	Enterprise..call_history ch
	left outer join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
	left outer join Salesforce..[User] u ON ch.tsr = u.DiallerFK__c

	WHERE 
	act_date between '2014-07-01' and '2014-09-30' and call_type in (0,2,4)
) detail
left outer join SalesforceReporting..SIC2007Codes sc ON detail.[SIC Code 3] = sc.SIC3_Code

ORDER BY act_date, act_time