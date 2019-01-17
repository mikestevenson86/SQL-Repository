SELECT 
AccountId
INTO
#BadEmail
FROM 
Salesforce..Contact
WHERE 
LEFT(Email, CHARINDEX('@',Email)) in
(
'abuse@',
'database@',
'fbl@',
'ftp@',
'noc@',
'post@',
'postbox@',
'postmaster@',
'privacy@',
'remove@',
'root@',
'spam@',
'subscribe@',
'uucp@',
'webmaster@',
'welcome@',
'www@',
'admin@',
'administracion@',
'administration@',
'advisor@',
'alexa@',
'all@',
'available@',
'billing@',
'bursar@',
'busdev@',
'ceo@',
'co-op@',
'community@',
'compete@',
'consultant@',
'contact@',
'contacto@',
'crew@',
'customercare@',
'customerservice@',
'data@',
'dean@',
'design@',
'digsitesvalue@',
'director@',
'directors@',
'directory@',
'download@',
'editor@',
'editorial@',
'editors@',
'enq@',
'enquire@',
'enquiries@',
'enquiry@',
'everyone@',
'exec@',
'executive@',
'executives@',
'expert@',
'experts@',
'export@',
'head.office@',
'head@',
'headoffice@',
'headteacher@',
'hostmaster@',
'hr@',
'info@',
'information@',
'informativo@',
'investorrelations@',
'jobs@',
'marketing@',
'master@',
'media@',
'office@',
'officeadmin@',
'operations@',
'prime@',
'principal@',
'reception@',
'recruit@',
'recruiting@',
'request@',
'sales@',
'school@',
'schooloffice@',
'secretary@',
'security@',
'theoffice@',
'usenet@',
'users@'
)
GROUP BY
AccountId

SELECT 
AccountId
INTO
#GoodEmail
FROM 
Salesforce..Contact
WHERE 
LEFT(Email, CHARINDEX('@',Email)) not in
(
'abuse@',
'database@',
'fbl@',
'ftp@',
'noc@',
'post@',
'postbox@',
'postmaster@',
'privacy@',
'remove@',
'root@',
'spam@',
'subscribe@',
'uucp@',
'webmaster@',
'welcome@',
'www@',
'admin@',
'administracion@',
'administration@',
'advisor@',
'alexa@',
'all@',
'available@',
'billing@',
'bursar@',
'busdev@',
'ceo@',
'co-op@',
'community@',
'compete@',
'consultant@',
'contact@',
'contacto@',
'crew@',
'customercare@',
'customerservice@',
'data@',
'dean@',
'design@',
'digsitesvalue@',
'director@',
'directors@',
'directory@',
'download@',
'editor@',
'editorial@',
'editors@',
'enq@',
'enquire@',
'enquiries@',
'enquiry@',
'everyone@',
'exec@',
'executive@',
'executives@',
'expert@',
'experts@',
'export@',
'head.office@',
'head@',
'headoffice@',
'headteacher@',
'hostmaster@',
'hr@',
'info@',
'information@',
'informativo@',
'investorrelations@',
'jobs@',
'marketing@',
'master@',
'media@',
'office@',
'officeadmin@',
'operations@',
'prime@',
'principal@',
'reception@',
'recruit@',
'recruiting@',
'request@',
'sales@',
'school@',
'schooloffice@',
'secretary@',
'security@',
'theoffice@',
'usenet@',
'users@'
)
GROUP BY
AccountId

SELECT COUNT(Id)
FROM Salesforce..Account a
left outer join #BadEmail be ON a.Id = be.AccountId
left outer join #GoodEmail ge ON a.Id = ge.AccountId
WHERE IsActive__c = 'true' and be.AccountId is not null and ge.AccountId is null

SELECT COUNT(Id)
FROM Salesforce..Account a
left outer join #BadEmail be ON a.Id = be.AccountId
left outer join #GoodEmail ge ON a.Id = ge.AccountId
WHERE IsActive__c = 'true' and be.AccountId is null and ge.AccountId is not null

SELECT COUNT(a.Id)
FROM Salesforce..Account a
left outer join #BadEmail be ON a.Id = be.AccountId
left outer join #GoodEmail ge ON a.Id = ge.AccountId
WHERE IsActive__c = 'true' and be.AccountId is not null and ge.AccountId is not null

DROP TABLE #BadEmail
DROP TABLE #GoodEmail