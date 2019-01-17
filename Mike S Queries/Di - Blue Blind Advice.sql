SELECT 
CONVERT(date, commentDate) CallDate,
cl.clientId,
cl.companyName [Company Name],
s.postcode,
'H&S' Department, 
hsd.disposition Matter, 
bs.title Sector
FROM 
[Shorthorn].[dbo].[cit_sh_HSCitassist] hsa
inner join Shorthorn..cit_sh_HSDispositions hsd ON hsa.disposition = hsd.dispositionID
inner join Shorthorn..cit_sh_dealsHS dhs ON hsa.HSID = dhs.hsID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
inner join Shorthorn..cit_sh_sites s ON cl.clientID = s.clientID
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
WHERE hsa.HSID in
(
	SELECT HSID
	FROM Shorthorn..cit_sh_dealsHS
	WHERE clientID = 91515
)
and hsa.contactID in
(
	SELECT contactID
	FROM Shorthorn..cit_sh_contacts
	WHERE adviceCardStatusContact = 1 and siteID in
	(
		SELECT siteId	
		FROM Shorthorn..cit_sh_sites 
		WHERE clientID = 91515
	)
)
UNION

SELECT 
CONVERT(date, dateOfCall) CallDate, 
cl.clientId,
cl.companyName [Company Name],
s.postcode,
'EL & HR' Department,
case when ad.appraisal = 1 then 'Appraisal'
when ad.capability = 1 then 'Capability/Suitability'
when ad.compromiseAgreement = 1 then 'Compromise Agreement'
when ad.cyj = 1 then 'CYJ'
when ad.disProc = 1 then 'Disciplinary Procedure'
when ad.disAppeal = 1 then 'Disciplinary Appeal'
when ad.discrimination = 1 then 'Discrimination'
when ad.flexWork = 1 then 'Flexible Working'
when ad.grievance = 1 then 'Grievance Procedure'
when ad.holiday = 1 then 'Holiday Entitlement'
when ad.layOff = 1 then 'Lay Off/Short Time'
when ad.letterOfConcern = 1 then 'Letter of Concern'
when ad.maternity = 1 then 'Maternity/Adoption Leave'
when ad.medical = 1 then 'Medical Reports/Records'
when ad.minWage = 1 then 'National Minimum Wage'
when ad.noticePeriod = 1 then 'Notice Periods'
when ad.paternity = 1 then 'Parental Leave'
when ad.partTime = 1 then 'Part Time Working'
when ad.domestic = 1 then 'Performance'
when ad.pregnancy = 1 then 'Pregnancy'
when ad.termination = 1 then 'Probation'
when ad.recruitment = 1 then 'Recruitment'
when ad.redundancy = 1 then 'Redundancy'
when ad.resignation = 1 then 'Resignation'
when ad.retirement = 1 then 'Retirement'
when ad.salary = 1 then 'Pay/Wage'
when ad.sickness = 1 then 'Sickness Absence'
when ad.SMP = 1 then 'SMP/SAP/SPP'
when ad.SOSR = 1 then 'SOSR'
when ad.SSP = 1  then 'SSP'
when ad.termsAndConditions = 1 then 'Terms & Conditions'
when ad.TUPE = 1 then 'TUPE'
when ad.TURec = 1 then 'TU Recognition'
when ad.unauthAbsc = 1 then 'Unauthorised Absence'
when ad.workTimeRegs = 1 then 'Working Time Regs'
when ad.whistleBlowing = 1 then 'Whistle Blowing'
when ad.other = 1 then 'Other'
else 'No Matter Type' end Matter,
bs.title Sector
FROM Shorthorn..cit_sh_advice ad
inner join Shorthorn..cit_sh_sites s ON ad.siteID = s.siteID
inner join Shorthorn..cit_sh_clients cl ON s.clientID = cl.clientID
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
WHERE ad.siteID in
(
	SELECT siteId
	FROM Shorthorn..cit_sh_sites
	WHERE clientID = 91515
) and ad.adviceCard in 
(
	SELECT adviceCard 
	FROM Shorthorn..cit_sh_contacts 
	WHERE adviceCardStatusContact = 1 and siteID in 
	(
		SELECT siteId	
		FROM Shorthorn..cit_sh_sites 
		WHERE clientID = 91515
	)
)
ORDER BY CallDate, Department, Matter, Sector