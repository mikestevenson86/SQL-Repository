SELECT 
d.clientID,
HSId,
COALESCE(sixthVisit, fifthVisit, fourthVisit, thirVisit, secVisit, firstVisit) LastVisitDate,
COALESCE(
case when sixthVisit is not null then 'Sixth Visit' end, 
case when fifthVisit is not null then 'Fifth Visit' end, 
case when fourthVisit is not null then 'Fourth Visit' end, 
case when thirVisit is not null then 'Third Visit' end, 
case when secVisit is not null then 'Second Visit' end, 
case when firstVisit is not null then 'First Visit' end
) LastVisit
FROM Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_deals d ON dhs.dealID = d.dealID
WHERE d.signDate < GETDATE() and d.renewDate > GETDATE() and d.dealStatus not in (2,5,10,18)