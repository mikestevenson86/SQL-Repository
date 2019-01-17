/*
UPDATE SalesforceReporting..PostcodeAssignments
SET BDM = 'James O''Hare'
WHERE LEFT(AreaCode, 2) = 'CW'

UPDATE SalesforceReporting..PostcodeAssignments
SET BDM = 'Tim Kirk'
WHERE LEFT(AreaCode, 2) in ('DE','ST')

UPDATE SalesforceReporting..PostcodeAssignments
SET BDM = 'Sarah L Roberts'
WHERE LEFT(AreaCode, 2) in ('L1','L2','L3','L4','L5','L6','L7','L8','L9','WA')

UPDATE SalesforceReporting..PostcodeAssignments
SET BDM = 'Gary Smith'
WHERE LEFT(AreaCode, 2) in ('TF','WS','WV')
*/
SELECT * FROM SalesforceReporting..PostcodeAssignments