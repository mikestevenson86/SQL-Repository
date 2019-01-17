IF OBJECT_ID('tempdb..#Temp') IS NOT NULL DROP TABLE #Temp

SELECT o.Id, p2.Name
INTO #Temp
FROM Salesforce..Opportunity o
inner join Salesforce..OpportunityLineItem oi ON o.Id = oi.OpportunityId
inner join Salesforce..Product2 p2 ON oi.Product2Id = p2.Id
inner join Salesforce..[User] u ON o.OwnerId = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
WHERE o.StageName = 'Closed Won' and YEAR(o.CloseDate) = 2018 and p.Name in ('Citation BDM','Citation BDM Pasture')


SELECT ProductGroup, COUNT(distinct Id) OppID
FROM
(
      SELECT o.Id
      ,
      STUFF
               (
                          (
                                    SELECT ', ' + o2.Name
                                    FROM 
                                             #Temp o2
                                    WHERE
                                             o.Id = o2.Id 
                                     ORDER BY o2.Name
                                    FOR XML PATH ('')
                          ), 1, 1, ''
               ) ProductGroup
      FROM #Temp o
) detail
GROUP BY ProductGroup

