SELECT 
c.fName + ' ' + c.sName ContactName, 
c.adviceCard AdviceCard, 
c.adviceCardStatusContact CardStatus,
case when msc.genContact is not null then 'Yes' else 'No' end MainSiteContact,
case when ssc.secContact is not null then 'Yes' else 'No' end SecondSiteContact,
case when mhc.mainContactHS is not null then 'Yes' else 'No' end MainHSContact,
case when shc.secContactHS is not null then 'Yes' else 'No' end SecHSContact,
case when mpc.mainContactPEL is not null then 'Yes' else 'No' end MainPELContact,
case when spc.secContactPEL is not null then 'Yes' else 'No' end SecPELContact,
case when cwc.citManSuper is not null then 'Yes' else 'No' end CitwebSuperUser,
cl.ClientID, 
cl.CompanyName, 
dl.SAGE_ContractId

FROM Shorthorn..cit_sh_clients cl
left outer join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
left outer join Shorthorn..cit_sh_contacts c ON s.siteID = c.siteID
left outer join Shorthorn..cit_sh_sites msc ON c.contactID = msc.genContact and s.siteID = msc.siteID
left outer join Shorthorn..cit_sh_sites ssc ON c.contactID = ssc.secContact and s.siteID = ssc.siteID
left outer join Shorthorn..cit_sh_sites mhc ON c.contactID = mhc.mainContactHS and s.siteID = mhc.siteID
left outer join Shorthorn..cit_sh_sites shc ON c.contactID = shc.secContactHS and s.siteID = shc.siteID
left outer join Shorthorn..cit_sh_sites mpc ON c.contactID = mpc.mainContactPEL and s.siteID = mpc.siteID
left outer join Shorthorn..cit_sh_sites spc ON c.contactID = spc.secContactPEL and s.siteID = spc.siteID
left outer join Shorthorn..cit_sh_sites cwc ON c.contactID = cwc.citManSuper
left outer join Shorthorn..cit_sh_deals dl ON cl.clientID = dl.clientID
WHERE c.contactID is not null