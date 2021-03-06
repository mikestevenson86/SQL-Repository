SELECT fu.LeadId, fu.Process, fu.Phone, fu.RunDate, lh.CreatedDate, u.Name, fu2.RunDate, fu2.Phone
FROM [LeadChangeReview].[dbo].[Fallow_SFDCUpdates] fu
inner join Salesforce..LeadHistory lh ON fu.LeadId = lh.LeadId 
											and lh.Field = 'Phone' 
											and lh.CreatedDate > fu.RunDate
inner join Salesforce..[User] u ON lh.CreatedById = u.Id
inner join Salesforce..[Profile] p ON u.ProfileId = p.Id
inner join [LeadChangeReview].[dbo].[Fallow_SFDCUpdates] fu2 ON lh.LeadId = fu2.LeadId 
																and fu2.Process in ('TPS - New Phone','TPS - CreditSafe New Phone')
																and fu2.Reason = 'Operation Successful.'
																and fu2.RunDate > lh.CreatedDate
WHERE p.Name like '%BDC%' and fu.Process in ('TPS - New Phone','TPS - CreditSafe New Phone') and fu.Reason = 'Operation Successful.'