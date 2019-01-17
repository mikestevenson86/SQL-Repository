SELECT 
Id [Salesforce ID], 
FirstName [SF First Name], 
fName [SH First Name], 
LastName [SF Last Name], 
sName [SH Last Name], 
Phone [SF Phone], 
tel [SH Phone], 
MobilePhone [SF Mobile], 
mob [SH Mobile], 
c.Email [SF Email], 
con.Email [SH Email], 
Salutation [SF Title], 
tt.title [SH Title], 
Position__c [SF Position], 
Position [SH Position],
Helpline_H_S__c [SF H&S Contact], 
case when hs.mainContactHS is null then 'No' else 'Yes' end [SH H&S Contact], 
Helpline_PEL__c [SF PEL Contact], 
case when hr.mainContactPEL is null then 'No' else 'Yes' end [SH PEL Contact],
Online_Super_User__c [SF Super User], 
case when os.citManSuper is null then 'No' else 'Yes' end [SH Super User]

FROM 
Salesforce..Contact c
inner join [database].shorthorn.dbo.cit_sh_contacts con ON c.Shorthorn_Id__c = con.contactId
left outer join [database].Shorthorn.dbo.cit_sh_sites hs ON con.contactID = hs.mainContactHS and con.siteID = hs.siteID
left outer join [database].Shorthorn.dbo.cit_sh_sites hr ON con.contactID = hr.mainContactPEL  and con.siteID = hr.siteID
left outer join [database].Shorthorn.dbo.cit_sh_sites os ON con.contactID = os.citManSuper  and con.siteID = os.siteID
left outer join [database].Shorthorn.dbo.cit_sh_titles tt ON con.title = tt.titleID

WHERE
ISNULL(FirstName,'') <> ISNULL(fName,'') OR
ISNULL(LastName,'') <> ISNULL(sName,'') OR
ISNULL(REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ',''),'') <> ISNULL(REPLACE(case when Tel like '0%' then Tel else '0'+tel end,' ',''),'') OR
ISNULL(REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ',''),'') <> ISNULL(REPLACE(case when mob like '0%' then mob else '0'+mob end,' ',''),'') OR
ISNULL(c.Email,'') <> ISNULL(con.Email,'') OR
ISNULL(Salutation,'') <> ISNULL(tt.title,'') OR
ISNULL(Position__c,'') <> ISNULL(Position,'') OR
ISNULL(Helpline_H_S__c,'') <> ISNULL(case when hs.mainContactHS is null then 'No' else 'Yes' end,'') OR
ISNULL(Helpline_PEL__c,'') <> ISNULL(case when hr.mainContactPEL is null then 'No' else 'Yes' end,'') OR
ISNULL(Online_Super_User__c,'') <> ISNULL(case when os.citManSuper is null then 'No' else 'Yes' end,'')

-------------------------------------------------------------------------------------------------------------------------------------
SELECT 
s.Id [Salesforce ID],
Street__c [SF Street],
address1 + ' ' + address2 [SH Street], 
City__c [SF City], 
town [SH City],
County__c [SF County], 
ct.county [SH County], 
PostCode__c [SF Post Code],
sh.postcode [SH Post Code], 
Site_Type__c [SF Site Type],
case when HeadOffice = 1 then 'Main Site' else 'Other Site' end [SH Site Type], 
REPLACE(Phone__c,' ','') [SF Phone],
sh.genTelNoSpaces [SH Phone]

FROM 
Salesforce..Site__c s
inner join [database].shorthorn.dbo.cit_sh_sites sh ON s.SHsiteID__c = sh.siteId
left outer join [database].[Shorthorn].dbo.cit_sh_county ct ON sh.county = ct.countyID
left outer join [database].shorthorn.dbo.cit_sh_bustype bt ON sh.busType = bt.busTypeId
left outer join [database].shorthorn.dbo.cit_sh_businesssectors bs ON bt.businesssectorId = bs.Id

WHERE
ISNULL(address1 + ' ' + address2,'') <> ISNULL(Street__c,'') OR 
ISNULL(town,'') <> ISNULL(City__c,'') OR 
ISNULL(ct.county,'') <> ISNULL(County__c,'') OR 
ISNULL(sh.postcode,'') <> ISNULL(PostCode__c,'') OR
ISNULL(case when HeadOffice = 1 then 'Main Site' else 'Other Site' end,'') <> ISNULL(Site_Type__c,'') OR 
ISNULL(sh.genTelNoSpaces,'') <> ISNULL(REPLACE(Phone__c,' ',''),'') OR
ISNULL(bs.title,'') <> ISNULL(Sector__c,'')