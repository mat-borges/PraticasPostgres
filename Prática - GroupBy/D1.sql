SELECT s.name AS "school", c.name AS "course", COUNT(e."userId") AS "studentsCount", e.status AS "status" FROM educations e JOIN schools s ON e."schoolId"=s.id JOIN courses c ON e."courseId"=c.id WHERE "status"='ongoing' OR "status"='finished' GROUP BY "school","course","status" ORDER BY "studentsCount" DESC LIMIT 3;

-- tirando o status o exemplo fica melhor
SELECT
	s.name AS "school",
	c.name AS "course",
	COUNT(e."userId") AS "studentsCount"
FROM educations e
	JOIN schools s ON e."schoolId"=s.id
	JOIN courses c ON e."courseId"=c.id
WHERE e.status='ongoing' OR e.status='finished'
GROUP BY s.id, c.id
ORDER BY "studentsCount" DESC;