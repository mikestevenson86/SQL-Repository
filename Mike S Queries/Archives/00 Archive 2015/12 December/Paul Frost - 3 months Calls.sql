SELECT u.Name, SUM(case when call_type in (0,2) and appl = 'CLD1' then 1 else 0 end) ColdCalls,
SUM(case when call_type in (0,2) and appl = 'INBO' then 1 else 0 end) InboundCold,
SUM(case when call_type in (0,2) and appl = 'AFF1' then 1 else 0 end) AffinityCold,
SUM(case when call_type = 4 then 1 else 0 end) Callbacks
FROM SalesforceReporting..call_history ch
inner join Salesforce..Lead l ON LEFT(ch.lm_filler2, 15) collate latin1_general_CS_AS = LEFT(l.Id, 15) collate latin1_general_CS_AS
inner join Salesforce..[User] u ON l.OwnerId = u.Id
inner join Salesforce..[UserRole] ur ON u.UserRoleId = ur.Id
WHERE ur.Name = 'BDM South' and act_date between '2015-09-01' and '2015-12-01'
GROUP BY u.Name