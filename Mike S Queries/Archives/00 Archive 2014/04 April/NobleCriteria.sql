USE NobleCustomTables

begin tran

INSERT INTO cust_citation
(
phone,
sname,
address1,
address2,
city,
postal_code,
county,
sfdc_id,
company,
postcode,
contact_number,
mobile_number,
bdm,
cold_affinity,
contact_name,
sf_status,
sfdc_ownerid,
sector,
dm_position,
SIC_2007Code,
SIC_2007Code_2,
CurrentOwner)

select
l.Phone
as phone
,l.Name
as sname
,l.Street
as address1
,l.City
as address2
,u.Name
as city
,l.PostalCode
as postal_code
,l.[State]
as county
,l.Id
as sfdc_id
,l.Company
as company
,l.PostalCode
as postcode
,l.Phone
as contact_number
,l.MobilePhone
as mobile_number
,u.Name
as BDM
,l.Affinity_Cold__c
as cold_affinity
,l.Name
as contact_name
,l.[Status]
as sf_status
,l.OwnerId
as sfdc_ownerid
,l.CitationSector__c
as sector
,l.Position__c
as dm_position
,l.SIC2007_Code__c
as SIC_2007Code
,l.SIC2007_Code2__c
as SIC_2007Code_2,
'Wilmslow'
as CurrentOwner
from salesforce..lead l
left join cust_citation c on l.id collate latin1_general_CS_AS = c.sfdc_id collate latin1_general_CS_AS
inner join Salesforce..[User] u on l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
where l.Affinity_Cold__c = 'cold' and l.[Status] = 'open' and CurrentOwner is null and sfdc_id is null
and LEFT(l.PostalCode,4) not in ('NP22','NP23','NP24','PE20','PE21','PE22','PE23','PE24','PE25','PH15','PH18','PH19',
'PH20','PH21','PH22','PH23','PH24','PH25','PH30','PH31','PH32','PH33','PH34','PH35','PH36','PH37','PH38','PH39','PH40',
'PH41','PH42','PH43','PH44','PH45','PH46','PH47','PH48','PH49','PH50','PO30','PO31','PO32','PO33','PO34','PO35','PO36','PO37','PO38',
'PO39','PO40','PO41','SY10','SY15','SY16','SY17','SY18','SY19','SY20','SY21','SY23',
'SY24',
'SY25',
'SY26',
'SY27',
'SY28',
'SY29',
'SY30',
'SY31',
'SY32',
'SY33',
'SY34',
'SY35',
'SY36',
'SY37',
'SY38',
'SY39',
'SY40',
'SY41',
'SY42',
'SY43',
'SY44',
'SY45',
'SY46',
'SY47',
'SY48',
'SY49',
'SY50',
'SY51',
'SY52',
'SY53',
'SY54',
'SY55',
'SY56',
'SY57',
'SY58',
'SY59',
'SY60',
'SY61',
'SY62',
'SY63',
'SY64',
'SY65',
'SY66',
'SY67',
'SY68',
'SY69',
'SY70',
'SY71',
'SY72',
'SY73',
'SY74',
'SY75',
'SY76',
'SY77',
'SY78',
'SY79',
'SY80',
'SY81',
'SY82',
'SY83',
'SY84',
'SY85',
'SY86',
'SY87',
'SY88',
'SY89',
'SY90',
'SY91',
'SY92',
'SY93',
'SY94',
'SY95',
'SY96',
'SY97',
'SY98',
'SY99',
'TD10','TD11','TD12','TD14')
AND LEFT(l.PostalCode, 4) not in ('TD15','AB99','BD13','BD16','BD17','BD18','BD20','BD20',
'BD21',
'BD22',
'BD23',
'BD24',
'BD25',
'BD26',
'BD27',
'BD28',
'BD29',
'BD30',
'BD31',
'BD32',
'BD33',
'BD34',
'BD35',
'BD36',
'BD37',
'BD38',
'BD39',
'BD40',
'BD41',
'BD42',
'BD43',
'BD44',
'BD45',
'BD46',
'BD47',
'BD48',
'BD49',
'BD50',
'BD51',
'BD52',
'BD53',
'BD54',
'BD55',
'BD56',
'BD57',
'BD58',
'BD59',
'BD60',
'BD61',
'BD62',
'BD63',
'BD64',
'BD65',
'BD66',
'BD67',
'BD68',
'BD69',
'BD70',
'BD71',
'BD72',
'BD73',
'BD74',
'BD75',
'BD76',
'BD77',
'BD78',
'BD79',
'BD80',
'BD81',
'BD82',
'BD83',
'BD84',
'BD85',
'BD86',
'BD87',
'BD88',
'BD89',
'BD90',
'BD91',
'BD92',
'BD93',
'BD94',
'BD95',
'BD96',
'BD97',
'BD98',
'BD99')
AND LEFT(l.PostalCode,4) not in ('CF31',
'CF32',
'CF33',
'CF34',
'CF35',
'CF36',
'CF37',
'CF38',
'CF39',
'CF40',
'CF41',
'CF42',
'CF43',
'CF44',
'CF45',
'CF46',
'CF47',
'CF48',
'CF49',
'CF50',
'CF51',
'CF52',
'CF53',
'CF54',
'CF55',
'CF56',
'CF57',
'CF58',
'CF59',
'CF60',
'CF61',
'CF62',
'CF63',
'CF64',
'CF65',
'CF66',
'CF67',
'CF68',
'CF69',
'CF70',
'CF71',
'CF72',
'CF73',
'CF74',
'CF75',
'CF76',
'CF77',
'CF78',
'CF79',
'CF80',
'CF81',
'CF82',
'CF83',
'CF84',
'CF85',
'CF86',
'CF87',
'CF88',
'CF89',
'CF90',
'CF91',
'CF92',
'CF93',
'CF94',
'CF95',
'CF96',
'CF97',
'CF98',
'CF99',
'EX20','EX21','EX31','EX33','EX34','EX35','EX29')
AND LEFT(l.PostalCode, 3) not in ('SY6','SY7','SY8','SY9','TD3','TD4','TD5','TD6','TD8','TD9')
AND LEFT(l.postalcode, 2) not in ('PA','PL','SA','TQ','TR','BT','GY','HS','IM','IV','JE','KW','LD')
AND l.Total_Employees__c between 6 and 199
and SIC2007_Code2__c not in (55,81,56,47,93) and SIC2007_Code3__c not in (69102,49320,86230)