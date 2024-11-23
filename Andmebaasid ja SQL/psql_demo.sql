pg_config  --version

psql -l

createdb
--CREATE DATABASE t990999 TEMPLATE template1 LC_COLLATE 'et_EE.UTF-8' LC_CTYPE 'et_EE.UTF-8';
createdb -e -l en_US.utf8 t990999_eng
createdb -e -l en_US.utf8 -T template0 t990999_eng
createdb -T scott t990999_scott

.pgpass
localhost:5432:*:t990999:siia_parool

psql
help
\copyright
\h
\h CREATE TABLE
\?
\conninfo
--Nooleklahv üles näitab eelmiseid käske
\dt
\dnS+
SHOW search_path;
CREATE TABLE Emp(empno SMALLINT PRIMARY KEY);
\dt
\d Emp
\di
\dT
\dTS+
INSERT INTO Emp(empno) VALUES (1000), (1001), (1002);
SELECT * FROM Emp;
\df
\df age
\! clear (või CTRL+L)
\timing
SELECT * FROM Emp;
\timing
START TRANSACTION;
DELETE FROM Emp;
DROP TABLE Emp;

--Teises ühenduses; võimalus testida samaaegseid tehinguid samade andmete põhjal
SELECT * FROM Emp;

ROLLBACK;
SELECT * FROM Emp;
\q

psql scott
\c t990999
\conninfo
\dt
\c scott
\conninfo
\dt
\dt e*
\d Emp
\x
SELECT * FROM Emp;
\x
SELECT deptno, job, Avg(sal) AS keskm FROM emp GROUP BY deptno, job ORDER BY deptno;
SELECT deptno, job, Avg(sal) AS keskm FROM emp GROUP BY deptno, job ORDER BY deptno \crosstabview
EXPLAIN SELECT * FROM Emp;
EXPLAIN ANALYZE SELECT * FROM Emp;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM Emp;
\t
SELECT * FROM Emp;
\t
\a
SELECT * FROM Emp;
\a
\pset format csv
SELECT * FROM Emp;
\pset format html
SELECT * FROM Emp;
\pset format wrapped
SELECT * FROM Emp;
\x
\pset format csv
SELECT * FROM Emp;
\pset format wrapped
\x
\s
\s ajalugu.sql
\i proov.sql
\H
\o tulemused.sql
SELECT * FROM Emp;
SELECT * FROM Dept;
\dt
\o
\H
exit

dropdb t990999_eng
dropdb t990999_scott
dropdb t990999 --force

--psql on ka pgAdminis
\dt
\d Emp