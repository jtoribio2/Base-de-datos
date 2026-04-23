SELECT * FROM rrhh.empleats;

USE rrhh;

INSERT INTO empleats (empleat_id,nom,cognoms,feina_codi,salari,email,data_contractacio)
	VALUES (208,'Pere','Pi','IT_PROG',7000,'ppi@empresa.cat','2026-01-20');
    
INSERT INTO empleats (empleat_id,nom,cognoms,feina_codi,salari,email,data_contractacio)
	VALUES (209,'Sandra','Gonzalez','AC_ACCOUNT',6000,'sgonzalez@empresa.cat','2026-01-20'),
		   (210,'Marta','Perez','AC_ACCOUNT',6000,'mperez@empresa.cat','2026-01-20'),
           (211,'Maria','Canto','AC_ACCOUNT',6000,'mcanto@empresa.cat','2026-01-20');
           
SELECT * FROM rrhh.historial_feines;

INSERT INTO empleats (empleat_id,nom,cognoms,feina_codi,email,data_contractacio)
	VALUES (212,'Pau','Serra','IT_PROG','pau@gmail.com','1992-01-15');
    
INSERT INTO historial_feines (empleat_id,data_inici,data_fi,feina_codi,departament_id)
	VALUES (212,'1992-01-15','1993-10-21','IT_PROG',60);
    
INSERT INTO historial_feines (empleat_id,data_inici,data_fi,feina_codi,departament_id)
	VALUES (212,'1993-10-21','1994-10-21','SA_REP',50),
		   (212,'1994-10-21','1994-12-31','SA_MAN',50);
           
INSERT INTO paisos (pais_id,nom,regio_id)
	VALUES ('ES','Espanya',1),
		   ('FR','França',1),
           ('AU','Australia',1), -- deberia ser 5 pero no esta registrado
           ('JP','Japo',3),
           ('KR','Corea del sur',3);

UPDATE localitzacions
	SET adreca = '24 Vilar Petit',
		codi_postal = '17300',
        ciutat = 'Blanes',
        estat_provincia = 'La selva',
        pais_id = 'ES'
	WHERE localitzacio_id = 1800;
    
UPDATE empleats
	SET feina_codi = CASE
    WHEN feina_codi = 'AD_PRES' THEN 'AD_VP'
    WHEN feina_codi = 'AD_VP' THEN 'AD_PRES'
    ELSE feina_codi
    END;
    
DELETE historial_feines
	WHERE empleat_id = /* id del treballador triat*/  
		  AND /*data inicial triada*/ <= data_inici 
          OR  /*data final triada */ <= data_fi;
          
SELECT * FROM rrhh.empleats;

SELECT * FROM information_schema.columns
	WHERE table_schema="rrhh" AND table_name= "departaments";

SELECT nom, cognoms, salari
	FROM empleats
    LIMIT 4;
    
SELECT * FROM rrhh.feines;

SELECT DISTINCT departament_id
	FROM empleats
    WHERE departament_id IS NOT NULL;
    
SELECT empleat_id, nom, cognoms, salari, salari*166.186 AS SalariPTS
	FROM empleats;
    
SELECT empleat_id, nom, cognoms, salari
	FROM empleats
    WHERE salari > 12000;
    
SELECT * FROM rrhh.paisos
	ORDER BY nom ASC;
    
SELECT nom
	FROM paisos
    WHERE regio_id = 2;
    
SELECT cognoms, departament_id, email
	FROM empleats
    WHERE empleat_id = 176;

SELECT *
	FROM empleats
    WHERE data_contractacio >= '1996-01-01';

use rrhh;

-- Joins
-- EX1
SELECT d.nom, e.cognoms, e.nom
	FROM empleats e
    INNER JOIN departaments d ON e.departament_id=d.departament_id
    ORDER BY d.nom ASC, e.cognoms ASC, e.nom ASC;

-- EX2
SELECT d.departament_id, d.nom, l.adreca, l.codi_postal, l.ciutat
	FROM departaments d
    INNER JOIN localitzacions l ON d.localitzacio_id = l.localitzacio_id;

-- EX 3
SELECT d.departament_id, d.nom, l.adreca, l.codi_postal, l.ciutat
	FROM departaments d
    INNER JOIN localitzacions l ON d.localitzacio_id = l.localitzacio_id
    WHERE d.nom = "Marketing";
    
-- EX 4
SELECT l.localitzacio_id, l.ciutat, l.estat_provincia, p.nom AS nom_pais, r.nom AS nom_regio
	FROM localitzacions l
    INNER JOIN paisos p ON l.pais_id= p.pais_id
    INNER JOIN regions r ON p.regio_id = r.regio_id
    ORDER BY l.localitzacio_id;
    
-- EX 5
SELECT d.nom AS Nom, l.ciutat AS Ciutat, COUNT(e.empleat_id) AS Num_empleats, ROUND(AVG(e.salari),2) AS Salari_Mig
	FROM departaments d
    LEFT JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id
    LEFT JOIN empleats e ON e.departament_id = d.departament_id
    GROUP BY d.nom, l.ciutat
    ORDER BY d.nom;
    
