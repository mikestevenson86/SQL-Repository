DECLARE @CallbackDate as date
SET @CallbackDate = '2018-10-31'

IF OBJECT_ID('tempdb..#BDC') IS NOT NULL DROP TABLE #BDC

SELECT
lh.NewValue BDC__c,
lh.LeadId,
lh.CreatedDate FromDate,
ISNULL(MIN(lh2.CreatedDate), GETDATE()) ToDate

INTO
#BDC

FROM
Salesforce..LeadHistory lh
left outer join Salesforce..LeadHistory lh2 ON lh.LeadId = lh2.LeadId
												and lh2.Field = 'BDC__c'
												and lh.CreatedDate < lh2.CreatedDate
												and lh.NewValue = lh2.OldValue
WHERE 
lh.Field = 'BDC__c'
and
lh.NewValue like '005D%'

GROUP BY
lh.NewValue,
lh.LeadId,
lh.CreatedDate

SELECT 
lh.LeadId, 
u.Name BDC,
CONVERT(date, LEFT(lh.NewValue, 10)) CallbackSetDate, 
lh.CreatedDate SetFrom, 
MIN(lh2.CreatedDate) SetTo

FROM 
Salesforce..LeadHistory lh
left outer join Salesforce..LeadHistory lh2 ON lh.LeadId = lh2.LeadId
												and lh2.Field = 'Callback_Date_Time__c'
												and lh.CreatedDate < lh2.CreatedDate
												and lh.NewValue = lh2.OldValue
left outer join #BDC bdc on lh.LeadId = bdc.LeadId and @CallbackDate between bdc.FromDate and bdc.ToDate
left outer join Salesforce..[User] u ON bdc.BDC__c = u.Id

WHERE 
lh.Field = 'Callback_Date_Time__c' 
and 
lh.NewValue = @CallbackDate 
and 
CONVERT(date, lh2.CreatedDate) >= @CallbackDate 
and 
CONVERT(date, lh.CreatedDate) < @CallbackDate

GROUP BY 
lh.LeadId, 
u.Name, 
CONVERT(date, LEFT(lh.NewValue, 10)), 
lh.CreatedDate