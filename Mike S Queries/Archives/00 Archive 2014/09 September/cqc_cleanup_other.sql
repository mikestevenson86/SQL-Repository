SELECT
	theReset.*,
	CASE 
		WHEN theReset.Name <> 'NULL' THEN theReset.Name 
		WHEN generalContacts.contactId IS NOT NULL THEN generalContacts.fName + ' ' + generalContacts.sName
		WHEN secContacts.contactId IS NOT NULL THEN secContacts.fName + ' ' + secContacts.sName
		WHEN mainHsContacts.contactId IS NOT NULL THEN mainHsContacts.fName + ' ' + mainHsContacts.sName
		WHEN mainElContacts.contactId IS NOT NULL THEN mainElContacts.fName + ' ' + mainElContacts.sName
		WHEN secHsContacts.contactId IS NOT NULL THEN secHsContacts.fName + ' ' + secHsContacts.sName
		WHEN secElContacts.contactId IS NOT NULL THEN secElContacts.fName + ' ' + secElContacts.sName
		WHEN citwebContact.contactId IS NOT NULL THEN citwebContact.fName + ' ' + citwebContact.sName
	END AS [Name_2],
	CASE 
		WHEN theReset.Name <> 'NULL' THEN theReset.position__c 
		WHEN generalContacts.contactId IS NOT NULL THEN generalContacts.position
		WHEN secContacts.contactId IS NOT NULL THEN secContacts.position
		WHEN mainHsContacts.contactId IS NOT NULL THEN mainHsContacts.position
		WHEN mainElContacts.contactId IS NOT NULL THEN mainElContacts.position
		WHEN secHsContacts.contactId IS NOT NULL THEN secHsContacts.position
		WHEN secElContacts.contactId IS NOT NULL THEN secElContacts.position
		WHEN citwebContact.contactId IS NOT NULL THEN citwebContact.position
	END AS [Position_2],	
	sectors.title AS [Business sector],
	businessTypes.busType AS [Business type]
FROM 
	['_CQC_Compare_The Rest$'] theReset
	LEFT JOIN cit_sh_clients clients ON theReset.Shorthorn_Id__c = clients.clientID
	LEFT JOIN cit_sh_sites sites ON sites.siteId = (SELECT TOP 1 s.siteId FROM cit_sh_sites s WHERE s.clientID = clients.clientID AND s.HeadOffice = 1)
	LEFT JOIN cit_sh_contacts generalContacts ON sites.genContact = generalContacts.contactID
	LEFT JOIN cit_sh_contacts secContacts ON sites.secContact = secContacts.contactID
	LEFT JOIN cit_sh_contacts mainHsContacts ON sites.mainContactHS = mainHsContacts.contactID
	LEFT JOIN cit_sh_contacts secHsContacts ON sites.secContactHS = secHsContacts.contactID
	LEFT JOIN cit_sh_contacts mainElContacts ON sites.mainContactPEL = mainElContacts.contactID
	LEFT JOIN cit_sh_contacts secElContacts ON sites.secContactPEL = secElContacts.contactID
	LEFT JOIN cit_sh_contacts citwebContact ON sites.citManSuper = citwebContact.contactID
	LEFT JOIN cit_sh_busType businessTypes ON clients.busType = businessTypes.busTypeID
	LEFT JOIN cit_sh_businessSectors sectors ON businessTypes.businessSectorID = sectors.id
ORDER BY 
	Id
	