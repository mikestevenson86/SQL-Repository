SELECT s.clientId, MAX(ad.dateOfCall) LastCalled
INTO #LastCall
FROM 
Shorthorn..cit_sh_advice ad
inner join Shorthorn..cit_sh_sites s ON ad.siteID = s.siteID
GROUP BY s.clientID

SELECT clientId, ROW_NUMBER () OVER (PARTITION BY clientId ORDER BY dealId) rn, ds.dealStatus
INTO #dealStatuses
FROM Shorthorn..cit_sh_deals d
inner join Shorthorn..cit_sh_dealStatus ds ON d.dealStatus = ds.dealStatusID

SELECT clientID, MAX(rn) LastStat
INTO #MaxStat
FROM #dealStatuses
GROUP BY clientId

SELECT ds.clientID, COUNT(dealId) renewals
INTO #Renew
FROM Shorthorn..cit_sh_deals ds
WHERE dealStatus in (12,15)
GROUP BY ds.clientID

SELECT clientId, MIN(signDate) FirstSign, MAX(signDate) LastSign, MAX(renewDate) LastRenew, MAX(originalrenewdate) LastOriginal
INTO #Dates
FROM Shorthorn..cit_sh_deals
GROUP BY clientID

SELECT ds.clientId, MAX(ds.signDate) Signed
INTO #LastDeal
FROM Shorthorn..cit_sh_deals ds
GROUP BY ds.clientID

SELECT ds.clientId, case when ds.noticeDate is not null then 1 else 0 end Notice, st.dealStatus
INTO #LastNotice
FROM Shorthorn..cit_sh_deals ds
inner join #LastDeal ld ON ds.clientID = ld.clientID and ds.SignDate = ld.Signed
inner join Shorthorn..cit_sh_dealStatus st ON ds.dealStatus = st.dealStatusID

SELECT ds.clientId, SUM(case when ds.noticeDate is not null then 1 else 0 end) Notices,
SUM(case when ds.noticedate < DATEADD(month,1,signDate) then 1 else 0 end) InMonth,
SUM(case when ds.noticedate > DATEADD(month,1,signDate) and ds.noticeDate < DATEADD(month,-6,renewDate) then 1 else 0 end) InSix
INTO #Notices
FROM Shorthorn..cit_sh_deals ds
left outer join #LastDeal ld ON ds.clientID = ld.clientID and ds.SignDate = ld.Signed
WHERE ld.clientID is null
GROUP BY ds.clientID

SELECT
s.clientID,
MAX(VisitDate) LastVisit
INTO #LHSVisit
FROM Shorthorn..cit_sh_HSExtraVisits ev
inner join Shorthorn..cit_sh_sites s ON ev.siteID = s.siteID
GROUP BY
s.clientID

SELECT
s.clientID,
MAX(VisitDate) LastVisit
INTO #LHRVisit
FROM Shorthorn..cit_sh_PELExtraVisits ev
inner join Shorthorn..cit_sh_sites s ON ev.siteID = s.siteID
GROUP BY
s.clientID

SELECT
clientID,
MAX(Visits) HSVisits
INTO #HSVisits
FROM
(
SELECT
d.clientID,
d.dealId,
case when lhv.LastVisit is not null then lhv.LastVisit
when dhs.sixthVisit is not null then dhs.sixthVisit
when dhs.fifthVisit is not null then dhs.fifthVisit
when dhs.fourthVisit is not null then fourthVisit
when dhs.thirVisit is not null then thirVisit
when dhs.secVisit is not null then secVisit
when dhs.firstVisit is not null then firstVisit else '' end Visits
FROM
Shorthorn..cit_sh_dealsHS dhs
inner join Shorthorn..cit_sh_deals d ON dhs.dealID = d.dealID
left outer join #LHSVisit lhv ON d.clientID = lhv.clientID
) detail
GROUP BY clientID

SELECT
clientID,
MAX(Visits) HRVisits
INTO #HRVisits
FROM
(
SELECT
d.clientID,
d.dealId,
case when lpv.LastVisit is not null then lpv.LastVisit else dhr.firstVisit end Visits
FROM
Shorthorn..cit_sh_dealsPEL dhr
inner join Shorthorn..cit_sh_deals d ON dhr.dealID = d.dealID
left outer join #LHRVisit lpv ON dhr.clientID = lpv.clientID
) detail
GROUP BY clientID

