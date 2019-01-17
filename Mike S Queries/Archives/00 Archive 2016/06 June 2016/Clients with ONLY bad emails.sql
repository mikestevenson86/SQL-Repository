SELECT AccountID
INTO #GoodEmails
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
WHERE a.IsActive__c = 'true' and
Email NOT like 'abuse@%' and
Email NOT like 'database@%' and
Email NOT like 'fbl@%' and
Email NOT like 'ftp@%' and
Email NOT like 'noc@%' and
Email NOT like 'post@%' and
Email NOT like 'postbox@%' and
Email NOT like 'postmaster@%' and
Email NOT like 'privacy@%' and
Email NOT like 'remove@%' and
Email NOT like 'root@%' and
Email NOT like 'spam@%' and
Email NOT like 'subscribe@%' and
Email NOT like 'uucp@%' and
Email NOT like 'webmaster@%' and
Email NOT like 'welcome@%' and
Email NOT like 'www@%' and
Email NOT like 'admin@%' and
Email NOT like 'administracion@%' and
Email NOT like 'administration@%' and
Email NOT like 'advisor@%' and
Email NOT like 'alexa@%' and
Email NOT like 'all@%' and
Email NOT like 'available@%' and
Email NOT like 'billing@%' and
Email NOT like 'bursar@%' and
Email NOT like 'busdev@%' and
Email NOT like 'ceo@%' and
Email NOT like 'co-op@%' and
Email NOT like 'community@%' and
Email NOT like 'compete@%' and
Email NOT like 'consultant@%' and
Email NOT like 'contact@%' and
Email NOT like 'contacto@%' and
Email NOT like 'crew@%' and
Email NOT like 'customercare@%' and
Email NOT like 'customerservice@%' and
Email NOT like 'data@%' and
Email NOT like 'dean@%' and
Email NOT like 'design@%' and
Email NOT like 'digsitesvalue@%' and
Email NOT like 'director@%' and
Email NOT like 'directors@%' and
Email NOT like 'directory@%' and
Email NOT like 'download@%' and
Email NOT like 'editor@%' and
Email NOT like 'editorial@%' and
Email NOT like 'editors@%' and
Email NOT like 'enq@%' and
Email NOT like 'enquire@%' and
Email NOT like 'enquiries@%' and
Email NOT like 'enquiry@%' and
Email NOT like 'everyone@%' and
Email NOT like 'exec@%' and
Email NOT like 'executive@%' and
Email NOT like 'executives@%' and
Email NOT like 'expert@%' and
Email NOT like 'experts@%' and
Email NOT like 'export@%' and
Email NOT like 'head.office@%' and
Email NOT like 'head@%' and
Email NOT like 'headoffice@%' and
Email NOT like 'headteacher@%' and
Email NOT like 'hostmaster@%' and
Email NOT like 'hr@%' and
Email NOT like 'info@%' and
Email NOT like 'information@%' and
Email NOT like 'informativo@%' and
Email NOT like 'investorrelations@%' and
Email NOT like 'jobs@%' and
Email NOT like 'marketing@%' and
Email NOT like 'master@%' and
Email NOT like 'media@%' and
Email NOT like 'office@%' and
Email NOT like 'officeadmin@%' and
Email NOT like 'operations@%' and
Email NOT like 'prime@%' and
Email NOT like 'principal@%' and
Email NOT like 'reception@%' and
Email NOT like 'recruit@%' and
Email NOT like 'recruiting@%' and
Email NOT like 'request@%' and
Email NOT like 'sales@%' and
Email NOT like 'school@%' and
Email NOT like 'schooloffice@%' and
Email NOT like 'secretary@%' and
Email NOT like 'security@%' and
Email NOT like 'theoffice@%' and
Email NOT like 'usenet@%' and
Email NOT like 'users@%'

SELECT c.AccountID, c.Id, a.Name, c.FirstName, c.LastName, c.Position__c, c.Phone, c.Email, Main_User__c, Online_Super_User__c, Helpline_H_S__c, Helpline_PEL__c
FROM Salesforce..Contact c
inner join Salesforce..Account a ON c.AccountId = a.Id
left outer join #GoodEmails ge ON a.Id = ge.AccountId
WHERE ge.AccountId is null and a.IsActive__c = 'true' and
(
Email like 'abuse@%' or
Email like 'database@%' or
Email like 'fbl@%' or
Email like 'ftp@%' or
Email like 'noc@%' or
Email like 'post@%' or
Email like 'postbox@%' or
Email like 'postmaster@%' or
Email like 'privacy@%' or
Email like 'remove@%' or
Email like 'root@%' or
Email like 'spam@%' or
Email like 'subscribe@%' or
Email like 'uucp@%' or
Email like 'webmaster@%' or
Email like 'welcome@%' or
Email like 'www@%' or
Email like 'admin@%' or
Email like 'administracion@%' or
Email like 'administration@%' or
Email like 'advisor@%' or
Email like 'alexa@%' or
Email like 'all@%' or
Email like 'available@%' or
Email like 'billing@%' or
Email like 'bursar@%' or
Email like 'busdev@%' or
Email like 'ceo@%' or
Email like 'co-op@%' or
Email like 'community@%' or
Email like 'compete@%' or
Email like 'consultant@%' or
Email like 'contact@%' or
Email like 'contacto@%' or
Email like 'crew@%' or
Email like 'customercare@%' or
Email like 'customerservice@%' or
Email like 'data@%' or
Email like 'dean@%' or
Email like 'design@%' or
Email like 'digsitesvalue@%' or
Email like 'director@%' or
Email like 'directors@%' or
Email like 'directory@%' or
Email like 'download@%' or
Email like 'editor@%' or
Email like 'editorial@%' or
Email like 'editors@%' or
Email like 'enq@%' or
Email like 'enquire@%' or
Email like 'enquiries@%' or
Email like 'enquiry@%' or
Email like 'everyone@%' or
Email like 'exec@%' or
Email like 'executive@%' or
Email like 'executives@%' or
Email like 'expert@%' or
Email like 'experts@%' or
Email like 'export@%' or
Email like 'head.office@%' or
Email like 'head@%' or
Email like 'headoffice@%' or
Email like 'headteacher@%' or
Email like 'hostmaster@%' or
Email like 'hr@%' or
Email like 'info@%' or
Email like 'information@%' or
Email like 'informativo@%' or
Email like 'investorrelations@%' or
Email like 'jobs@%' or
Email like 'marketing@%' or
Email like 'master@%' or
Email like 'media@%' or
Email like 'office@%' or
Email like 'officeadmin@%' or
Email like 'operations@%' or
Email like 'prime@%' or
Email like 'principal@%' or
Email like 'reception@%' or
Email like 'recruit@%' or
Email like 'recruiting@%' or
Email like 'request@%' or
Email like 'sales@%' or
Email like 'school@%' or
Email like 'schooloffice@%' or
Email like 'secretary@%' or
Email like 'security@%' or
Email like 'theoffice@%' or
Email like 'usenet@%' or
Email like 'users@%'
)

DROP TABLE #GoodEmails