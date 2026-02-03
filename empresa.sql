
-- creacio de la taula empleats 
CREATE DATABASE exercicis; 
-- utilitzar la taula creada
USE exercicis;

ALTER TABLE empleats -- modifica las tablas ya creadas
	ADD COLUMN departament_id INT UNSIGNED,
    ADD CONSTRAINT fk_emplats_departaments FOREIGN KEY(departament_id)
		REFERENCES departaments (departament_id);

ALTER TABLE empleats
	ADD COLUMN nom_complet VARCHAR(42) GENERATED ALWAYS AS (concat(nom, ', ',cognom1)) STORED; -- crea un campo generat, para concatenar hay que usar el concat amb lo que quieras concatenar

ALTER TABLE empleats -- modificar una columna de la tabla
	MODIFY COLUMN nom VARCHAR(20) NOT NULL,
    MODIFY COLUMN nom_complet VARCHAR(47);
    
ALTER TABLE jugadors -- añadimos un unique con su nombre de constrein
	MODIFY COLUMN dni CHAR(9) NOT NULL AFTER jugador_id;

ALTER TABLE jugadors 
	ADD COLUMN cognoms VARCHAR(42) GENERATED ALWAYS AS (concat(cognom1, ' ',cognom2)) STORED;

RENAME TABLE factures TO factura;

ALTER TABLE linias_factures
	DROP FOREIGN KEY fk_linias_facutres_productes;

ALTER TABLE clients
	ADD COLUMN pobles

ALTER TABLE clients
	ADD CONSTRAINT fk_clients_pobles FOREIGN KEY (poble_id) REFERENCES pobles (poble_id) ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE linias_factures
	ADD CONSTRAINT fk_linias_facutres_factures FOREIGN KEY (numero,serie,any_factura) REFERENCES factures (numero,serie,any_factura) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE linias_factures
	ADD CONSTRAINT fk_linias_facutres_productes FOREIGN KEY (producte_id) REFERENCES productes (producte_id) ON DELETE CASCADE ON UPDATE CASCADE ;


-- creacio de una taula
CREATE TABLE jugadors (
	jugador_id 		INT UNSIGNED AUTO_INCREMENT,
	nom				VARCHAR(25) NOT NULL,
    cognom1			VARCHAR (30) NOT NULL,
    cognom2			VARCHAR (30) NOT NULL,
    posicio			ENUM('BASE','ALER','ALER-PIVOT','PIVOT') NOT NULL COMMENT "Posicio dins del terreny de joc",
    dorsal			INT UNSIGNED COMMENT "Numero que porta a la camiseta",
    punts 			INT UNSIGNED,
    valoracio 		INT UNSIGNED COMMENT "Valoracio del jugador dins del terreny de joc",
    CONSTRAINT pk_jugadors PRIMARY KEY (jugador_id) -- las constrains son las restriccions
    );
    
    ALTER TABLE jugadors
		ADD CONSTRAINT ck_jugadors_punts CHECK (punts BETWEEN 0 AND 300);  -- Asi se hace el check para poder poner numeros entre algo y algo 
    
    CREATE TABLE FEINES (
    feina_id INT PRIMARY KEY,
    nom VARCHAR(100) DEFAULT '',
    salari_min DECIMAL(10,2) DEFAULT 0,
    salari_max DECIMAL(10,2) DEFAULT 8000
    
);

