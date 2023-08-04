/*Connect with the database Hotel.
Show tables and constraints. Show how to look data in tables by using the GUI.
Show a simple query.
*/

SELECT * 
FROM Hotel
WHERE city='Tallinn';

--Show how to create a view and a simple query based on it

CREATE VIEW Tallinn_hotel AS
SELECT * 
FROM Hotel
WHERE city='Tallinn';

--Show that it appears under the connections

SELECT *
FROM  Tallinn_hotel;

DROP VIEW Tallinn_hotel;
--Show that the view disappears from the list of connections

/*Create a new connection and a new database*/

CREATE TABLE Occupation (
occupation_code SMALLINT NOT NULL,
name VARCHAR ( 50 ) NOT NULL,
max_working_hours_in_week SMALLINT DEFAULT 40 NOT NULL,
min_sal CURRENCY NOT NULL,
CONSTRAINT pk_occupation PRIMARY KEY (occupation_code),
CONSTRAINT ak_occupation_name UNIQUE (name)	);

CREATE TABLE Worker (
worker_id AUTOINCREMENT,
occupation_code SMALLINT NOT NULL,
birth_date DATETIME NOT NULL,
address VARCHAR ( 255 ) NOT NULL,
registr_time DATETIME DEFAULT Now() NOT NULL,
is_active YESNO DEFAULT TRUE NOT NULL,
given_name VARCHAR ( 50 ),
surname VARCHAR ( 50 ),
CONSTRAINT pk_worker PRIMARY KEY (worker_id)
);

ALTER TABLE Worker 
ADD CONSTRAINT fk_worker_occupation_code 
FOREIGN KEY (occupation_code) 
REFERENCES Occupation (occupation_code)  
ON UPDATE CASCADE 
ON DELETE NO ACTION;

INSERT INTO Occupation (occupation_code, name, min_sal) VALUES (1, 'Manager', 2500);
INSERT INTO Occupation (occupation_code, name, max_working_hours_in_week, min_sal) VALUES (2, 'Accoountant', 35, 2200);

SELECT *
FROM Occupation
WHERE min_sal>2200;

SELECT *
FROM Occupation
WHERE sal>2200;
--Wrong column name

INSERT INTO Worker (occupation_code, birth_date, address, given_name, surname)
VALUES (1, #1985-06-09#, 'Talcity Vilde tee 100-5', 'Andres', 'Kaasik');


INSERT INTO Worker (occupation_code, birth_date, address, given_name, surname)
VALUES (10, #1988-11-04#, 'Talcity Varblase 11-8', 'Teele', 'Tee');
--Fails due to the referential integrity error

SELECT Occupation.occupation_code, name AS occupation_name, Count(*) AS cnt
FROM Occupation INNER JOIN Worker ON Occupation.occupation_code=Worker.occupation_code
GROUP BY Occupation.occupation_code, name
ORDER BY Count(*) DESC;

SELECT Occupation.occupation_code, name AS amet_name, Count(*) AS arv
FROM Occupation LEFT JOIN Worker ON Occupation.occupation_code=Worker.occupation_code
ORDER BY 3;
--Try to execute - gives an error
--Search problems from the statement

SELECT *
FROM Occupation INNER JOIN Worker ON Occupation.occupation_code=Worker.occupation_code
WHERE name LIKE 'Juhataja'
--Try to execute - does not give any errors
--Search problems from the statement

/*Drop the connections*/