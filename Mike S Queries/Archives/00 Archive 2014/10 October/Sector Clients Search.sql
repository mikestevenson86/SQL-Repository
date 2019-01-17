
  
  SELECT 
  c.clientID, c.companyName, con.fName, con.sName, con.position, con.email, con.tel
  FROM Shorthorn..cit_sh_clients c
  inner join Shorthorn..cit_sh_busType bt ON c.busType = bt.busTypeID
  inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
  inner join Shorthorn..cit_sh_deals d ON c.clientID = d.clientId
  left outer join Shorthorn..cit_sh_sites s ON c.clientID = s.clientID
  left outer join Shorthorn..cit_sh_contacts con ON s.genContact = con.contactID
  WHERE d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() and HeadOffice = 1
  and bs.title = 'Education'
