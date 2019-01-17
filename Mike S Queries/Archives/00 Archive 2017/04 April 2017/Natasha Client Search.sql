SELECT Id,Name
FROM Salesforce..Account
WHERE 
(
Name like '%bank of america%merrill lynch%' or
Name like '%bishop of konstant multi academy% (St John The Baptist, Sacred Heart, St Benedicts, St ignatius, St josephs castleford, st josephs pontefract)' or
Name like '%black swan%' or
Name like '%bradford academy%' or
Name like '%cbs corp%' or
Name like '%datix%' or
Name like '%European Healthcare Group%' or
Name like '%European Surgical Partner%' or
Name like '%Falcon%Adminsitrative Services%' or
Name like '%HCP Holding%' or
Name like '%HSF Logistic%' or
Name like '%IFPI%' or
Name like '%International Federatio%Phonographic Industry%' or
Name like '%Indigo Asset Holding%' or
Name like '%Lumi Tech%' or
Name like '%Magma%Structure%' or
Name like '%Odgers%' or
Name like '%Orchard Care Hom%' or
Name like '%Pontefract Academ%' or
Name like '%Pressbeau%' or
Name like '%Rena%Sola%' or
Name like '%Royal Botanic Garden%' or
Name like '%Russell Finex%' or
Name like '%Sage Publication%' or
Name like '%Coombe Secondary%' or
Name like '%Fertility Partnership%' or
Name like '%Private Clinic%' or
Name like '%Widford Lodge Preparatory School%'
)
and Citation_Client__c = 'true'