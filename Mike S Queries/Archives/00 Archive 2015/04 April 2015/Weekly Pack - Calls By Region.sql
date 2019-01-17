SELECT
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) [Week No],
case when appl = 'AFF1' then 'Affinity' when appl = 'CLD1' then 'Cold' end ColdAffinity,
case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end  Region,
COUNT(distinct TSR) Agents
INTO #Agents
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join Salesforce..[User]	u ON l.OwnerId = u.Id
inner join Salesforce..UserRole ur ON u.UserRoleId = ur.Id
WHERE act_date >= GETDATE()-43 and ch.appl in ('AFF1','CLD1') and call_type in (0,1,2,3,6)
and (l.RecordTypeId = '012D0000000NbJsIAK' or l.RecordTypeId is null)
GROUP BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
case when appl = 'AFF1' then 'Affinity' when appl = 'CLD1' then 'Cold' end,
case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end

SELECT
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) [Week No],
case when appl = 'AFF1' then 'Affinity' when appl = 'CLD1' then 'Cold' end ColdAffinity,
case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end  Region,
a.Agents,
COUNT(seqno) Dials,
SUM(case when call_type in (0,2) then 1 else 0 end) ColdConnects,
SUM(case when call_type = 4 then 1 else 0 end) CallbackConnects
FROM
SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON ch.lm_filler2 = l.Id
inner join Salesforce..[User]	u ON l.OwnerId = u.Id
inner join Salesforce..UserRole ur ON u.UserRoleId = ur.Id
left outer join #Agents a ON case when appl = 'AFF1' then 'Affinity' when appl = 'CLD1' then 'Cold' end = a.ColdAffinity
							AND DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date) = a.[Week No]
							AND case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end = a.Region
WHERE act_date >= GETDATE()-43 and ch.appl in ('AFF1','CLD1')
and (l.RecordTypeId = '012D0000000NbJsIAK' or l.RecordTypeId is null)
GROUP BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
case when appl = 'AFF1' then 'Affinity' when appl = 'CLD1' then 'Cold' end,
case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end ,
a.Agents
ORDER BY
DATEADD(dd, -(DATEPART(dw, act_date)-2), act_date),
case when appl = 'AFF1' then 'Affinity' when appl = 'CLD1' then 'Cold' end,
case when u.Name in ('William Mcfaulds','John McCaffrey') then 'Scotland'
when (ur.Name = 'BDM North' or u.Name = 'Louise Rogers') and u.Name not in ('William Mcfaulds','John McCaffrey') then 'North'
when l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%' then 'London'
when ur.Name = 'BDM South' and NOT (
l.PostalCode like 'N1%' or
l.PostalCode like 'N2%' or
l.PostalCode like 'N3%' or
l.PostalCode like 'N4%' or
l.PostalCode like 'N5%' or
l.PostalCode like 'N6%' or
l.PostalCode like 'N7%' or
l.PostalCode like 'N8%' or
l.PostalCode like 'N9%' or
l.PostalCode like 'E1%' or
l.PostalCode like 'E2%' or
l.PostalCode like 'E3%' or
l.PostalCode like 'E4%' or
l.PostalCode like 'E5%' or
l.PostalCode like 'E6%' or
l.PostalCode like 'E7%' or
l.PostalCode like 'E8%' or
l.PostalCode like 'E9%' or
l.PostalCode like 'W1%' or
l.PostalCode like 'W2%' or
l.PostalCode like 'W3%' or
l.PostalCode like 'W4%' or
l.PostalCode like 'W5%' or
l.PostalCode like 'W6%' or
l.PostalCode like 'W7%' or
l.PostalCode like 'W8%' or
l.PostalCode like 'W9%' or
l.PostalCode like 'NW%' or
l.PostalCode like 'EC%' or
l.PostalCode like 'SE%' or
l.PostalCode like 'SW%') then 'South' end 

DROP TABLE #Agents