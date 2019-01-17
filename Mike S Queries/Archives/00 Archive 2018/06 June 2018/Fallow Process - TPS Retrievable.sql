SELECT 
l.Id, 
l.Company, 
l.PostalCode, 
l.Phone, 
l.MobilePhone, 
l.Other_Phone__c, 
l.Text_BDM__c, 
l.CitationSector__c, 
l.Status_Changed_Date__c,
l.FT_Employees__c, 
l.Status, 
l.Suspended_Closed_Reason__c, 
l.Source__c,
l.Data_Supplier__c,
case when 
RecordTypeId = '012D0000000NbJsIAK'
and 
Status = 'open'
and	
FTE_Crit__c = 'true'		 
and  
ISNULL(Callback_Date_Time__c,'') = ''  
and 
ISNULL(TEXT_BDM__c, '') not in 
(
	'',
	'Unassigned BDM',
	'Salesforce Admin',
	'Jaquie Watt', 
	'Jo Brown', 
	'Justin Robinson', 
	'Louise Clarke', 
	'Mark Goodrum', 
	'Matthew Walker', 
	'Mike Stevenson', 
	'Peter Sherlock', 
	'Susan Turner', 
	'Tushar Sanghrajka',
	'Adam Colaiuda',
	'Jenny Gregson'
)
and 
ISNULL(SIC2007_Code3__c,0) <> 0
and 
ISNULL(Toxic_SIC__c,'') <> 'true'
and 
ISNULL(LeadSource,'') not like '%cross sell - Citation%'
and 
ISNULL(LeadSource,'') not like '%cross sell - qms%'
and 
ISNULL(Source__c,'') not like '%LB_%'
and 
ISNULL(Source__c,'') not like '%CLOSED LOST%'
and 
ISNULL(Source__c,'') not like '%MARKETING LOST%'
and 
ISNULL(Source__c,'') not like '%TOXIC%'
and 
ISNULL(CitationSector__c, '') not in ('EDUCATION','DENTAL PRACTICE','') 
and 
ISNULL(List_Type__c,'') <> '' then 1 else 0 end IsDiallable
FROM
(
	SELECT Id

	FROM SalesforceReporting..TPS_June2018 tps

	WHERE TPS_Phone is null and ISNULL(tps.Phone, '') <> '' and (TPS_Mobile = 1 or TPS_Other = 1)

		UNION ALL

	SELECT Id

	FROM SalesforceReporting..TPS_June2018 tps

	WHERE TPS_Phone = 1 and (
								(TPS_Mobile is null and ISNULL(Mobile, '') <> '')
								or 
								(TPS_Other is null and ISNULL(Other, '') <> '')
							)
) detail
inner join Salesforce..Lead l ON detail.ID = l.Id