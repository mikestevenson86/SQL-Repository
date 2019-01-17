SELECT companyName, firstVisit, docReview, ds.dealStatus, drt.title docReviewType
FROM Shorthorn..cit_sh_dealsPEL dhr
left outer join Shorthorn..cit_sh_deals d ON dhr.dealID = d.dealID
left outer join Shorthorn..cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID
left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
left outer join Shorthorn..cit_sh_PELDocReviewTypes drt ON dhr.docReviewType = drt.id
WHERE firstVisit between '2018-01-01' and '2018-06-30' or docReview between '2018-01-01' and '2018-06-30'
ORDER BY docReview, firstVisit

SELECT companyName, installed, installedType
FROM Shorthorn..cit_sh_dealsPEL dhr
left outer join Shorthorn..cit_sh_deals d ON dhr.dealID = d.dealID
left outer join Shorthorn..cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID
left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
WHERE installed between '2018-01-01' and '2018-06-30'
ORDER BY installed

SELECT companyName, firstDraftRetrievalDone, secondDraftRetrievalDone, thirdDraftRetrievalDone
FROM Shorthorn..cit_sh_dealsPEL dhr
left outer join Shorthorn..cit_sh_deals d ON dhr.dealID = d.dealID
left outer join Shorthorn..cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID
left outer join Shorthorn..cit_sh_clients cl ON d.clientID = cl.clientID
WHERE 
firstDraftRetrievalDone between '2018-01-01' and '2018-06-30'
or
secondDraftRetrievalDone between '2018-01-01' and '2018-06-30'
or
thirdDraftRetrievalDone between '2018-01-01' and '2018-06-30'
ORDER BY firstDraftRetrievalDone, secondDraftRetrievalDone, thirdDraftRetrievalDone