SELECT ISNULL(fName, '') + ' ' + ISNULL(sName, '') AS Consultant, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
AS totalCancelled, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
AS visitType1, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
AS visitType2, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
AS visitType3, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_dealsHS AS h1 
LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID 
WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1))
) 
AS visitTypeInst, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 1)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 1)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 1)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 1)
) 
AS cancelledByClient, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 2)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 2)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 2)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_visitCancellationReasons AS cr 
INNER JOIN cit_sh_HSCancellations AS c1 ON cr.vcID = c1.reason 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (cr.cancelledBy = 2)
) AS cancelledByConsultant, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 14)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 14)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 14)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 14)
) AS clientAccessDenied, 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 1)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 1)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 1)
) 
+ 
(
SELECT COUNT(*) AS c 
FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 1)
) AS clientNoReason, 
(
SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 
RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID 
WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) 
AND (c1.reason = 2)
) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 2)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 2)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 2)) AS clientSickness, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 3)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 3)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 3)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 3)) AS clientRelatedTo, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 4)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 4)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 4)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 4)) AS clientForgot, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 5)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 5)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 5)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 5)) AS clientOperational, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 6)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 6)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 6)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 6)) AS consultantSick, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 7)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 7)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 7)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 7)) AS consultantInstructedFinance, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) AS consultantTransport, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 8)) AS consultantTrafficWeather, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 10)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 10)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 10)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 10)) AS consultantLate, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 11)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 11)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 11)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 11)) AS consultantOperational, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 12)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 12)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 12)) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason = 12)) AS consultantClientAgreement, (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason IN (NULL, 0, 13))) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason IN (NULL, 0, 13))) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason IN (NULL, 0, 13))) + (SELECT COUNT(*) AS c FROM cit_sh_HSCancellations AS c1 RIGHT OUTER JOIN cit_sh_dealsHS AS h1 ON c1.hsID = h1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.reason IN (NULL, 0, 13))) AS noneSpecified, (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 1)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 1)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 1)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 1)) AS cancelledOnAriv, (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 2)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 2)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 2)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 2)) AS cancelledOnDay, (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 3)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 3)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 3)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 3)) AS cancelled1DayBefore, (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.firstConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 4)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.secConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 4)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.thirConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 4)) + (SELECT COUNT(*) AS c FROM cit_sh_dealsHS AS h1 LEFT OUTER JOIN cit_sh_HSCancellations AS c1 ON h1.hsID = c1.hsID WHERE (h1.instConsul = uM.userID) AND (c1.cancellationdate BETWEEN '" & fromDate & "' AND '" & toDate & "') AND (h1.clientID NOT IN (1)) AND (c1.notified = 4)) AS cancelled2DayBefore FROM cit_sh_users AS uM WHERE (enabled = 1) AND (dept = 8) AND (secLevel IN (6, 8, 15, 17)) AND (userID <> 128306) GROUP BY userID, ISNULL(fName, '') + ' ' + ISNULL(sName, '') ORDER BY consultant
