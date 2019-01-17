SELECT CONVERT(date, IssueDate) TicketDate, COUNT(IssueID)
FROM Incidents.hdissues
WHERE CategoryID in (14,16) and DATEPART(Month, IssueDate) = 9 and DATEPART(Year, IssueDate) = 2016
GROUP BY CONVERT(date, IssueDate)
ORDER BY  CONVERT(date, IssueDate)