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
    



    
    

           
			