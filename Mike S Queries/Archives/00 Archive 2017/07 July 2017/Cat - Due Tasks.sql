SELECT u.FullName, t.taskName, t.taskNotes, t.dateDue
FROM Shorthorn..cit_sh_tasks t
left outer join Shorthorn..cit_sh_taskTypes tt ON t.taskTypeID = tt.taskTypeID
left outer join Shorthorn..cit_sh_users u ON t.userID = u.userID
left outer join Shorthorn..cit_sh_advice ad ON t.adviceID = ad.adviceID
WHERE u.dept = 7 and deleted = 0
ORDER BY u.FullName, t.dateDue desc