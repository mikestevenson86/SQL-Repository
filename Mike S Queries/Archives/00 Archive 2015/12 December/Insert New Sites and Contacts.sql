  SELECT 
  siteID SHSiteID__c, 
  address1 + ' ' + address2 Street__c, 
  town City__c, 
  ct.county County__c, 
  ct.Country, 
  s.postcode PostCode__c,
  case when HeadOffice = 1 then 'Main Site' else 'Other Site' end Site_Type__c, 
  s.genTelNoSpaces Phone__c,
  bs.title Sector__c,
  ISNULL(ac.Id, SFDC_AccountId) Account__c
  
  FROM 
  [database].[Shorthorn].[dbo].[cit_sh_sites] s
  inner join [database].[Shorthorn].dbo.cit_sh_clients cl ON s.clientID = cl.clientID
  left outer join Salesforce..Account ac ON LEFT(cl.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(ac.ID, 15) collate latin1_general_CS_AS
  left outer join [database].[Shorthorn].dbo.cit_sh_county ct ON s.county = ct.countyID
  left outer join [database].shorthorn.dbo.cit_sh_bustype bt ON s.busType = bt.busTypeId
  left outer join [database].shorthorn.dbo.cit_sh_businesssectors bs ON bt.businesssectorId = bs.Id
  
  WHERE 
  siteID >
	  (
	  SELECT MAX(ShsiteId__c)
	  FROM Salesforce.dbo.site__c
	  )
  --------------------------------------------------------------------------------------------------------------------------------------
  SELECT 
  ISNULL(ac.ID, cl.SFDC_AccountId) AccountId, 
  contactID Shorthorn_Id__c, 
  fName FirstName, 
  sName LastName, 
  Email, 
  tel Phone, 
  mob MobilePhone, 
  tt.title Salutation, 
  position Position__c,
  case when hs.mainContactHS is null then 'No' else 'Yes' end Helpline_H_S__c,
  case when hr.mainContactPEL is null then 'No' else 'Yes' end Helpline_PEL__c,
  case when os.citManSuper is null then 'No' else 'Yes' end Online_Super_User__c,
  s.address1 + ' ' + s.address2 MailingStreet, 
  s.town MailingCity, 
  ct.county MailingState, 
  s.postcode MailingPostalCode
  
  FROM
  [database].Shorthorn.dbo.cit_sh_contacts con
  inner join [database].Shorthorn.dbo.cit_sh_sites s ON con.siteID = s.siteID
  inner join [database].Shorthorn.dbo.cit_sh_clients cl ON s.clientID = cl.clientID
  left outer join Salesforce..Account ac ON LEFT(cl.SFDC_AccountId, 15) collate latin1_general_CS_AS = LEFT(ac.Id, 15) collate latin1_general_CS_AS
  left outer join [database].Shorthorn.dbo.cit_sh_sites hs ON con.contactID = hs.mainContactHS and con.siteID = hs.siteID
  left outer join [database].Shorthorn.dbo.cit_sh_sites hr ON con.contactID = hr.mainContactPEL  and con.siteID = hr.siteID
  left outer join [database].Shorthorn.dbo.cit_sh_sites os ON con.contactID = os.citManSuper  and con.siteID = os.siteID
  left outer join [database].Shorthorn.dbo.cit_sh_titles tt ON con.title = tt.titleID
  left outer join [database].Shorthorn.dbo.cit_sh_county ct ON s.county = ct.countyID
  
  WHERE 
  contactID >
	  (
	  SELECT MAX(Shorthorn_Id__c)
	  FROM Salesforce.dbo.Contact
	  )