SELECT
Category,
FORMAT(MIN(RunDate),"dd/MM/yyyy") as RunDate,
MIN(Consultant) as Consultant,
SUM(NormalWorkingDays) as NormalWorkingDays,
SUM(PhysicalDays) as PhysicalDays,
SUM(FirstVisits) as FirstVisits,
SUM(InstallVisits) as InstallVisits,
SUM(AnnualVisits) as AnnualVisits,
SUM(ExtraContractual) as ExtraContractual,
SUM(OtherExtraVisits) as OtherExtraVisits,
SUM(AddiServices) as AddiServices,
SUM(ArrCancelled) as ArrCancelled,
SUM(DayCancelled) as DayCancelled,
SUM(TotalClientVisits) as TotalClientVisits,
SUM(AverageVisits) as AverageVisits,
SUM(AdminDays) as AdminDays,
SUM(Sickness) as Sickness,
SUM(Helpline) as Helpline,
SUM(CallTaken) as CallsTaken,
SUM(OtherMeetings) as OtherMeetings,
SUM(Holidays) as Holidays,
SUM(Onboarding) as NotOnboarded,
SUM(Migration) as NotMigrated,
SUM(Systems) as SystemsOS,
SUM(Reports) as ReportsOS,
MAX(ClientSite1) as ClientSite1,
MAX(Date1) as Date1,
MAX(Reason1) as Reason1,
MAX(ClientSite2) as ClientSite2,
MAX(Date2) as Date2,
MAX(Reason2) as Reason2,
MAX(ClientSite3) as ClientSite3,
MAX(Date3) as Date3,
MAX(Reason3) as Reason3,
MAX(ClientSite4) as ClientSite4,
MAX(Date4) as Date4,
MAX(Reason4) as Reason4,
MAX(ServiceIssues1) as ServiceIssues1,
MAX(ServiceIssues2) as ServiceIssues2,
MAX(ServiceIssues3) as ServiceIssues3,
MAX(ServiceIssues4) as ServiceIssues4,
MAX(OtherIssues1) as OtherIssues1,
MAX(OtherIssues2) as OtherIssues2,
MAX(OtherIssues3) as OtherIssues3,
MAX(OtherIssues4) as OtherIssues4

FROM
(
SELECT 
F1 as Consultant,
'1900-01-01' as RunDate,
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$C1:C1]
union
SELECT 
'ZZZZZ' as Consultant,
F1 as RunDate,
'Group 1' as Category,
F3 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B3:D3]
union
SELECT 
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,    
'Group 1' as Category,
0 as NormalWorkingDays,
F1 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$D4:D4]
union
SELECT 
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,    
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
F1 as FirstVisits,
F3 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B7:D7]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,   
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
F1 as AnnualVisits,
F3 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B9:D9]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,   
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
F1 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B11:B11]
union
SELECT 
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,    
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
F1 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B13:B13]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
F1 as ArrCancelled,
F3 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B15:D15]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
F1 as TotalClientVisits,
F3 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B17:D17]
union
SELECT    
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
F1 as AdminDays,
F3 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B20:D20]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,   
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
F1 as Helpline,
F3 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B22:D22]
union
SELECT    
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate, 
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
F1 as OtherMeetings,
F3 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B24:D24]
union
SELECT   
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate, 
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
F1 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B27:B27]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,   
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
F1 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B29:B29]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
F1 as Systems,
F3 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$B32:D32]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
F1 as ClientSite1,
F2 as Date1,
F3 as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A35:C35]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
F1 as ClientSite2,
F2 as Date2,
F3 as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A36:C36]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
F1 as ClientSite3,
F2 as Date3,
F3 as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A37:C37]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
F1 as ClientSite4,
F2 as Date4,
F3 as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A38:C38]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
F1 as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A41:A41]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
F1 as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A42:A42]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
F1 as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A43:A43]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
F1 as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A44:A44]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
F1 as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A47:A47]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
F1 as OtherIssues2,
'' as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A48:A48]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
F1 as OtherIssues3,
'' as OtherIssues4
FROM         [Individual Consultant Feedback$A49:A49]
union
SELECT  
'ZZZZZ' as Consultant,
'1900-01-01' as RunDate,  
'Group 1' as Category,
0 as NormalWorkingDays,
0 as PhysicalDays,
0 as FirstVisits,
0 as InstallVisits,
0 as AnnualVisits,
0 as ExtraContractual,
0 as OtherExtraVisits,
0 as AddiServices,
0 as ArrCancelled,
0 as DayCancelled,
0 as TotalClientVisits,
0 as AverageVisits,
0 as AdminDays,
0 as Sickness,
0 as Helpline,
0 as CallTaken,
0 as OtherMeetings,
0 as Holidays,
0 as Onboarding,
0 as Migration,
0 as Systems,
0 as Reports,
'' as ClientSite1,
'' as Date1,
'' as Reason1,
'' as ClientSite2,
'' as Date2,
'' as Reason2,
'' as ClientSite3,
'' as Date3,
'' as Reason3,
'' as ClientSite4,
'' as Date4,
'' as Reason4,
'' as ServiceIssues1,
'' as ServiceIssues2,
'' as ServiceIssues3,
'' as ServiceIssues4,
'' as OtherIssues1,
'' as OtherIssues2,
'' as OtherIssues3,
F1 as OtherIssues4
FROM         [Individual Consultant Feedback$A50:A50]
) detail
GROUP BY Category