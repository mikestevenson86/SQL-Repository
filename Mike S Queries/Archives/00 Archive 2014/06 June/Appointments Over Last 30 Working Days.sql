declare	@dateStart	datetime
,	@dateEnd	datetime
,	@counter	int

-- chop off time, initialize variable
select	@dateStart	= convert(varchar,current_timestamp,101)
,	@dateEnd	= convert(varchar,current_timestamp,101)
,	@counter	= 1

-- go back 5 days
While @counter <= 30 begin
	select	@dateStart	= dateadd(dd,-1,@dateStart)
	,	@counter	= @counter + case when datepart(weekday,@dateStart) in (1,7) then 0 else 1 end
end

SELECT COUNT(l.id), u.Name
FROM Salesforce..Lead l
inner join Salesforce..[User] u ON l.BDC__c collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE l.Date_Made__c >= @dateStart
GROUP BY u.Name