ALTER TABLE jugadors
MODIFY COLUMN jugador_id INT
CHECK (jugador_id BETWEEN 0 AND 65000);

 ALTER TABLE jugadors
		ADD CONSTRAINT ck_jugadors_id CHECK (punts BETWEEN 0 AND 65000);
    
    CREATE TABLE factures (
	numero  		INT UNSIGNED,
	serie			CHAR(3) ,
    any_factura		INT  ,
    client_id		INT UNSIGNED NOT NULL,
    CONSTRAINT pk_factures PRIMARY KEY (numero,serie,any_factura) -- las constrains son las restriccions
    );
    
	ALTER TABLE factures 
		ADD COLUMN data DATE;
    
    
	CREATE TABLE linias_factures (
	numero  INT UNSIGNED,
	serie	CHAR(3) ,
    any_factura	INT  ,
    linia	INT UNSIGNED NOT NULL,
    producte_id INT UNSIGNED NOT NULL,
    qt		INT UNSIGNED NOT NULL,
    importe INT UNSIGNED NOT NULL,
    descompte INT UNSIGNED COMMENT "% del descompte",
    subtotal  INT UNSIGNED  GENERATED ALWAYS AS (importe-(importe*(descompte/100))) STORED COMMENT "Import amb el descompte aplicat",
    CONSTRAINT fk_linias_facutres_factures FOREIGN KEY (numero,serie,any_factura) REFERENCES factures (numero,serie,any_factura),
    CONSTRAINT pk_lineas_factures PRIMARY KEY (numero,serie,any_factura,linia) -- las constrains son las restriccions
    );
    
    CREATE TABLE productes (
	producte_id  INT UNSIGNED,
    nom			 VARCHAR(30),
	CONSTRAINT pk_productes PRIMARY KEY (producte_id) -- las constrains son las restriccions
    );
    
	CREATE TABLE persona (
	persona_id   INT UNSIGNED,
    nom			 VARCHAR(30),
    cognom		 VARCHAR(30),
	CONSTRAINT pk_persona PRIMARY KEY (persona_id) -- las constrains son las restriccions
    );
    
	CREATE TABLE alumne (
	alumne_id   INT UNSIGNED,
    nota_mitjana INT UNSIGNED,
	CONSTRAINT pk_alumne PRIMARY KEY (alumne_id),
	CONSTRAINT fk_persona_alumne FOREIGN KEY (alumne_id) REFERENCES persona (persona_id)-- las constrains son las restriccions
    );
    
    CREATE TABLE profesor (
	profesor_id   INT UNSIGNED,
    data_incorporacio DATE,
	CONSTRAINT pk_profesor PRIMARY KEY (profesor_id),
	CONSTRAINT fk_persona_profesor FOREIGN KEY (profesor_id) REFERENCES persona (persona_id)-- las constrains son las restriccions
    );
    
    CREATE TABLE pas (
	pas_id   INT UNSIGNED,
    telefono CHAR(9),
	CONSTRAINT pk_pas PRIMARY KEY (pas_id),
	CONSTRAINT fk_persona_pas FOREIGN KEY (pas_id) REFERENCES persona (persona_id)-- las constrains son las restriccions
    );
    
    CREATE TABLE clients (
    client_id	INT UNSIGNED,
    dni			CHAR(10),
    nom			VARCHAR(15) NOT NULL,
    CONSTRAINT pk_client PRIMARY KEY (client_id),
    CONSTRAINT uk_cilents_nom UNIQUE (nom)
    );
    
	CREATE TABLE pobles (
	poble_id	INT UNSIGNED,
    municipi_id	INT UNSIGNED,
    nom			VARCHAR(40) DEFAULT NULL,
    provincia_nom VARCHAR(14) NOT NULL,
    CONSTRAINT pk_pobles PRIMARY KEY (poble_id,municipi_id)
	);
    
CREATE TABLE departaments(
	departament_id INT UNSIGNED auto_increment,
    nom				VARCHAR(30),
    CONSTRAINT pk_departaments PRIMARY KEY (departament_id)
    );
    
DROP TABLE IF EXISTS empleats ;-- esto borra la tabla empleats si existe
DROP DATABASE empresa; -- esto borra la base de datos entero

CREATE TABLE IF NOT EXISTS empleats; -- crea una tabla empleats si no existe

DROP TABLE departaments;

CREATE TABLE departaments(
	departament_id INT UNSIGNED auto_increment,
    director_id	   INT UNSIGNED,  -- tenemos que crear el atributo para poder añadirlo 
    nom				VARCHAR(30),
    CONSTRAINT pk_departaments PRIMARY KEY (departament_id),
    CONSTRAINT fk_departaments_empleats /* el nombre es fk_[nombre de la tabla donde estoy]_[nombre de la tabla donde viene] */ FOREIGN KEY (director_id) -- el nombre que ponemos no tiene porque ser el mismo
		REFERENCES empleats (empleat_id) -- Le decimos que la fk vendra de la tabla empleats ya creada y el atributo sera empleat id
    );
    
    




    