SELECT ds.clientID,
DATEDIFF(day,lc.LastCalled,GETDATE()) DaysSinceLastCall,
SUM(case when ap.appID = 1 and ap.whenUsed between '2015-04-01' and '2015-06-30' then 1 else 0 end) CitAssessVisitsQ2,
SUM(case when ap.appID = 2 and ap.whenUsed between '2015-04-01' and '2015-06-30' then 1 else 0 end) CitManVisitsQ2,
SUM(case when ap.appID = 3 and ap.whenUsed between '2015-04-01' and '2015-06-30' then 1 else 0 end) CitNetVisitsQ2,
SUM(case when ap.appID = 10 and ap.whenUsed between '2015-04-01' and '2015-06-30' then 1 else 0 end) CitTrainVisitsQ2
INTO #dStats
FROM Shorthorn..cit_sh_deals ds
inner join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
left outer join Shorthorn..cit_sh_dealsHS hs ON cl.clientID = hs.clientID
left outer join Shorthorn..cit_sh_HSAdvice hsa ON hs.hsID = hsa.hsID
left outer join #LastCall lc ON cl.clientID = lc.clientID
left outer join CitationMain..citation_CompanyTable2 ct ON cl.sageCode collate latin1_general_CS_AS = ct.sageAC collate latin1_general_CS_AS
left outer join CitationMain..citation_appUsage ap ON ct.uid = ap.compID
GROUP BY ds.clientID,
DATEDIFF(day,lc.LastCalled,GETDATE())

SELECT cl.clientID, ds.dealID, companyName, ds.cost, ds.dealLength, bs.title Sector, cl.totEmployees,
case when cl.clienttype = 'BCAS' then 'BCAS'
when ds.dealStatus in (12,13) then 'Auto'
when ds.dealStatus in (14,15) then 'Non-Auto' end ContractType, ds.payroll, dt.dealType,
dts.FirstSign, dts.LastSign, dts.LastRenew, dts.LastOriginal,
case when ds.noticeDate < DATEADD(month,1,signDate) then 1 else 0 end NoticeInMonth,
case when ds.noticeDate > DATEADD(month,1,signDate) and ds.noticeDate < DATEADD(month,-6,renewDate) then 1 else 0 end NoticeSixBefore,
dst.DaysSinceLastCall, dst.CitTrainVisitsQ2, dst.CitNetVisitsQ2, dst.CitManVisitsQ2, dst.CitAssessVisitsQ2,
Shorthorn.dbo.GetHelplineHSCallCount(cl.SageCode,'2014-09-01','2015-09-01') TwelveMonthHSCalls,
Shorthorn.dbo.GetHelplinePELCallCount(cl.SageCode,'2014-09-01','2015-09-01') TwelveMonthHRCalls,
Shorthorn.dbo.GetHelplineHSCallCountALLTIME(cl.clientID) HSCalls,
Shorthorn.dbo.GetHelplinePELCallCountALLTIME(cl.clientID) HRCalls,
case when hsv.HSVisits > hrv.HRVisits then DATEDIFF(day,hsv.HSVisits,GETDATE()) else DATEDIFF(day,hrv.HRVisits,GETDATE()) end LastVisit,
ln.Notice,
nt.Notices,
nt.InMonth,
nt.InSix,
rn.Renewals,
ln.DealStatus,
n1.dealStatus N1Stat,
n2.dealStatus N2Stat,
n3.dealStatus N3Stat
FROM Shorthorn..cit_sh_deals ds
inner join Shorthorn..cit_sh_clients cl ON ds.clientID = cl.clientID
inner join Shorthorn..cit_sh_busType bt ON cl.busType = bt.busTypeID
inner join Shorthorn..cit_sh_businessSectors bs ON bt.businessSectorID = bs.id
inner join Shorthorn..cit_sh_dealTypes dt ON ds.dealType = dt.dealTypeID
left outer join #HRVisits hrv ON cl.clientID = hrv.clientID
left outer join #HSVisits hsv ON cl.clientID = hsv.clientID
left outer join #dStats dst ON cl.clientID = dst.clientID
left outer join #LastNotice ln ON cl.clientID = ln.clientID
left outer join #Renew rn ON cl.clientID = rn.clientID
left outer join #Dates dts ON cl.clientID = dts.clientID
left outer join #MaxStat ms ON cl.clientID = ms.clientID
left outer join #dealStatuses n1 ON cl.clientID = n1.clientID and n1.rn = ms.LastStat-1
left outer join #dealStatuses n2 ON cl.clientID = n2.clientID and n2.rn = ms.LastStat-2
left outer join #dealStatuses n3 ON cl.clientID = n3.clientID and n3.rn = ms.LastStat-3
left outer join #Notices nt ON cl.clientID = nt.clientID
WHERE renewDate between '2011-01-01' and GETDATE() and 
(
(noticeDate is not null and ds.dealStatus in (12,13)) 
or
ds.dealStatus in (14,15)
)

DROP TABLE #LastDeal
DROP TABLE #Renew
DROP TABLE #LastCall
DROP TABLE #HRVisits
DROP TABLE #HSVisits
DROP TABLE #dStats
DROP TABLE #Dates
DROP TABLE #LastNotice
DROP TABLE #LHRVisit
DROP TABLE #LHSVisit
DROP TABLE #MaxStat
DROP TABLE #dealStatuses
DROP TABLE #Notices