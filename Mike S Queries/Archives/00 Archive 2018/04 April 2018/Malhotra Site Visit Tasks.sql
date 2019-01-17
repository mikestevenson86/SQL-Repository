-- Observation, Recommendation, Status, Responsible, Deadline, Completed, 100% Completed, Priority, Rectification Cost

SELECT s.id AS SiteId, 
       s.NAME AS SiteName, sv.*
FROM   sites s 
       LEFT OUTER JOIN shared.users u  ON u.companyid = s.companyid 
	   LEFT OUTER JOIN dbo.SiteVisits sv ON s.Id = sv.SiteId
          
WHERE  u.id = '77A0830B-EEAD-4B9A-A896-F1345BBC6C03' and s.IsDeleted = 0

SELECT * FROM TaskActivities
SELECT * FROM TaskSubActions
SELECT * FROM Shared.TaskCategories
SELECT * FROM Shared.TaskCategoryOtcMap
SELECT * FROM Shared.TaskCategoryPermissions