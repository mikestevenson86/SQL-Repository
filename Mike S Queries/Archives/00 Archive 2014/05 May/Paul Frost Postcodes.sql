SELECT u.id
FROM Salesforce..[User] u
WHERE u.Name = 'Paul Frost'

SELECT l.id
FROM Salesforce..Lead l
inner join Salesforce..[User] u on l.OwnerId collate latin1_general_CS_AS = u.Id collate latin1_general_CS_AS
WHERE u.Name <> 'Paul Frost' and (
l.PostalCode like 'BS%' or
l.PostalCode like 'SN%' or
l.PostalCode like 'BA%' or
l.PostalCode like 'TA%' or
l.PostalCode like 'EX%' or
l.PostalCode like 'NP%' or
l.PostalCode like 'GL1 %' or
l.PostalCode like 'GL2 %' or
l.PostalCode like 'GL3 %' or
l.PostalCode like 'GL4 %' or
l.PostalCode like 'GL5 %' or
l.PostalCode like 'GL6 %' or
l.PostalCode like 'GL7 %' or
l.PostalCode like 'GL8 %' or
l.PostalCode like 'GL9 %' or
l.PostalCode like 'GL10%' or
l.PostalCode like 'GL11%' or
l.PostalCode like 'GL12%' or
l.PostalCode like 'GL13%' or
l.PostalCode like 'GL14%' or
l.PostalCode like 'GL15%' or
l.PostalCode like 'GL16%' or
l.PostalCode like 'GL17%' or
l.PostalCode like 'GL18%' or
l.PostalCode like 'GL19%' or
l.PostalCode like 'CF3 %' or
l.PostalCode like 'CF4 %' or
l.PostalCode like 'CF5 %' or
l.PostalCode like 'CF6 %' or
l.PostalCode like 'CF7 %' or
l.PostalCode like 'CF8 %' or
l.PostalCode like 'CF9 %' or
l.PostalCode like 'CF10%' or
l.PostalCode like 'CF11%' or
l.PostalCode like 'CF12%' or
l.PostalCode like 'CF13%' or
l.PostalCode like 'CF14%' or
l.PostalCode like 'CF15%' or
l.PostalCode like 'CF16%' or
l.PostalCode like 'CF17%' or
l.PostalCode like 'CF18%' or
l.PostalCode like 'CF19%' or
l.PostalCode like 'CF20%' or
l.PostalCode like 'CF21%' or
l.PostalCode like 'CF22%' or
l.PostalCode like 'CF23%' or
l.PostalCode like 'CF24%' or
l.PostalCode like 'CF71%') and (
l.PostalCode not like 'EX20%' or
l.PostalCode not like 'EX21%' or
l.PostalCode not like 'EX22%' or
l.PostalCode not like 'EX23%' or
l.PostalCode not like 'EX31%' or
l.PostalCode not like 'EX33%' or
l.PostalCode not like 'EX34%' or
l.PostalCode not like 'EX35%' or
l.PostalCode not like 'EX39%' or
l.PostalCode not like 'NP21%' or
l.PostalCode not like 'NP22%' or
l.PostalCode not like 'NP23%' or
l.PostalCode not like 'NP24%')
