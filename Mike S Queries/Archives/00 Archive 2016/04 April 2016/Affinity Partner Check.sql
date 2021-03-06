SELECT ID, 'Affinity - Database' Affinity_Cold__c
FROM Salesforce..Lead
WHERE Affinity_Cold__c <> 'Affinity - Database' and Sector__c is not null and Affinity_Industry_Type__c in 
(
'Assn of British Dispensing Opticians - ABDO',
'Association of British Travel Agents - ABTA',
'Association of Interior Specialists - AIS',
'Automatic Door Suppliers Association - ADSA',
'Autosafe',
'BBSA',
'Beverage Services Assn - BSA',
'BHA',
'BICs',
'BICS Member',
'BICS Non Member',
'BICSc',
'BIFA',
'British Contract Furnishing Association - BCFA',
'British Equestrian Trade Assn - BETA',
'British Promotional Merchandise Association - BPMA',
'British Signs & Graphics Association - BSGA',
'British Water Cooler Assn - BWCA',
'BSIA',
'Catering Equipment Suppliers Assn - CESA',
'CESA',
'CORC',
'CPT',
'Door & Hardware Federation - DHF',
'ECCA',
'EIA',
'FENSA',
'FIS',
'Fitness Industries Assns - FIA',
'FSDF',
'GFF',
'GGF',
'Guild of Fine Food - GFF',
'HCA',
'HTA',
'IAAS',
'Manufacturing Technologies Assn - MTA',
'MITA',
'MUTA',
'NAFD',
'National Access & Scaffolding Confederation - NASC',
'National Association of Shopfitters - NAS',
'National Golf Clubs Advisory Association - NGCAA',
'National Insulation Assn - NIA',
'NCA',
'NDNA',
'NHF',
'NPA',
'NSI',
'Performance Textiles Association - MUTA',
'Processing and Packaging Machinery Association - PPMA',
'REA',
'REC',
'RHA',
'SCA',
'SEA',
'SECHA',
'Shop & Display Equipment Assn - SDEA',
'SPVS',
'SSAIB',
'St Francis',
'Surrey Care Association',
'The Survey Association - TSA',
'Timber Trade Federation - TTF',
'UBT',
'UK Science Park Association - UKSPA',
'UK Trades Confederation - UKTC',
'UKHCA',
'UKWA',
'WMCA'
)