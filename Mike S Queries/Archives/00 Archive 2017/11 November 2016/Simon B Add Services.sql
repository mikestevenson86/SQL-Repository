SELECT a.Id, a.Name, sb.[Account Name], sb.*
FROM SalesforceReporting..SB_Accounts sb
left outer join Salesforce..Account a ON sb.[Account Name] = a.Name
WHERE sb.[Account Name] in
(
'Associated Nurseries Ltd',
'Calbarrie Cheshire Ltd.',
'Controlled Air Solutions Limited',
'Customs Connect Limited',
'Easi Recycling Solutions Limited',
'Ecodrive Transmissions Limited',
'Euro Electrical & Mechanical Ltd t/a Eurocrane',
'Forward Industrial Products Group Limited',
'Fulford Nursing Home',
'H D M Engineering Services Ltd',
'Harrogate Homecare Ltd',
'Helping Hands Cleaning(Lancashire) Ltd',
'Matrix Primary Healthcare Ltd',
'Moorland Veterinary Centre',
'R & L Holt Ltd',
'Revolution Property Managment Ltd',
'Serv-U Ltd',
'Shirley Golf Club Ltd',
'Star Autos Ltd',
'Streetwise Couriers Midlands Ltd',
'TS & SHK Investments t/a Trentside Manor Wilbraham House Chiltern Residential',
'We Are The Care Company Ltd'
)
ORDER BY sb.[Account Name]