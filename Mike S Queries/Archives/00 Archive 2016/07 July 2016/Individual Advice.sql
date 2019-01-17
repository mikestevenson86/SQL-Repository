DECLARE @Subject AS VARCHAR(MAX)
SET @Subject = ''

SELECT	s.siteName,
		CONVERT(VARCHAR(10),a.dateOfCall,103) AS 'Date Of Call', 
		ISNULL(u.fName, '') + ' ' + ISNULL(u.sName, '') AS Consultant, 
		ISNULL(c.fName, '') + ' ' + ISNULL(c.sName, '') AS Contact, 
		a.advicecard AS [Advice Card],
		ISNULL(e.fName, '') + ' ' + ISNULL(e.sName, '') AS Employee, 
		CASE WHEN a.appraisal = 1 THEN @Subject + 'Appraisal' 
			 WHEN a.capability = 1 THEN @Subject + 'Capability/Suitability' 
			 WHEN a.compromiseAgreement = 1 THEN @Subject + 'Compromise Agreement'
			 WHEN a.cyj = 1 THEN @Subject + 'CYJ'
			 WHEN a.disProc= 1 THEN @Subject + 'Disciplinary Procedure'
			 WHEN a.disAppeal= 1 THEN @Subject + 'Disciplinary Appeal'
			 WHEN a.discrimination= 1 THEN @Subject + 'Discrimination (specify)'
			 WHEN a.discrimination= 1 AND a.discriminationText <> '' THEN @Subject + '_' + a.discriminationText
			 WHEN a.domestic = 1 THEN @Subject + 'Performance' 
			 WHEN a.flexWork = 1 THEN @Subject + 'Flexible Working' 
			 WHEN a.grievance = 1 THEN @Subject + 'Grievance Procedure' 
			 WHEN a.holiday = 1 THEN @Subject + 'Holiday Entitlement' 
			 WHEN a.layOff = 1 THEN @Subject + 'Lay Off/Short Time' 
			 WHEN a.letterOfConcern = 1 THEN @Subject + 'Letter of Concern' 
			 WHEN a.maternity = 1 THEN @Subject + 'Maternity/Adoption Leave' 
			 WHEN a.medical = 1 THEN @Subject + 'Medical Reports/Records' 
			 WHEN a.minWage = 1 THEN @Subject + 'National Minimum Wage' 
			 WHEN a.noticePeriod = 1 THEN @Subject + 'Notice Periods' 
			 WHEN a.parentalLeave = 1 THEN @Subject + 'Parental Leave' 
			 WHEN a.partTime = 1 THEN @Subject + 'Part Time Working' 
			 WHEN a.paternity = 1 THEN @Subject + 'Paternity Leave' 
			 WHEN a.pregnancy = 1 THEN @Subject + 'Pregnancy' 
			 WHEN a.termination = 1 THEN @Subject + 'Probation' 			 
			 WHEN a.recruitment = 1 THEN @Subject + 'Recruitment' 			 
			 WHEN a.redundancy = 1 THEN @Subject + 'Redundancy' 			 
			 WHEN a.resignation = 1 THEN @Subject + 'Resignation' 			 
			 WHEN a.retirement = 1 THEN @Subject + 'Retirement' 			 
			 WHEN a.salary = 1 THEN @Subject + 'Salary/Wage' 			 			 
			 WHEN a.sickness = 1 THEN @Subject + 'Sickness Absence' 			 
			 WHEN a.SMP = 1 THEN @Subject + 'SMP/SAP/SPP' 			 			 
			 WHEN a.SOSR = 1 THEN @Subject + 'SOSR' 			 
			 WHEN a.SSP = 1 THEN @Subject + 'SSP' 			 
			 WHEN a.termsAndConditions = 1 THEN @Subject + 'Terms & Conditions' 			 
			 WHEN a.TUPE = 1 THEN @Subject + 'TUPE' 			 
			 WHEN a.TURec = 1 THEN @Subject + 'TU Recognition' 			 
			 WHEN a.unauthAbsc = 1 THEN @Subject + 'Unauthorised Absence' 			 
			 WHEN a.workTimeRegs = 1 THEN @Subject + 'Working Time Regs' 			 
			 WHEN a.whistleBlowing = 1 THEN @Subject + 'Whistle Blowing' 			 
			 WHEN a.other = 1 THEN @Subject + 'Other ' 			 			 
			 WHEN a.other = 1 AND a.otherText <> '' THEN @Subject + '_' + a.otherText
		END AS [Subject],
		REPLACE(REPLACE(REPLACE(REPLACE(a.advice_note,'<p>',''),'</p>',CHAR(13)),'<strong>',''),'</strong>','') [Advice Note]
 FROM cit_sh_advice AS a 
 INNER JOIN cit_sh_users AS u ON a.consultant = u.userID 
 INNER JOIN cit_sh_contacts AS c ON a.contactID = c.contactID 
 INNER JOIN cit_sh_employees AS e ON a.empID = e.empID 
 INNER JOIN cit_sh_sites AS s ON a.siteID = s.siteID 
 INNER JOIN cit_sh_clients AS cl ON s.clientID = cl.clientID 
 WHERE a.dateOfCall BETWEEN '2016-01-01' AND GETDATE() 
 		AND cl.companyName like '%bannatyne%'
 ORDER BY cl.companyName, a.dateOfCall