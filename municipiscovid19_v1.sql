
-- --
-- Autor: Pere Pi
-- Data: 08/02/2021
-- Descripció: Script per la creació de la base de dades
-- --
DROP DATABASE IF EXISTS municipis_covid19;

/* Creació de la BD eleccions */
/* Canviem utf8 per  utf8mb4 i utf8_general_ci per utf8mb4_0900_ai_ci*/
CREATE SCHEMA municipis_covid19 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

USE municipis_covid19;

/* Taula MUNICIPIS */
CREATE TABLE municipis (
  municipi_id INT UNSIGNED,
  codi VARCHAR(45) NULL,
  codi_ine VARCHAR(45) NULL,
  nom VARCHAR(50) NULL,
  comarca VARCHAR(20) 
);

/* Taula COMARQUES */
CREATE TABLE comarca (
  comarca_id INT NULL,
  codi VARCHAR(50) NULL,
  nom VARCHAR(45) NULL
);

/* Taula TIPUS_CASOS */
CREATE TABLE tipus_casos (
  tipus_cas VARCHAR(30) NOT NULL COMMENT 'Clau primària de la taula. PCR, TAR, ELISA,TR,EPID',
  nom VARCHAR(30) NULL,
  CONSTRAINT pk_tipus_casos PRIMARY KEY (tipus_cas)
);

/* Taula MUNICIPIS_CASOS */
CREATE TABLE casos (
  municipi_id INT,
  data DATE NOT NULL,
  sexe VARCHAR(1) NULL,
  tipus_cas VARCHAR(45) NULL,
  quantitat SMALLINT UNSIGNED,
  CONSTRAINT fk_casos_tipus_casos FOREIGN KEY(tipus_cas)
	REFERENCES tipus_casos(tipus_cas)
);



INSERT INTO tipus_casos(tipus_cas,nom) VALUES("PCR","Positiu PCR");
INSERT INTO tipus_casos(tipus_cas,nom) VALUES("TAR", "Positiu Test Antígent Ràpid");
INSERT INTO tipus_casos(tipus_cas,nom) VALUES("ELISA", "Positiu ELISA");
INSERT INTO tipus_casos(tipus_cas,nom) VALUES("TR" ,"Positiu per Test Ràpid" );
INSERT INTO tipus_casos(tipus_cas,nom) VALUES("EPID", "Epidemiològic");


INSERT INTO comarca (comarca_id,codi,nom)VALUES(1,'01',"ALT CAMP");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(2,'02',"ALT EMPORDA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(3,'03',"ALT PENEDES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(4,'04',"ALT URGELL");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(5,'05',"ALTA RIBAGORÇA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(6,'06',"ANOIA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(7,'07',"BAGES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(8,'08',"BAIX CAMP");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(9,'09',"BAIX EBRE");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(10,'10',"BAIX EMPORDA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(11,'11',"BAIX LLOBREGAT");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(12,'12',"BAIX PENEDES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(13,'13',"BARCELONES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(14,'14',"BERGUEDA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(15,'15',"CERDANYA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(16,'16',"CONCA DE BARBERA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(17,'17',"GARRAF");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(18,'18',"GARRIGUES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(19,'19',"GARROTXA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(20,'20',"GIRONES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(21,'21',"MARESME");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(22,'22',"MONTSIA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(23,'23',"NOGUERA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(24,'24',"OSONA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(25,'25',"PALLARS JUSSA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(26,'26',"PALLARS SOBIRA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(27,'27',"PLA D'URGELL");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(28,'28',"PLA DE L'ESTANY");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(29,'29',"PRIORAT");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(30,'30',"RIBERA D'EBRE");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(31,'31',"RIPOLLES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(32,'32',"SEGARRA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(33,'33',"SEGRIA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(34,'34',"SELVA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(35,'35',"SOLSONES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(36,'36',"TARRAGONES");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(37,'37',"TERRA ALTA");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(38,'38',"URGELL");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(39,'39',"VALL D'ARAN");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(40,'40',"VALLES OCCIDENTAL");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(41,'41',"VALLES ORIENTAL");
INSERT INTO comarca (comarca_id,codi,nom)VALUES(42,'42',"MOIANÈS");


INSERT INTO municipis(municipi_id,codi, codi_ine, nom, comarca) VALUES(1,'BLANES', '17023', 'Blanes', 34);
INSERT INTO municipis(municipi_id,codi, codi_ine, nom, comarca) VALUES(2,'GIRONA', '17079 ', 'Giorna', 20);
INSERT INTO municipis(municipi_id,codi, codi_ine, nom, comarca) VALUES(3,'CRUÏLLES, MONELLS I SANT SADURNÍ', '17901', 'Curïlles, Monells i Sant Sadurní de l\'Heura', 10);
INSERT INTO municipis(municipi_id,codi, codi_ine, nom, comarca) VALUES(4,'LLÍVIA', '17094', 'Llívia', 15);


INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(4,'2021-01-29', 'H','PCR',1);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(4,'2021-01-27', 'D','TAR',1);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(4,'2021-01-26', 'D','TAR',1);

INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(3,'2021-02-05', 'H','TAR',1);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(3,'2021-02-04', 'H','TAR',1);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(3,'2021-02-02', 'H','PCR',1);

INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(2,'2021-02-08', 'D','TAR',8);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(2,'2021-02-08', 'H','TAR',11);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(2,'2021-02-07', 'D','PCR',7);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(2,'2021-02-07', 'H','PCR',1);

INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(1,'2021-02-08', 'H','TAR',NULL);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(1,'2021-02-08', 'D','TAR',NULL);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(1,'2021-02-07', 'D','TAR',NULL);
INSERT INTO casos (municipi_id,data, sexe, tipus_cas, quantitat) VALUES(1,'2021-02-07', 'H','TAR',NULL);

	
