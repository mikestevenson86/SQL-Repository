
SELECT Name, telephoneNumber, Department, Title
FROM OPENQUERY( ADSI, 
   'SELECT Name, TelephoneNumber, Department, title
   FROM ''LDAP://CITATION/ DC=citation,DC=co,DC=uk''
   WHERE objectCategory = ''Person'' AND
      objectClass = ''user''')
WHERE telephoneNumber is not null and telephoneNumber <> 'Leaver'
ORDER BY Department,Name