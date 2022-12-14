-- by experience id
SELECT experiences.id, users.name AS name, roles.name AS role, companies.name AS company, experiences."startDate" FROM experiences JOIN users ON experiences."userId"=users.id JOIN roles ON experiences."roleId"=roles.id JOIN companies ON experiences."companyId"=companies.id WHERE users.id=50;

-- by company id
SELECT t1.id, users.name AS name, roles.name AS role, t2.name AS company, experiences."startDate" FROM experiences JOIN companies t1 ON experiences."companyId"=t1.id JOIN users ON experiences."userId"=users.id JOIN roles ON experiences."roleId"=roles.id JOIN companies t2 ON experiences."companyId"=t2.id WHERE users.id=50;