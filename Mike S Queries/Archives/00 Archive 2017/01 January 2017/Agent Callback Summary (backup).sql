
    
    -- Salesforce Callback Count for Yesterday
    
    SELECT 
    u.Name, 
    COUNT(lh.Id) Callbacks
    
    INTO 
    #SFCB
    
    FROM 
    Salesforce..LeadHistory lh
    inner join Salesforce..[User] u ON lh.CreatedById = u.Id
    
    WHERE 
    CONVERT(date, lh.CreatedDate) = 
    case when DATENAME(weekday, GETDATE()) = 'Monday' then CONVERT(date, GETDATE()-3) else CONVERT(date, GETDATE()-1) end
    and
    Field = 'Callback_Date_Time__c' 
    and 
    CONVERT(date, OldValue) = CONVERT(date, lh.CreatedDate)
    
    GROUP BY
    u.Name
    
    -- Noble Callback count for yesterday
    
    SELECT
    tsr,
    COUNT(seqno) Callbacks
    
    INTO
    #NobleCB
    
    FROM
    SalesforceReporting..call_history
    
    WHERE 
    act_date = case when DATENAME(weekday, GETDATE()) = 'Monday' then CONVERT(date, GETDATE()-3) else CONVERT(date, GETDATE()-1) end
    and
    call_type in (4,5)
    
    GROUP BY
    tsr
    
        SELECT  l.Id ,
                l.Status AS [Status] ,
                case when l.Callback_Date_Time__c Is null then 'No Date' else CONVERT(varchar(10),l.Callback_Date_Time__c,101) end DueDate ,
                ISNULL(u.Name, 'No BDC') AS BDC ,
                ROW_NUMBER () OVER (PARTITION BY ISNULL(u.Name, 'No BDC') ORDER BY Callback_date_time__c) rn ,
                ISNULL(uMan.Name, 'No TM') AS TeamManager ,
                u.Yesterdays_Callbacks__c PreviousDayCallbacksDue,
                scb.Callbacks PreviousDayCallbacks_SFDC,
                ncb.Callbacks PreviousDayCallbacks_Noble,
                CASE WHEN l.Callback_Date_Time__c IS NULL THEN '0_No Due Date'
                     WHEN Callback_Date_Time__c < CONVERT(DATE, GETDATE())
                     THEN '1_Overdue'
                     WHEN CONVERT(DATE, callback_date_time__c) = CONVERT(DATE, GETDATE())
                     THEN '2_Today'
                     WHEN CONVERT(DATE, callback_date_time__c) = CONVERT(DATE, GETDATE()
                          + 1) THEN '3_Tomorrow'
                     WHEN CONVERT(DATE, callback_date_time__c) BETWEEN CONVERT(DATE, GETDATE()
                                                              + 2)
                                                              AND
                                                              CONVERT(DATE, GETDATE()
                                                              + 5)
                     THEN '4_2-5 Days'
                     WHEN CONVERT(DATE, callback_date_time__c) BETWEEN CONVERT(DATE, GETDATE()
                                                              + 6)
                                                              AND
                                                              CONVERT(DATE, GETDATE()
                                                              + 10)
                     THEN '5_6-10 Days'
                     WHEN CONVERT(DATE, callback_date_time__c) BETWEEN CONVERT(DATE, GETDATE()
                                                              + 11)
                                                              AND
                                                              CONVERT(DATE, GETDATE()
                                                              + 30)
                     THEN '6_11-30 Days'
                     WHEN CONVERT(DATE, callback_date_time__c) BETWEEN CONVERT(DATE, GETDATE()
                                                              + 31)
                                                              AND
                                                              CONVERT(DATE, GETDATE()
                                                              + 60)
                     THEN '7_31-60 Days'
                     WHEN CONVERT(DATE, callback_date_time__c) BETWEEN CONVERT(DATE, GETDATE()
                                                              + 61)
                                                              AND
                                                              CONVERT(DATE, GETDATE()
                                                              + 90)
                     THEN '8_61-90 Days'
                     ELSE '9_90+Days'
                END AS DueDays ,
                CASE WHEN l.Suspended_Closed_Reason__c = 'DM Callback'
                     THEN 'DMC'
                     WHEN l.Suspended_Closed_Reason__c = 'Non DM Callback'
                     THEN 'Non DMC'
                     ELSE '[Other]'
                END AS CallBackType,
                case when l.Callback_Date_Time__c is null then 'No Callback Date' else
                DATENAME(month,CONVERT(date,l.callback_date_time__c)) end [Month],
                case when l.Callback_Date_Time__c is null then '0000' else DATEPART(year,l.callback_date_time__c) end [Year],
                l.Third_Party_QA_checked__c,
                oth.NotTPApproved OtherNotTP
                
        FROM    [Salesforce].dbo.Lead l
                LEFT OUTER JOIN [Salesforce].dbo.[User] u ON u.Id = l.BDC__c and u.Department = 'Telemarketing'
                LEFT OUTER JOIN [Salesforce].dbo.[User] uMan ON uMan.Id = u.ManagerId 
                LEFT OUTER JOIN #NobleCB ncb ON u.DiallerFK__c = ncb.tsr
                LEFT OUTER JOIN #SFCB scb ON u.Name = scb.Name
                LEFT OUTER JOIN (
					SELECT u.Name, 
					SUM(case when l.Third_Party_QA_checked__c <> 'Approved' or Third_Party_QA_checked__c is null then 1 else 0 end) NotTPApproved
					FROM Salesforce..Lead l
					inner join Salesforce..[User] u ON l.BDC__c = u.Id
					inner join Salesforce..[User] uMan ON u.ManagerId = uMan.Id
					WHERE CONVERT(date, Callback_Date_Time__c) <= DATEADD(day,14,GETDATE()) and CONVERT(date, Callback_Date_Time__c) >= CONVERT(date, GETDATE()) 
					and Status = 'Callback Requested'
					and uMan.Name <> 'Jo Wood' and uMan.Name <> 'Kathy Gwinnett' 
					GROUP BY u.Name
					) oth ON u.Name = oth.Name
        WHERE   
        l.[Status] = 'Callback Requested' and uMan.Name <> 'Jo Wood' and uMan.Name <> 'Kathy Gwinnett' 
        and
        CONVERT(date, Callback_Date_Time__c) not between CONVERT(date, GETDATE()) and DATEADD(day,14,CONVERT(date, GETDATE()))
        --and uMan.Id is not null
        ORDER BY BDC, l.Callback_Date_Time__c

	DROP TABLE #SFCB
	DROP TABLE #NobleCB

