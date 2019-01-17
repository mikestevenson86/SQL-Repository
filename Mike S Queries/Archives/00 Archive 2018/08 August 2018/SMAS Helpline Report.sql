SELECT ad.*
FROM Shorthorn..cit_sh_HSCitassist ad
inner join Shorthorn..cit_sh_dealsHS dhs ON ad.HSID = dhs.hsID
inner join Shorthorn..cit_sh_clients cl ON dhs.clientID = cl.clientID
WHERE cl.clientID = 92448