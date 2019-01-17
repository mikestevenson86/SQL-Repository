SELECT a.Id, BillingPostalCode,
case when LEFT(BillingPostalCode, 4) in ('NP21','NP22','NP23','NP24') 
OR LEFT(BillingPostalCode, 2) in ('WV','DE','WS','TF') then (SELECT Id FROM Salesforce..[User] WHERE Name = 'Gary Smith')
when LEFT(BillingPostalCode, 4) in ('BD13','BD15','BD16','BD20','BD21','BD22','BD23','BD24','LS16','LS17','LS18','LS19','LS20','LS21','LS22',
'LS23','LS24','LS25','LS26','LS27','LS28','LS29') 
OR LEFT(BillingPostalCode, 2) in ('NE','SR','TS','YO','CA','DL','DH','HG') then (SELECT Id FROM Salesforce..[User] WHERE Name = 'Trevor Kerins') 
when LEFT(BillingPostalCode, 2) in ('SY','LL') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Simon Burlison')
when LEFT(BillingPostalCode, 2) in ('L1','L2','L3','L4','L5','L6','L7','L8','L9','WA','CH','CW','ST') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Ben Williams')
when LEFT(BillingPostalCode, 2) in ('M1','M2','M3','M4','M5','M6','M7','M8','M9','FY','LA','PR','BB','WN','OL','BL','SK') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'James OHare')
when LEFT(BillingPostalCode, 3) in ('LS1','LS2','LS3','LS4','LS5','LS6','LS7','LS8','LS9','BD1','BD2','BD3','BD4','BD5','BD6','BD7','BD8','BD9') 
OR LEFT(BillingPostalCode, 4) in ('LS10','LS11','LS12','LS13','LS14','LS15','BD10','BD11','BD12','BD14','BD17','BD18','BD19')
OR LEFT(BillingPostalCode, 2) in ('S1','S2','S3','S4','S5','S6','S7','S8','S9','DN','HD','HU','WF','HX') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Louise Rogers')
when LEFT(BillingPostalCode, 4) in ('IV10','IV11','IV12','IV13','IV14','IV15','IV16','IV17','IV18','IV19','IV20','IV21','IV22','IV23','IV24',
'IV25','IV26','IV27','IV29','IV30','IV31','IV32','IV33','IV34','IV35','IV36','IV37','IV38','IV40','IV41','IV42','IV43','IV44','IV45','IV46',
'IV47','IV48','IV49','IV51','IV55','IV56','AB10','AB11','AB12','AB13','AB14','AB15','AB16','AB21','AB22','AB23','AB24','AB25','AB31','AB32',
'AB33','AB34','AB35','AB36','AB37','AB38','AB41','AB42','AB43','AB44','AB45','AB51','AB52','AB53','AB54','AB55','AB56','AB99',
'PH20','PH21','PH22','PH23','PH24','PH25','PH26')
OR LEFT(BillingPostalCode, 3) in  ('IV1','IV2','IV3','IV7') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Scott Roberts')
when LEFT(BillingPostalCode, 2) in ('NR','IP','CB','CO','SG','CM','PE') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Bill Bourne')
when LEFT(BillingPostalCode, 2) in ('SL','WD','HA','UB','TW','KT','SM','CR','W2','W3','W4','W5','W6','W7','W8','W9')
OR LEFT(BillingPostalCode, 3) in ('W10','W11','W12','W13','W14') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Peter Taylor' and IsActive = 'true')
when LEFT(BillingPostalCode, 3) in ('N11','N12','N13','N14','N17','N18','N20','N21','N22')
OR LEFT(BillingPostalCode, 2) in ('MK','NN','LU','AL','EN','HP','NW','N9') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Alastair Stevens')
when LEFT(BillingPostalCode, 2) in ('SW','W1','N2','N3','N4','N5','N6','N7','N8','WC','TN')
OR LEFT(BillingPostalCode, 3) in ('N10','N15','N16','N19') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Matthew Hall')
when LEFT(BillingPostalCode, 2) in ('BN','RH','PO','BH') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Marina Ashman')
when LEFT(BillingPostalCode, 2) in ('B1','B2','B3','B4','B5','B6','B7','B8','B9','DY','WR','CV')
OR LEFT(BillingPostalCode, 4) in ('GL20','GL50','GL51','GL52','GL53','GL54','GL55','GL56') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Mark Kelsall')
when LEFT(BillingPostalCode, 2) in ('BS','BA','TA','NP','SN','HR','LD','CF','SA')
OR LEFT(BillingPostalCode, 3) in ('GL1','GL2','GL3','GL4','GL5','GL6','GL7','GL8','GL9')
OR LEFT(BillingPostalCode, 4) in ('GL10','GL11','GL12','GL13','GL14','GL15','GL16','GL17','GL18','GL19') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Paul Frost')
when LEFT(BillingPostalCode, 2) in ('SS','IG','RM','DA','ME','CT','BR','SE','EC','N1','E1','E2','E3','E4','E5','E6','E7','E8','E9')
then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Justin McCormick')
when LEFT(BillingPostalCode, 2) in ('DT','EX','TQ','TR','PL') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Rachael Walters')
when LEFT(BillingPostalCode, 2) in ('OX','RG','SP','SO','GU') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Sean Abel')
when LEFT(BillingPostalCode, 2) in ('FK','KY','EH','DD','TD','G1','G2','G3','G4','G5','G6','G7','G8','G9','ML')
OR LEFT(BillingPostalCode, 3) in ('PH1','PH2','PH3','PH4','PH5','PH6','PH7','PH8','PH9')
OR LEFT(BillingPostalCode, 4) in ('AB30','AB39') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'William McFaulds')
when LEFT(BillingPostalCode, 2) = 'BT' then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Angela Prior')
when LEFT(BillingPostalCode, 2) in ('PA','KA','DG') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Dominic Miller')
when LEFT(BillingPostalCode, 2) in ('LE','NG','LN') then (SELECT ID FROM Salesforce..[User] WHERE Name = 'Tim Kirk')
end OwnerId
FROM Salesforce..Account a
inner join Salesforce..[User] u ON a.OwnerId = u.Id
WHERE u.Name = 'Simon Whight'