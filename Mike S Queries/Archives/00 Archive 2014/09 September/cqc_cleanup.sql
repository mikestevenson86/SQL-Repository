SELECT 
	careInfo.*,
	CASE 
		WHEN CareInfo.Name <> 'NULL' THEN CareInfo.Name 
		WHEN generalContacts.contactId IS NOT NULL THEN generalContacts.fName + ' ' + generalContacts.sName
		WHEN secContacts.contactId IS NOT NULL THEN secContacts.fName + ' ' + secContacts.sName
		WHEN mainHsContacts.contactId IS NOT NULL THEN mainHsContacts.fName + ' ' + mainHsContacts.sName
		WHEN mainElContacts.contactId IS NOT NULL THEN mainElContacts.fName + ' ' + mainElContacts.sName
		WHEN secHsContacts.contactId IS NOT NULL THEN secHsContacts.fName + ' ' + secHsContacts.sName
		WHEN secElContacts.contactId IS NOT NULL THEN secElContacts.fName + ' ' + secElContacts.sName
		WHEN citwebContact.contactId IS NOT NULL THEN citwebContact.fName + ' ' + citwebContact.sName
	END AS [Name_2],
	CASE 
		WHEN CareInfo.Name <> 'NULL' THEN CareInfo.position__c 
		WHEN generalContacts.contactId IS NOT NULL THEN generalContacts.position
		WHEN secContacts.contactId IS NOT NULL THEN secContacts.position
		WHEN mainHsContacts.contactId IS NOT NULL THEN mainHsContacts.position
		WHEN mainElContacts.contactId IS NOT NULL THEN mainElContacts.position
		WHEN secHsContacts.contactId IS NOT NULL THEN secHsContacts.position
		WHEN secElContacts.contactId IS NOT NULL THEN secElContacts.position
		WHEN citwebContact.contactId IS NOT NULL THEN citwebContact.position
	END AS [Position_2]
FROM 
	_CQC_Compare_Care$ careInfo
	LEFT JOIN cit_sh_clients clients ON careInfo.Shorthorn_Id__c = clients.clientID
	LEFT JOIN cit_sh_sites sites ON clients.clientID = sites.clientID AND sites.HeadOffice = 1
	LEFT JOIN cit_sh_contacts generalContacts ON sites.genContact = generalContacts.contactID
	LEFT JOIN cit_sh_contacts secContacts ON sites.secContact = secContacts.contactID
	LEFT JOIN cit_sh_contacts mainHsContacts ON sites.mainContactHS = mainHsContacts.contactID
	LEFT JOIN cit_sh_contacts secHsContacts ON sites.secContactHS = secHsContacts.contactID
	LEFT JOIN cit_sh_contacts mainElContacts ON sites.mainContactPEL = mainElContacts.contactID
	LEFT JOIN cit_sh_contacts secElContacts ON sites.secContactPEL = secElContacts.contactID
	LEFT JOIN cit_sh_contacts citwebContact ON sites.citManSuper = citwebContact.contactID
ORDER BY 
	Id
