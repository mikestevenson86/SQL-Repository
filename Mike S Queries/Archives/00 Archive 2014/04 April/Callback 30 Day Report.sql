SELECT distinct(l.id) Records, LEFT(lh.CreatedDate,10) Calldate
INTO #OldCB
FROM lead l
left join LeadHistory lh on l.Id collate latin1_general_CS_AS = lh.LeadId collate latin1_general_CS_AS
WHERE LEFT(lh.OldValue,10) >= GETDATE() - 30 and LEFT(lh.OldValue,10) <= GETDATE() and Field = 'Callback_Date_Time__c' and LEFT(lh.CreatedDate,10) >= LEFT(lh.OldValue,10)
GROUP BY LEFT(lh.CreatedDate,10), l.id
ORDER BY LEFT(lh.CreatedDate,10)

SELECT calldate,COUNT(records) records
INTO #OCB
FROM #OldCB
GROUP BY calldate
ORDER BY calldate

SELECT COUNT(l.id) records, LEFT(l.Callback_Date_Time__c,10) Calldate
INTO #CBStill
FROM lead l
WHERE l.Callback_Date_Time__c  >= GETDATE() - 30 and Callback_Date_Time__c <=GETDATE()
GROUP BY LEFT(l.Callback_Date_Time__c,10)
ORDER BY LEFT(l.Callback_Date_Time__c,10)

SELECT distinct(l.id) records,LEFT(lh.CreatedDate,10) calldate
INTO #CBs
FROM Lead l
left join LeadHistory lh on l.Id collate latin1_general_CS_AS = lh.LeadId collate latin1_general_CS_AS
inner join [User] u on lh.CreatedById = u.Id
  WHERE lh.Field = 'callback_date_time__c' and lh.CreatedDate >= GETDATE() - 30 and u.Title like '%BDC%'
  GROUP BY l.Id, LEFT(lh.CreatedDate,10)
  ORDER BY LEFT(lh.CreatedDate,10), l.id

  SELECT cb.calldate [Date],COUNT(cb.records) [Callbacks Set], l.records [Callbacks Due], cbs.records [Callbacks Overdue]
  FROM #CBs cb
  left join #OCB l on cb.calldate = l.calldate
  left join #CBStill cbs on cb.calldate = cbs.Calldate
  GROUP BY cb.calldate,l.records, cbs.records
  ORDER BY cb.calldate
  
  drop table #OldCB
  drop table #CBs
  drop table #OCB
  drop table #CBStill
