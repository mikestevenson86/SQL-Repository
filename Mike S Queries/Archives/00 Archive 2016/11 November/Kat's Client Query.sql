SELECT

a.Id [Account ID],
a.CitWeb_ID__c [CitWeb ID],
a.Sage_Id__c [Sage Code],
a.Name [Company Name],
a.ParentId [Parent ID],
s.Postcode__c [PostCode],
a.CitationSector__c [Citation Sector],
a.FT_Employees__c [FT Employees],
a.Sites__c Sites,
a.CALC_Citation_Contract__c [Citation Contracts],
c.Id [Contract ID],
c.Service_Type__c [Service Type],
c.Services_Taken_EL__c [EL & HR],
c.Services_Taken_HS__c [H&S],
c.Services_Taken_Env__c [Environmental],
c.Services_Taken_eRAMS__c eRAMs,
c.Services_Taken_AI_Only__c [A&I Only EL & HR],
c.Services_Taken_AI_Only_HS__c [A&I Only H&S],
c.Services_Taken_Advice_Only__c [Advice Only EL & HR],
c.Services_Taken_Advice_Only_HS__c [Advice Only H&S],
c.Services_Taken_Training__c Training,
c.Services_Taken_Consultancy__c Consultancy,
c.Services_Taken_JIT__c [JIT Tribunal],
c.Services_Taken_FRA__c [Fire Risk Assessment],
c.Services_Taken_SBP__c [Small Business Package],
c.Business_Defence__c [Business Defence],
c.CQC__c CQC,
c.Online_Tools_Only__c [Online Tools Only],
c.UBT_Meeting_Room__c [UBT Meeting Room],
a.Cluster_Start_Date__c [Cluster Start Date],
a.Cluster_End_Date__c [Cluster End Date],
c.Contract_Value__c [Contract Value],
c.CALC_Segmentation_Monthly_Amount__c [Monthly Amount],
c.Renewal_Type__c [Renewal Type],
c.Cancellation_Date__c [Cancellation Date],
c.Cancellation_Reason__c [Cancellation Reason],
o.[Type],
o.Lost_Reason__c [Lost Reason],
o.Lost_Reason_Notes__c [Lost Reason Notes],
o.Lost_to_Competitor__c [Lost to Competitor]

FROM
Salesforce..Account a
inner join Salesforce..Site__c s ON a.Id = s.Account__c
									and s.Site_Type__c = 'Main Site'
inner join Salesforce..Contract c ON a.Id = c.AccountId and c.Service_Type__c = 'Citation'
left outer join Salesforce..Opportunity o ON c.Id = o.Original_Contract__c
									
WHERE 
a.Citation_Client__c = 'false' and
(
c.EndDate between DATEADD(Year,-3,GETDATE()) and GETDATE()
or
c.Cancellation_Date__c between DATEADD(Year,-3,GETDATE()) and GETDATE()
)