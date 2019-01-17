SELECT ct.coName, ct.uid, ct.parentUID, em.title, em.fName, em.knownAs, em.sName, em.prevName, em.dob, em.sex, em.niNumber, em.nationality,
em.employmentType, em.employmentStatus, em.drivingLicNo, em.drivingLicIssued, em.holidayEnt, em.startDate,
ec.add1, ec.add2, ec.town, ec.county, ec.postcode, ec.tel, ec.mob, ec.email
FROM CitationMain..citation_CompanyTable2 ct
inner join CitationMain..cit_tfl_Employee em ON ct.uid = em.compID
inner join CitationMain..cit_tfl_EmployeeContactDetails ec ON em.empUID = ec.empUID
WHERE sageAC = 'MAVE01' or parentUID = 14277