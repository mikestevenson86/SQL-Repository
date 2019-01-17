SELECT
URN Market_Location_URN__c,
[Business Name] Company,
[Address Line 1] + ' ' + [Address Line 2] + ' ' + Locality Street,
Town City,
County State,
PostCode PostalCode,
[Telephone Number] Phone,
case when ctps = 'Y' then 'Yes' else 'No' end IsTPS__c,
case when [Contact email address] = '' then [company email address] else [Contact email address] end Email,
[web address] Website,
[Nat Employees] FT_Employees,
[Contact title] Salutation,
[contact forename] FirstName,
[Contact surname] LastName,
[contact position] Position__c,
ISNULL(cro_number,'') Co_Reg__c,
[UK 07 Sic Code] SIC2007_Code3__c,
[UK 07 Sic Desc] SIC2007_Description3__c,
case when [UK 07 Sic Code] in ('96030') then 'Funerals'
when [UK 07 Sic Code] in ('1130','1190','46220','46310','46610','47760','81300') then 'Horticulture'
when [UK 07 Sic Code] in ('23700','24410','24420','24430','24440','24450','25500',
'25610','25620','25710','25930','25940','32120','32130','33200','71129','72190') then 'Engineering'
when [UK 07 Sic Code] in ('43120','31130','43210','43220','43290','43310','43320','43330',
'43341','43390','43910','43991','43999','42110','42130','42210','42220','42910','42990','71200') then 'Construction Specialised' end Sector

INTO
MarketLocation..Sectors0711

FROM
MarketLocation..MainDataSet

WHERE location_type <> 'B' and [UK 07 SIC Code] in
(
'96030','1130','1190','46220','46310','46610','47760','81300','23700','24410','24420','24430','24440','24450','25500',
'25610','25620','25710','25930','25940','32120','32130','33200','71129','72190','43120','31130','43210','43220','43290',
'43310','43320','43330','43341','43390','43910','43991','43999','42110','42130','42210','42220','42910','42990','71200'
)
and
IsNumeric([Nat Employees]) = 1
and
[Nat Employees] between 3 and 225