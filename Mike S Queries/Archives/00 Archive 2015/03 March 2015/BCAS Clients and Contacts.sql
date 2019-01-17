SELECt c.clientID, c.clienttype, c.companyName, c.sageCode, c.totEmployees, 
con.fName, con.sName, con.position, con.tel, con.mob, con.email, con.enabled
FROM cit_sh_clients c
inner join cit_sh_sites s ON c.clientID = s.clientID 
inner join cit_sh_contacts con ON s.genContact = con.contactID
WHERE clienttype like '%BCAS%' and s.HeadOffice = 1
ORDER BY c.clientID