SELECT yd.ID
FROM [LeadChangeReview].[dbo].[Lead_SnapShots] yd
inner join LeadChangeReview.dbo.Lead_SnapShots db ON yd.Id = db.Id 
														and CONVERT(date, db.SnapShotDate) = CONVERT(Date, GETDATE()-1)
WHERE
CONVERT(date, yd.SnapShotDate) = CONVERT(Date, GETDATE()) and
(
yd.[Affinity_Cold__c] <> db.[Affinity_Cold__c] or
yd.[Affinity_Industry_Type__c] <> db.[Affinity_Industry_Type__c] or
yd.[Alternate_DM__c] <> db.[Alternate_DM__c] or
yd.[Alternate_DM_Position__c] <> db.[Alternate_DM_Position__c] or
yd.[Basic_Crit__c] <> db.[Basic_Crit__c] or
yd.[CARE_Care_Home_Group__c] <> db.[CARE_Care_Home_Group__c] or
yd.[CARE_Inspection_Date__c] <> db.[CARE_Inspection_Date__c] or
yd.[CARE_Inspection_Rating__c] <> db.[CARE_Inspection_Rating__c] or
yd.[CARE_LB_urn_Id__c] <> db.[CARE_LB_urn_Id__c] or
yd.[CARE_Number_of_Beds__c] <> db.[CARE_Number_of_Beds__c] or
yd.[CARE_Provision_Type__c] <> db.[CARE_Provision_Type__c] or
yd.[CARE_Report_Link__c] <> db.[CARE_Report_Link__c] or
yd.[City] <> db.[City] or
yd.[Co_Reg__c] <> db.[Co_Reg__c] or
yd.[Data_Supplier__c] <> db.[Data_Supplier__c] or
yd.[Email] <> db.[Email] or
yd.[FirstName] <> db.[FirstName] or
yd.[HasOptedOutOfEmail] <> db.[HasOptedOutOfEmail] or
yd.[HG_List_ID__c] <> db.[HG_List_ID__c] or
yd.[HG_Score__c] <> db.[HG_Score__c] or
yd.[IsTPS__c] <> db.[IsTPS__c] or
yd.[LastName] <> db.[LastName] or
yd.[List_ID__c] <> db.[List_ID__c] or
yd.[MADE_Criteria__c] <> db.[MADE_Criteria__c] or
yd.[Major_sector_code__c] <> db.[Major_sector_code__c] or
yd.[Major_sector_description__c] <> db.[Major_sector_description__c] or
yd.[Market_Location_URN__c] <> db.[Market_Location_URN__c] or
yd.[ML_Business_Type__c] <> db.[ML_Business_Type__c] or
yd.[ML_Last_Update_Date__c] <> db.[ML_Last_Update_Date__c] or
yd.[ML_Major_Sector__c] <> db.[ML_Major_Sector__c] or
yd.[MLRecencyBanding__c] <> db.[MLRecencyBanding__c] or
yd.[OutboundCallCount__c] <> db.[OutboundCallCount__c] or
yd.[Position__c] <> db.[Position__c] or
yd.[PostalCode] <> db.[PostalCode] or
yd.[PT_Employees__c] <> db.[PT_Employees__c] or
yd.[SIC2007_Code__c] <> db.[SIC2007_Code__c] or
--yd.[SIC2007_Description__c] <> db.[SIC2007_Description__c] or
yd.[Source__c] <> db.[Source__c] or
yd.[State] <> db.[State] or
yd.[Street] <> db.[Street] or
yd.[Sub_sector_description__c] <> db.[Sub_sector_description__c] or
yd.[TEXT_BDM__c] <> db.[TEXT_BDM__c] or
yd.[Toxic_SIC__c] <> db.[Toxic_SIC__c] or
yd.[Website] <> db.[Website] or
yd.[Year_established__c] <> db.[Year_established__c] or
yd.[AccountsEmailAddress__c] <> db.[AccountsEmailAddress__c] or
yd.[ActiveComplaint__c] <> db.[ActiveComplaint__c] or
yd.[Acc_AffinityPartner] <> db.[Acc_AffinityPartner] or
yd.[Citation_Client__c] <> db.[Citation_Client__c] or
yd.[isConverted__c] <> db.[isConverted__c] or
yd.[IsDeleted] <> db.[IsDeleted] or
yd.[NBS_Client__c] <> db.[NBS_Client__c] or
yd.[Original_Source__c] <> db.[Original_Source__c] or
yd.[Acc_SICCode] <> db.[Acc_SICCode] or
--yd.[Acc_SICDesc] <> db.[Acc_SICDesc] or
yd.[Sites__c] <> db.[Sites__c] or
yd.[UBT_Client__c] <> db.[UBT_Client__c] or
yd.[Acc_Website] <> db.[Acc_Website] or
yd.[Opp_AffinityPartner] <> db.[Opp_AffinityPartner] or
yd.[Appointment_Type__c] <> db.[Appointment_Type__c] or
yd.[Lost_Reason__c] <> db.[Lost_Reason__c] or
yd.[Opp_MADECriteria] <> db.[Opp_MADECriteria]
)
GROUP BY yd.Id