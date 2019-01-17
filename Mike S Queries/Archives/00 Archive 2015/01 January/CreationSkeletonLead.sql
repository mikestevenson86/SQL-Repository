Create Table dbo.testBCPLoad
(
rn	bigint	Null,
Affinity_Cold__c	nvarchar(255)	Null,
Affinity_Industry_Type__c	nvarchar(255)	Null,
Alternate_DM__c	nvarchar(100)	Null,
Alternate_DM_Position__c	nvarchar(255)	Null,
AnnualRevenue	decimal(18, 0)	Null,
Appointment_Type__c	nvarchar(255)	Null,
Approved_By__c	nvarchar(100)	Null,
Approved_By_User__c	nchar(18)	Null,
Approved_Date__c	datetime2(7)	Null,
Area_Code__c	nvarchar(1300)	Null,
BDC__c	nchar(18)	Null,
BDC_is_current_user__c	varchar(5)	Null,
BDC_Manager__c	nvarchar(1300)	Null,
BDC_Manager_is__c	varchar(5)	Null,
Callback_Date_Time__c	datetime2(7)	Null,
Campaign_Source__c	nvarchar(100)	Null,
CitationSector__c	nvarchar(255)	Null,
City	nvarchar(40)	Null,
CleanStatus	nvarchar(40)	Null,
Company	nvarchar(255)	Null,
Company_Group__c	nvarchar(100)	Null,
Company_name__c	varchar(5)	Null,
Company_Name_DQ__c	varchar(5)	Null,
CompanyDunsNumber	nvarchar(9)	Null,
Completed_Date__c	datetime2(7)	Null,
Converted_Opp_Id__c	nvarchar(1300)	Null,
ConvertedAccountId	nchar(18)	Null,
ConvertedContactId	nchar(18)	Null,
ConvertedDate	datetime2(7)	Null,
ConvertedOpportunityId	nchar(18)	Null,
Country	nvarchar(80)	Null,
CreatedById	nchar(18)	Null,
CreatedDate	datetime2(7)	Null,
Current_Owner_Office__c	nvarchar(255)	Null,
Current_Third_Party_Product__c	nvarchar(255)	Null,
Data_Quality_All_Checked__c	varchar(5)	Null,
Data_Quality_Date__c	datetime2(7)	Null,
Data_Quality_Notes__c	ntext	Null,
Data_Supplier__c	nvarchar(100)	Null,
Date_Made__c	datetime2(7)	Null,
DateLastExtractedToDialler__c	datetime2(7)	Null,
Description	ntext	Null,
Diary_placement_considered__c	varchar(5)	Null,
Diary_Placement_DQ__c	varchar(5)	Null,
Directors__c	decimal(18, 0)	Null,
Email	nvarchar(80)	Null,
Email_DQ__c	varchar(5)	Null,
EmailBouncedDate	datetime2(7)	Null,
EmailBouncedReason	nvarchar(255)	Null,
Emails__c	varchar(5)	Null,
First_Call_Date__c	datetime2(7)	Null,
FirstName	nvarchar(40)	Null,
FT_Employees__c	decimal(18, 0)	Null,
Full_Address__c	varchar(5)	Null,
Full_address_DQ__c	varchar(5)	Null,
Full_name_and_position__c	varchar(5)	Null,
Full_Name_and_Position_DQ__c	varchar(5)	Null,
HasOptedOutOfEmail	varchar(5)	Null,
Health_and_Safety_Overview__c	ntext	Null,
How_They_Deal_HS_PEL_DQ__c	varchar(5)	Null,
How_they_deal_with_HS_PEL_currently__c	varchar(5)	Null,
Id	nchar(18)	Not Null,
IDG_FK__c	nvarchar(20)	Null,
Industry	nvarchar(40)	Null,
IsConverted	varchar(5)	Null,
IsDeleted	varchar(5)	Null,
IsTPS__c	nvarchar(3)	Null,
IsUnreadByOwner	varchar(5)	Null,
Jigsaw	nvarchar(20)	Null,
JigsawContactId	nvarchar(20)	Null,
Last_Call_Date__c	datetime2(7)	Null,
LastActivityDate	datetime2(7)	Null,
LastModifiedById	nchar(18)	Null,
LastModifiedDate	datetime2(7)	Null,
LastName	nvarchar(80)	Null,
LastReferencedDate	datetime2(7)	Null,
LastViewedDate	datetime2(7)	Null,
Latitude	decimal(18, 15)	Null,
LeadSource	nvarchar(40)	Null,
Longitude	decimal(18, 15)	Null,
MADE_Criteria__c	nvarchar(255)	Null,
MasterRecordId	nchar(18)	Null,
Migrate__c	varchar(5)	Null,
MobilePhone	nvarchar(40)	Null,
More_notes_required__c	varchar(5)	Null,
More_notes_required_DQ__c	varchar(5)	Null,
Name	nvarchar(121)	Null,
Need_identified__c	varchar(5)	Null,
Need_Identified_DQ__c	varchar(5)	Null,
Next_Dialler_Eligible_Date__c	datetime2(7)	Null,
Noble_Date__c	datetime2(7)	Null,
NobleRecordTag__c	nvarchar(100)	Null,
noblesys__InNobleList__c	varchar(5)	Null,
noblesys__NeedPull__c	varchar(5)	Null,
Notes__c	ntext	Null,
NumberOfEmployees	int	Null,
NVM_Trial__c	varchar(5)	Null,
Other_Notes__c	ntext	Null,
Other_Phone__c	nvarchar(40)	Null,
OutCode__c	nvarchar(1300)	Null,
OwnerId	nchar(18)	Null,
PAYE__c	varchar(5)	Null,
PAYE_DQ__c	varchar(5)	Null,
PAYE_Notes__c	ntext	Null,
Payroll_Amt__c	decimal(18, 0)	Null,
Pended_Date__c	datetime2(7)	Null,
Phone	nvarchar(40)	Null,
Position__c	nvarchar(255)	Null,
PostalCode	nvarchar(20)	Null,
Product_Interest__c	nvarchar(255)	Null,
Prospect_Channel__c	nvarchar(255)	Null,
Prospect_Creator_Id__c	nvarchar(1300)	Null,
Prospect_External_Id__c	nvarchar(30)	Null,
PT_Employees__c	decimal(18, 0)	Null,
Rating	nvarchar(40)	Null,
RecordTypeId	nchar(18)	Null,
Renewal_Date__c	datetime2(7)	Null,
Sales_Voice_Recording__c	nvarchar(1300)	Null,
Salesforce_Id__c	nvarchar(1300)	Null,
Salutation	nvarchar(40)	Null,
Sector__c	nvarchar(255)	Null,
Session_Notes__c	ntext	Null,
SIC2007_Code2__c	decimal(18, 0)	Null,
SIC2007_Code3__c	decimal(18, 0)	Null,
SIC2007_Code__c	nvarchar(5)	Null,
SIC2007_Description2__c	ntext	Null,
SIC2007_Description3__c	ntext	Null,
SIC2007_Description__c	ntext	Null,
Source__c	nvarchar(100)	Null,
Staff_Numbers_DQ__c	varchar(5)	Null,
Staff_numbers_ft_pt_split__c	varchar(5)	Null,
State	nvarchar(80)	Null,
Status	nvarchar(40)	Null,
Status_Changed_Date__c	datetime2(7)	Null,
Street	nvarchar(255)	Null,
Subcontractors__c	decimal(18, 0)	Null,
Suspended_Closed_Reason__c	nvarchar(255)	Null,
SystemModstamp	datetime2(7)	Null,
Third_party_renewal_date__c	varchar(5)	Null,
Third_Party_Renewal_DQ__c	varchar(5)	Null,
Time_and_date_of_the_appointment__c	varchar(5)	Null,
Time_Date_Appointment_DQ__c	varchar(5)	Null,
Title	nvarchar(128)	Null,
Total_Employees__c	decimal(18, 0)	Null,
Trigger_Session_Notes_Erase__c	varchar(5)	Null,
Web_Prospect_Notes__c	ntext	Null,
Website	nvarchar(255)	Null,
X1st_Visit_Date__c	datetime2(7)	Null,
X1st_Visit_Date_Date__c	datetime2(7)	Null,
X1st_Visit_Status__c	nvarchar(30)	Null,
xTotal_Employees__c	decimal(18, 0)	Null
 
    Constraint PK_testBCPLoad
        Primary Key Clustered
        (ID)
);