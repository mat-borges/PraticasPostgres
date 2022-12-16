SELECT u.id AS "id", COUNT(e.status) AS "educations" FROM educations e JOIN users u ON e."userId"=u.id WHERE e.status='finished' GROUP BY u.id ORDER BY id;