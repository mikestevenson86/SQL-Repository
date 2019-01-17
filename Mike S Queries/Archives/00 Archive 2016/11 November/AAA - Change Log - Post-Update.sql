SELECT tc.*
FROM SalesforceReporting..TempChanges tc
inner join MarketLocation..LatestMLUpdate mlu ON tc.Id = mlu.Id
WHERE Error = 'Operation Successful.'