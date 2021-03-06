
  
  SELECT 
  CASE WHEN DATEPART(Month, d.signDate) = 1 then 'January'
  WHEN DATEPART(Month, d.signDate) = 2 then 'Feburary'
  WHEN DATEPART(Month, d.signDate) = 3 then 'March'
  WHEN DATEPART(Month, d.signDate) = 4 then 'April'
  WHEN DATEPART(Month, d.signDate) = 5 then 'May'
  WHEN DATEPART(Month, d.signDate) = 6 then 'June'
  WHEN DATEPART(Month, d.signDate) = 7 then 'July'
  WHEN DATEPART(Month, d.signDate) = 8 then 'August'
  WHEN DATEPART(Month, d.signDate) = 9 then 'September'
  WHEN DATEPART(Month, d.signDate) = 10 then 'October'
  WHEN DATEPART(Month, d.signDate) = 11 then 'November'
  WHEN DATEPART(Month, d.signDate) = 12 then 'December' END [Month], bs.title [Sector], COUNT(c.clientId) Clients
  FROM Shorthorn..cit_sh_clients c
  inner join Shorthorn..cit_sh_busType bt ON c.busType = bt.busTypeID
  inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
  inner join Shorthorn..cit_sh_deals d ON c.clientID = d.clientID
  WHERE d.dealStatus not in (2,5,10,18) and d.renewDate >= GETDATE() 
  and bs.title in ('Care','Engineering','Construction','Renewable/Solar Energy/Organics/Recycling',
  'Wholesale','Manufacture','Education','Vets','Day Nurseries','Funeral','Pharmacies','Transport/Freight/Logistics/Warehousing','Cleaning')
  GROUP BY DATEPART(Month, d.signDate), bs.title
  ORDER BY DATEPART(Month, d.signDate), bs.title