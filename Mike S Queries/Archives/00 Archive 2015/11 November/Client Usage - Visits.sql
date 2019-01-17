DECLARE @DateStart Date = '2014-10-01'
DECLARE @DateEnd Date = '2015-10-01'

SELECT
d.clientID,
SUM(
		case when dhs.firstVisit between @DateStart and @DateEnd then 1 else 0 end +
		case when dhs.secVisit between @DateStart and @DateEnd then 1 else 0 end +
		case when dhs.thirVisit between @DateStart and @DateEnd then 1 else 0 end +
		case when dhs.fourthVisit between @DateStart and @DateEnd then 1 else 0 end +
		case when dhs.fifthVisit between @DateStart and @DateEnd then 1 else 0 end +
		case when dhs.sixthVisit between @DateStart and @DateEnd then 1 else 0 end
	) HSVisits
INTO #HSVisits
FROM
Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_deals d ON dhs.dealID = d.dealID

GROUP BY d.clientID

SELECT
d.clientID,
SUM(
       case when dhr.firstVisit between @DateStart and @DateEnd then 1 else 0 end +
       case when dhr.installBooked between @DateStart and @DateEnd then 1 else 0 end +
       case when dhr.firstDraftRetrievalDone between @DateStart and @DateEnd then 1 else 0 end +
       case when dhr.secondDraftRetrievalDone between @DateStart and @DateEnd then 1 else 0 end +
       case when dhr.thirdDraftRetrievalDone between @DateStart and @DateEnd then 1 else 0 end +
       case when dhr.midTermReview between @DateStart and @DateEnd then 1 else 0 end
    ) HRVisits
INTO #HRVisits
FROM
Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_deals d ON dhr.dealID = d.dealID
GROUP BY d.clientID

SELECT
a.Id,
a.Name Company,

ISNULL(hsv.HSVisits,0) [H&S Visits],
ISNULL(hrv.HRVisits,0) [EL & HR Visits],

a.SIC2007_Code__c,
a.SIC2007_Description__c,
a.SIC2007_Code2__c,
a.SIC2007_Description2__c,
a.SIC2007_Code3__c,
a.SIC2007_Description3__c,
a.CitationSector__c

FROM 
[DB01].Salesforce.dbo.Account a
left outer join #HSVisits hsv ON a.Shorthorn_Id__c = hsv.clientID
left outer join #HRVisits hrv ON a.Shorthorn_Id__c = hrv.clientID
WHERE hsv.HSVisits > 0 or hrv.HRVisits > 0

DROP TABLE #HSVisits
DROP TABLE #HRVisits