-- EX 6 
SELECT  hf.empleat_id, e.nom, COUNT(*)
	FROM historial_feines hf
    INNER JOIN empleats e on e.empleat_id = hf.empleat_id
GROUP BY hf.empleat_id
HAVING COUNT(*) >  1 ;

-- EX 8

SELECT e.empleat_id,
	   e.nom, 
       e.cognoms, 
       e.salari, 
       YEAR(e.data_contractacio) AS any_contractacio, 
       d.nom
FROM empleats e
INNER JOIN departaments d ON e.departament_id = d.departament_id
WHERE YEAR(e.data_contractacio) < 1999
  AND e.salari BETWEEN 10000 AND 20000
  AND (d.nom = "VENDES" OR d.nom = "COMPRES");
  
-- EX 15

SELECT e.nom, e.cognoms
	FROM historial_feines hf
    INNER JOIN empleats e ON e.empleat_id = hf.empleat_id
    INNER JOIN feines f ON f.feina_codi = hf.feina_codi
    INNER JOIN departaments d ON d.departament_id = hf.departament_id;
    
SELECT e.nom, e.salari, f.nom_treball,d.nom AS nom_dep, l.ciutat, p.nom AS nom_pais, r.nom AS nom_regio
	FROM empleats e
    LEFT JOIN departaments d ON d.departament_id = e.departament_id
    LEFT JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id
    LEFT JOIN paisos p ON p.pais_id = l.pais_id
    LEFT JOIN regions r ON r.regio_id = p.regio_id
    INNER JOIN feines f ON f.feina_codi = e.feina_codi;
    
-- EX 19
SELECT e.empleat_id, e.nom, e.cognoms, e.data_contractacio, c.empleat_id AS id_cap, c.nom AS nom_cap, c.cognoms AS cognoms_cap, c.data_contractacio
	FROM empleats e
    INNER JOIN empleats c ON e.id_cap=c.empleat_id
    WHERE e.data_contractacio<c.data_contractacio;
    
 -- EX 20
 SELECT SUM(IF(YEAR (data_contractacio) = 1996,1,0)) AS any_1996,
 COUNT(*) AS total
	FROM empleats
    WHERE data_contractacio IN (1996,1997,1998);
    
-- Exercicis SUBCUNSULTES

-- EX 1
SELECT e.empleat_id, e.nom, e.salari
	FROM empleats e
    WHERE e.salari = ( SELECT e2.salari
						FROM empleats e2
                        WHERE e2.nom = "Pat" 
                        AND e2.cognoms = "Fay"
                        AND e.empleat_id != e2.empleat_id);
-- EX 2
SELECT e.empleat_id, e.nom, e.salari
	FROM empleats e
    WHERE e.salari > ( SELECT e2.salari
						FROM empleats e2
                        WHERE e2.nom = "Pat" 
                        AND e2.cognoms = "Fay"
                        AND e.empleat_id != e2.empleat_id);
-- EX 3
SELECT e.empleat_id, e.cognoms, e.departament_id
	FROM empleats e
    WHERE e.departament_id = ( SELECT e2.departament_id
						FROM empleats e2
                        WHERE e2.nom = "Pat" 
                        AND e2.cognoms = "Fay"
                        AND e.empleat_id != e2.empleat_id);
-- EX 4 
SELECT e.empleat_id, e.nom, e.salari
	FROM empleats e
    WHERE e.salari > ( SELECT MAX(e2.salari)
						FROM empleats e2
                        INNER JOIN departaments d ON d.departament_id = e2.departament_id
                        WHERE d.nom = "Vendes");


SELECT e.nom
	FROM empleats e
    WHERE e.departament_id = (SELECT d.departament_id
									FROM departaments d
                                    WHERE d.nom = "IT");

SELECT e.empleat_id, e.nom, e.salari
	FROM empleats e
    WHERE e.salari> (SELECT MIN(e2.salari)
						FROM empleats e2
                        INNER JOIN departaments d ON e.departament_id = d.departament_id
                        WHERE d.nom= "VENDES");

SELECT e.empleat_id, e.nom, e.salari
	FROM empleats e
    WHERE e.salari> (SELECT MAX(e2.salari)
						FROM empleats e2
                        INNER JOIN departaments d ON e.departament_id = d.departament_id
                        WHERE d.nom= "Vendes");
                        

SELECT MAX(e.salari)
	FROM empleats e
    ORDER BY salari DESC;
    
SELECT e3.salari
	FROM empleats e3
    WHERE e3.salari != (SELECT MAX(e2.salari) AS salarimax
						FROM empleats e2
						ORDER BY salari DESC)
    ORDER BY e3.salari DESC
    LIMIT 1;
    
SELECT e.nom, e.cognoms, e.salari
	FROM empleats e
    WHERE e.salari = (SELECT MAX(e3.salari)
						FROM empleats e3
						WHERE e3.salari != (SELECT MAX(e2.salari) AS salarimax
												FROM empleats e2
											)
						);
                        
SELECT *
	FROM departaments d 
WHERE EXISTS (SELECT 1
				FROM empleats e
                WHERE d.departament_id= e.departament_id);
                        
                        

    


	


