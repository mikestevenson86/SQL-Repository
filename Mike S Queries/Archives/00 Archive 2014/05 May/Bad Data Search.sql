SELECT COUNT(id), Company
FROM Salesforce..Lead
WHERE Company in ('P C World',
'Royal Mail Group Ltd',
'Kwik Fit',
'Reed Employment PLC',
'American Golf Ltd',
'The Money Shop',
'Mencap',
'The Co-operative Food',
'Currys',
'Learn Direct',
'Hays Specialist Recruitment',
'Jewson',
'Holland and Barrett',
'The Body Shop',
'Bedfordshire Police',
'Manpower',
'The Royal Mail',
'Perrys',
'Autoglass',
'Heaven V',
'Age UK',
'Nandos',
'Job Centre Plus',
'Virgin Media',
'HM Revenue and Customs',
'Booker Cash and Carry',
'Howdens Joinery Company',
'Territorial Army',
'Network Rail',
'National Archives of Scotland',
'Procurator Fiscal',
'Fire and Rescue Service',
'Central Scotland Police',
'Stratchclyde Police',
'British Army',
'32 Signal Regiment',
'Member of Scottish Parliament',
'South Lanarkshire Council',
'51 Signal Squadron',
'H M Coastguard',
'Aldi Stores Ltd',
'Secom PLC',
'Scotts Quaker Oats Ltd',
'Health and Safety Executive',
'Citizens Advice Bureau',
'DHL Supply Chain',
'Dagenham Motors Plc',
'MP%s',
'Police',
'Cartridge Works',
'Ree Specialist Recruitment',
'Machine Mart',
'Topps Tiles PLC',
'Sainsburys Local',
'Forest Freight Ltd',
'Maplin Electronics Ltd',
'Stagecoach',
'National Windscreens',
'Nu Interiors Northern Ltd',
'Total Catering Equipment',
'Social Services',
'Your Move',
'Inchcape Volkswagen',
'Lush',
'Avis Rent A Car',
'Securitas',
'Neighbourhood Watch',
'Odeon Cinemas Ltd',
'Tarmac Ltd',
'Victim Support',
'The Princes Trust',
'PC World',
'Tesco Express'
)
GROUP BY Company