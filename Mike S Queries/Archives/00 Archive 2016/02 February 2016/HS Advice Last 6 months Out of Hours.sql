SELECT CONVERT(date, ad.actualDateCreated) AdviceDate, ad.actualDateCreated [Actual Created Date], cl.companyName Company, hsd.Disposition, contactName Contact, ad.Comments
FROM Shorthorn..cit_sh_HSCitassist ad
inner join Shorthorn..cit_sh_dealsHS hs ON ad.HSID = hs.hsID
inner join Shorthorn..cit_sh_clients cl ON hs.clientID = cl.clientID
inner join Shorthorn..cit_sh_HSDispositions hsd ON ad.disposition = hsd.dispositionID
WHERE 
(CONVERT(time, ad.actualDateCreated) < CONVERT(time,'09:00:00') or CONVERT(time, ad.actualDateCreated) > CONVERT(time, '17:00:00'))
and
CONVERT(date, ad.actualDateCreated) > DATEADD(month,-6,GETDATE())
ORDER BY actualDateCreated