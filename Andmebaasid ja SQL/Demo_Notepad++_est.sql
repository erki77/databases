/*Luua �hendus andmebaasiga Hotell
N�idata, et n�eb tabeleid, nende kitsendusi. N�idata, et saab men��st valides vaadata tabelites olevaid andmeid.
N�idata lihtsat p�ringut.
*/

SELECT * 
FROM Hotell
WHERE linn='Tallinn';

--N�idata, et saab luua vaadet ja teha selle p�hjal p�ringut

CREATE VIEW Tallinna_hotell AS
SELECT * 
FROM Hotell
WHERE linn='Tallinn';

--N�idata, et see tekkis �henduses vaadete alla

SELECT *
FROM  Tallinna_hotell;

DROP VIEW Tallinna_hotell;
--N�idata, et vaade kadus �henduses vaadete alt

/*Luua uus �hendus ja selle alt uus andmebaas*/

CREATE TABLE Amet(
amet_kood SMALLINT,
nimetus VARCHAR(50) NOT NULL,
max_tootunde_nadalas SMALLINT NOT NULL DEFAULT 40,
min_palk CURRENCY NOT NULL,
CONSTRAINT pk_amet PRIMARY KEY(amet_kood),
CONSTRAINT ak_amet_nimetus UNIQUE(nimetus));

CREATE TABLE Tootaja(
tootaja_id AUTOINCREMENT,
amet_kood SMALLINT NOT NULL,
synni_kp DATETIME NOT NULL,
kontaktaadress VARCHAR(255) NOT NULL,
registr_aeg DATETIME NOT NULL DEFAULT Now(),
on_aktuaalne YESNO NOT NULL DEFAULT TRUE,
eesnimi VARCHAR(50) NOT NULL,
perenimi VARCHAR(50),
CONSTRAINT pk_tootaja PRIMARY KEY(tootaja_id));

ALTER TABLE Tootaja 
ADD CONSTRAINT fk_Tootaja_amet_kood 
FOREIGN KEY (amet_kood) 
REFERENCES Amet(amet_kood) 
ON UPDATE CASCADE 
ON DELETE NO ACTION;

INSERT INTO Amet (amet_kood, nimetus, min_palk) VALUES (1, 'Juhataja', 2500);
INSERT INTO Amet (amet_kood, nimetus, max_tootunde_nadalas, min_palk) VALUES (2, 'Raamatupidaja', 35, 2200);

SELECT *
FROM Amet
WHERE min_palk>2200;

SELECT *
FROM Amet
WHERE palk>2200;
--Vale veeru nimi

INSERT INTO Tootaja (amet_kood, synni_kp, kontaktaadress, eesnimi, perenimi)
VALUES (1, #1985-06-09#, 'Tallinn Vilde tee 100-5', 'Andres', 'Kaasik');


INSERT INTO Tootaja (amet_kood, synni_kp, kontaktaadress, eesnimi, perenimi)
VALUES (10, #1988-11-04#, 'Tallinn Varblase 11-8', 'Teele', 'Tee');
--Eba�nnestub, sest viidete terviklikkuse viga

SELECT Amet.amet_kood, nimetus AS amet_nimetus, Count(*) AS arv
FROM Amet INNER JOIN Tootaja ON Amet.amet_kood=Tootaja.amet_kood
GROUP BY Amet.amet_kood, nimetus
ORDER BY Count(*) DESC;

SELECT Amet.amet_kood, nimetus AS amet_nimetus, Count(*) AS arv
FROM Amet LEFT JOIN Tootaja ON Amet.amet_kood=Tootaja.amet_kood
ORDER BY 3;
--K�igepealt k�ivitada - annab vea
--Siis otsida sellest lausest probleeme

SELECT *
FROM Amet INNER JOIN Tootaja ON Amet.amet_kood=Tootaja.amet_kood
WHERE nimetus LIKE 'Juhataja'
--K�igepealt k�ivitada - ei anna vigu
--Siis otsida sellest lausest probleeme

/*Kustutada �hendused*/