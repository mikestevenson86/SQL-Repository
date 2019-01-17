	SELECT 
	CAST(Id as NCHAR(18)) Id,
	LEFT(fName, 40) FirstName, c.FirstName,
	LEFT(sName, 80) LastName, c.LastName,
	REPLACE(case when ISNULL(Tel,'') like '0%' then Tel else '0'+tel end,' ',''), REPLACE(case when ISNULL(Phone,'') like '0%' then Phone else '0'+Phone end,' ',''),
	REPLACE(case when mob like '0%' then mob else '0'+mob end,' ','') MobilePhone, ISNULL(REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ',''),''),
	REPLACE(REPLACE(REPLACE(REPLACE(con.Email,' ',''),'>',''),'<',''),'unknown','') Email, c.Email,
	tt.title Salutation, c.Salutation,
	Position Position__c, c.Position__c,
	case when hs.mainContactHS is null and hs2.secContactHS is null then 'No' else 'Yes' end Helpline_H_S__c, c.Helpline_H_S__c,
	case when hr.mainContactPEL is null and hr2.secContactPEL is null then 'No' else 'Yes' end Helpline_PEL__c, c.Helpline_PEL__c,
	case when os.citManSuper is null then 'No' else 'Yes' end Online_Super_User__c, c.Online_Super_User__c,
	case when mu.genContact is null then 'No' else 'Yes' end Main_User__c, c.Main_User__c,
	--case when con.[enabled] = 1 then 'true' else ' false' end Active__c, c.Active__c,
	
	case when ISNULL(FirstName,'') <> ISNULL(fName,'') then 'FirstName' else '' end
	+ case when ISNULL(LastName,'') <> ISNULL(sName,'') then 'LastName' else '' end
	+ case when ISNULL(REPLACE(case when Phone like '0%' then Phone else '0'+Phone end,' ',''),'') <> ISNULL(REPLACE(case when Tel like '0%' then Tel else '0'+tel end,' ',''),'') then 'Phone' else '' end
	+ case when ISNULL(REPLACE(case when MobilePhone like '0%' then MobilePhone else '0'+MobilePhone end,' ',''),'') <> ISNULL(REPLACE(case when mob like '0%' then mob else '0'+mob end,' ',''),'') then 'Mobile' else '' end
	+ case when ISNULL(c.Email,'') <> ISNULL(con.Email,'') then 'Email' else '' end
	+ case when ISNULL(Salutation,'') <> ISNULL(tt.title,'') then 'Title' else '' end
	+ case when ISNULL(Position__c,'') <> ISNULL(Position,'') then 'Position' else '' end
	+ case when ISNULL(Helpline_H_S__c,'') <> ISNULL(case when hs.mainContactHS is null and hs2.secContactHS is null then 'No' else 'Yes' end,'') then 'HelplineHS' else '' end
	+ case when ISNULL(Helpline_PEL__c,'') <> ISNULL(case when hr.mainContactPEL is null and hr2.secContactPEL is null then 'No' else 'Yes' end,'') then 'HelplinePEL' else '' end
	+ case when ISNULL(Online_Super_User__c,'') <> ISNULL(case when os.citManSuper is null then 'No' else 'Yes' end,'') then 'SuperUser' else '' end
	+ case when ISNULL(Main_user__c,'') <> ISNULL(case when mu.genContact is null then 'No' else 'Yes' end,'') then 'MainUser' else '' end 
	--+ case when ISNULL(CONVERT(VarChar,Active__c),'false') <> case when con.[enabled] = 1 then 'true' else 'false' end then 'Active' else '' end

	FROM 
	Salesforce..Contact c
	inner join [database].shorthorn.dbo.cit_sh_contacts con ON c.Shorthorn_Id__c = con.contactId
	left outer join [database].Shorthorn.dbo.cit_sh_sites hs ON con.contactID = hs.mainContactHS and con.siteID = hs.siteID
	left outer join [database].Shorthorn.dbo.cit_sh_sites hs2 ON con.contactID = hs2.secContactHS and con.siteID = hs2.siteID
	left outer join [database].Shorthorn.dbo.cit_sh_sites hr ON con.contactID = hr.mainContactPEL  and con.siteID = hr.siteID
	left outer join [database].Shorthorn.dbo.cit_sh_sites hr2 ON con.contactID = hr2.secContactPEL  and con.siteID = hr2.siteID
	left outer join [database].Shorthorn.dbo.cit_sh_sites os ON con.contactID = os.citManSuper  and con.siteID = os.siteID
	left outer join [database].Shorthorn.dbo.cit_sh_sites mu ON con.contactID = mu.genContact and con.siteId = mu.siteID
	left outer join [database].Shorthorn.dbo.cit_sh_titles tt ON con.title = tt.titleID

	WHERE
	ISNULL(FirstName,'') <> ISNULL(fName,'') 
	OR ISNULL(LastName,'') <> ISNULL(sName,'') 
	OR REPLACE(case when ISNULL(Phone,'') like '0%' then Phone else '0'+Phone end,' ','') <> REPLACE(case when ISNULL(Tel,'') like '0%' then Tel else '0'+tel end,' ','') 
	OR REPLACE(case when ISNULL(MobilePhone,'') like '0%' then MobilePhone else '0'+MobilePhone end,' ','') <> REPLACE(case when ISNULL(mob,'') like '0%' then mob else '0'+mob end,' ','') 
	OR ISNULL(c.Email,'') <> ISNULL(con.Email,'') 
	OR ISNULL(Salutation,'') <> ISNULL(tt.title,'') 
	OR ISNULL(Position__c,'') <> ISNULL(Position,'') 
	OR ISNULL(Helpline_H_S__c,'') <> ISNULL(case when hs.mainContactHS is null and hs2.secContactHS is null then 'No' else 'Yes' end,'') 
	OR ISNULL(Helpline_PEL__c,'') <> ISNULL(case when hr.mainContactPEL is null and hr2.secContactPEL is null then 'No' else 'Yes' end,'') 
	OR ISNULL(Online_Super_User__c,'') <> ISNULL(case when os.citManSuper is null then 'No' else 'Yes' end,'') 
	OR ISNULL(Main_user__c,'') <> ISNULL(case when mu.genContact is null then 'No' else 'Yes' end,'') 
	--OR ISNULL(CONVERT(VarChar,Active__c),'false') <> case when con.[enabled] = 1 then 'true' else 'false' end