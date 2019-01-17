SELECT 
lh.CreatedDate, 
l.* 
FROM Salesforce..Lead l
left outer join Salesforce..LeadHistory lh ON l.Id = lh.LeadId and lh.Field = 'Phone' and lh.NewValue not like '0%'
left outer join Salesforce..[User] u ON lh.CreatedById = u.Id
WHERE l.Id in
(
'00QD000000fkEdmMAE',
'00QD0000011aia5MAA',
'00QD0000011aia5MAA',
'00QD000000fT04XMAS',
'00QD000000hdix2MAA',
'00QD000000xSPPiMAO',
'00QD0000011bAnSMAU',
'00QD000000hdyWMMAY',
'00QD000000fQpu5MAC',
'00QD000000hdyWMMAY',
'00QD000000fkEdmMAE',
'00QD000000xSPPiMAO',
'00QD000000fkEdmMAE',
'00QD000000hdyWMMAY',
'00QD000000xSPPiMAO',
'00QD000000fkEdmMAE',
'00QD000000hdyWMMAY',
'00QD000000xSPPiMAO'
) and u.Name = 'Salesforce Admin'