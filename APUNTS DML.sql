SELECT * FROM rrhh.feines;
SELECT * FROM rrhh.departaments;
select * FROM rrhh.regions;
SELECT * FROM rrhh.paisos;
SELECT * FROM rrhh.localitzacions;

INSERT INTO feines (feina_codi, nom_treball, salari_min, salari_max)
	VALUES ('IT_SYS2', 'Administrador Sistemes2',4000,10000),
			('IT_SYS3', 'Administrador Sistemes3',4000,10000),
            ('IT_SYS4', 'Administrador Sistemes4',4000,10000),
            ('IT_SYS5', 'Administrador Sistemes5',4000,10000);
            
DELETE FROM feines
	WHERE feina_codi = 'IT_SYS3' OR feina_codi = 'IT_SYS4';
    
UPDATE feines 
	SET salari_min = 8000,  -- el set es el campo y valor que queremos cambiar
		salari_max = 10000
    WHERE feina_codi = 'IT_SYS4'; -- el where ponemos la condicion logica que queremos poner como condicion para cambiar el valor al campo
    
UPDATE feines 
	SET salari_min = salari_max - 2
    WHERE salari_max IS NOT NULL; -- esto es para evitar que si hay campos de null en salari maxim como cuando le haces cualquier operacion aritmetica devuelve null te deje el salari minim lleno de nulls
    
SELECT feina_codi, salari_min, salari_min*1.1 AS pujada_salari -- esto marca los campos que quieres mostrar, se pueden hacer campos con una operacion aritmnetica efectuada, para ponerle nombre a la nueva columna de la operacion aritmetica se usa el AS y el nombre
	FROM feines -- marca la tabla donde se hara la consulta 
    WHERE salari_min > 4000
    ORDER BY salari_min ASC , salari_max DESC -- esto ordena en funcion de una columna en este caso salari min y ASC es accedente por defecto y DESC descendente, cuando pones coma pone en el caso de empate de valores o valaores iguales la segunda preferencia de ordenacion
    LIMIT 3; -- limita el select a 3 filas solos las 3 primeres
    
SELECT DISTINCT departament_id -- El distinct significa que no podra salir repetidos
	FROM empleats
    WHERE departament_id IS NOT NULL;
    
-- La funcion YEAR() retorna un any si li pasem una data, 

-- LA funcio NOW () devuelve la data de avui

-- el in es para mirar un valor en un campo como si fueran or porejemplo codigo de trabajo IN "ad_pres" "ad_adve"

-- el like es para buscar valores de texto que empiecen o acaben en algo LIKE "a%a" esto busca todo lo que empuece en a y acabe en a el % es uno o mas caracters y el _ es un caracter "a_B" espera acB o agB o cualquier caracter en medio

-- rlike es para comprobar regex RLIKE "^[aeiou].*[aeiou]$" ;

-- group by 

SELECT departament_id, COUNT(*) -- esto agrupa todos los departaments id y el siguiente campo cuenta las filas es decir te dice cuantas veces esta cada id en la tabla
	FROM empleats
GROUP BY departament_id;

SELECT departament_id, COUNT(*) -- agrupa todos los departament_id iguales en empleats y que no son null y los cuenta ordenados ascendentemente
WHERE departament_id IS NOT NULL 
GROUP BY departament_id
ORDER BY depatament_id ASC;

SELECT departament_id, COUNT(*) AS a, -- cuenta cuantos trabajadores hay en cada departament
	SUM(salari) AS b, -- mostra la suma de tots els diferent salaris que hi han al mateix departament
    MIN(salari) AS c, -- mostra el minim salari que combra els empleats del mateix departament
    MAX(salari) AS d, -- mostra el maxim salari de tots els empleats del mateix departament
    AVG(salari) AS e -- mostra la mitjana del salari de tots els empleats del mateix departament
	FROM empleats
WHERE departament_id IS NOT NULL 
GROUP BY departament_id
ORDER BY depatament_id ASC;

-- el COUNT (exp) si dentro hay un null no lo contara ficara 0, por eso se pone * o la pk dentro del parentesis porque no puede ser null
 
 SELECT departament_id, AVG(salari), COUNT(*) -- agrupa todos los departament_id iguales en empleats y que no son null y los cuenta ordenados ascendentemente
	FROM empleats
WHERE departament_id IS NOT NULL 
GROUP BY departament_id
HAVING AVG (salari)< 11000 AND COUNT(*)> 2; -- el having es lo mismo que el WHERE pero para el group by

-- el producte cartacia es la combinacion de las filas de una tabla con todas las filas de la otra esto se hace poniendo en el FROM de dos tablas 
-- para poner dos campos que se llamen iguales en dos tablas tienes que poner el nombre de la tabla.nombre del campo

-- ejemplo 

use rrhh;
 
SELECT empleats.nom, empleats.cognoms, departaments.nom AS nom_dep
	FROM empleats AS e,departaments AS d
    WHERE empleats.departament_id = departaments.departament_id;
    
    -- a las tablas se les puede poner AS y la inicial para cambiar en la select el nombre de la tabla y asi no tener que esctribir tanto ( esto es equivalente a la tabla de arriba)
   
   SELECT e.nom, e.cognoms, d.nom AS nom_dep
	FROM empleats AS e,departaments AS d
    WHERE e.departament_id = d.departament_id; 
    
    -- para hacer combinaciones de diferentes tablas usamos la clausla INNER JOIN
    
SELECT e.nom, e.cognoms, d.nom AS nom_dep
	FROM empleats AS e INNER JOIN departaments AS d ON e.departament_id= d.departament_id
    WHERE e.departament_id = d.departament_id; 
    
    -- se puede hacer INNER JOIN de mas de una tabla
SELECT e.nom, e.cognoms, d.nom AS nom_dep, l.ciutat
	FROM empleats AS e 
    INNER JOIN departaments AS d ON e.departament_id= d.departament_id
    INNER JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id
    WHERE e.departament_id = d.departament_id; 

-- LEFT JOIN combina todos los registros de la tabla de la izquierda con los que combinan de la derecha asi aparecen todos los registros de empleats y cuando no combina sale null

SELECT e.nom, e.cognoms, IFNULL(d.nom, "NO DEP:") AS nom_dep
	FROM empleats AS e 
    LEFT JOIN departaments AS d ON e.departament_id= d.departament_id; 
    
-- Existe lo mismo pero con el RIGHT JOIN

SELECT IFNULL(e.nom, "NO HI HA TREBALLADORS"), IFNULL(e.cognoms,"NO HI HA TREBALLADORS"), d.nom AS nom_dep
	FROM empleats AS e 
    RIGHT JOIN departaments AS d ON e.departament_id= d.departament_id; 

-- como podemos ver en la siguiente tabla podemos combinar varias tablas para juntar valores

SELECT e.nom, e.cognoms, d.nom AS nom_dep, f.nom_treball
	FROM empleats AS e 
    INNER JOIN departaments AS d ON e.departament_id= d.departament_id
    INNER JOIN feines f ON f.feina_codi = e.feina_codi;
    
-- se pueden crear vistas con las selects de inner join

CREATE VIEW v_empleats_deps AS 
	SELECT e.nom, e.cognoms, d.nom AS nom_dep, e.feina_codi
	FROM empleats AS e 
    INNER JOIN departaments AS d ON e.departament_id= d.departament_id;
    
-- y despues hacer INNER JOIN conb estas vistas

SELECT *
	FROM v_empleats_deps ved
    INNER JOIN feines f ON f.feina_codi = ved.feina_codi;
    
SELECT e.nom, e.cognoms, e.salari, f.salari_min, f.salari_max,f.nom_treball
	FROM empleats e 
    INNER JOIN feines f ON e.feina_codi = f.feina_codi
    WHERE e.salari > f.salari_min AND e.salari < f.salari_max; 
    
-- SUBCUNSULTES ESCALARS

-- en cualquier lloc que es pugi ficar un valor escalar es a dir un num un string etc es pot ficar una subconsulta que retorni un valor esclar es a dir una fila una columna
SELECT nom
	FROM empleats
    WHERE salari > (SELECT AVG(salari)
						FROM empleats);

-- SUBCUNSULTES TIPUS LLISTA

-- se puede utilizar en cunsultes que tenga los operadores IN, ANY, ALL, EXIST, solo puede hacer referencia a una sola columna 
-- IN
SELECT e1.nom
	FROM empleatse1
    WHERE e1.departament_id = 20 AND e1.feina_codi IN (SELECT DISTINCT e2.feina_codi
															FROM empleats e2
                                                            WHERE e2.salari >=2000);
-- ANY (devuelve un llistat y compara si alguno entre todos los valores es igual mas grande o mas pequeño a el 
SELECT e.nom,e.feina_codi, e.salari
	FROM emoleats e
    WHERE e.salari < ANY (SELECT it_prog.salari
							FROM empleats it_prog
							WHERE it_prog.feina_codi = "IT_PROG")
		AND e.feina_codi != "IT_PROG"; -- aqui devuelve si hay algun empleado no programador que tenga un salario mas bajo que alguno de los programadores
        
-- ALL (lo mismo que el ANY pero en vez de uno entre todos los valores)
SELECT e.nom,e.feina_codi, e.salari
	FROM empleats e
    WHERE e.salari < ANY (SELECT it_prog.salari
							FROM empleats it_prog
							WHERE it_prog.feina_codi = "IT_PROG")
		AND e.feina_codi != "IT_PROG"; -- aqui devuelve si un valor de salario de un empleado que no sea progamador sea inferior a todos los programadores
        
-- EXIST 
SELECT d.departament_id, d.nom
	FROM departaments d
    WHERE EXISTS (SELECT e.empleat_id
					FROM empleats e
                    WHERE e.departament_id = d.departament_id);
-- como podemos ver solo correlaciona el d.departament_id con el d.departament_id del select de arriba y e.mpleats_id es indiferente asi que se puede poner "1"
SELECT d.departament_id, d.nom
	FROM departaments d
    WHERE EXISTS (SELECT 1
					FROM empleats e
                    WHERE e.departament_id = d.departament_id);

-- SUBCUNSULTES MULTICULUMNA

SELECT f.nom_treball,f.feina_codi ,AVG(salari)
	FROM ( SELECT * 
			FROM empleats
            WHERE departament_id= 50) AS empleats_dep_60
	INNER JOIN feines f ON f.feina_codi = empleats_dep_60.feina_codi
    GROUP BY feina_codi;
            
-- utilizamos una consulta como si fuera una tabla ( Siempre se tiene que renombrar la consulta ), se le puede aplicar a la tabla nueva creada con la subcunsulta JOINS

SELECT e1.nom, e1.cognoms
			FROM empleats e1
            WHERE (e1.feina_codi, e1.salari) = 
												(SELECT e2.feina_codi, e2.salari
													FROM empleats e2
                                                    WHERE e2.nom = "Neena"
                                                    AND e1.empleat_id != e2.empleat_id);
    

SELECT SUM(quantitat) AS qt
	FROM casos
WHERE YEAR(data)=2020
GROUP BY municipi_id
ORDER BY qt ASC
LIMIT 1;

SELECT c1.municipis_id, SUM(c1.quantitat) AS qt 
	FROM casos c1
    INNER JOIN municipis m ON m.municipi_id = c.municipi
    GROUP BY m.municipis_id
    HAVING qt =
				(SELECT SUM(c2.quantitat) AS qt
					FROM casos c2
                    INNER JOIN municipis m2 ON m2.municipi_id = c2.municipi
					WHERE YEAR(data)=2020
					GROUP BY m2.municipi_id
					ORDER BY qt ASC
					LIMIT 1)
    ORDER BY qt ASC;
    
SELECT empleat_id, nom, cognoms, salari, 
	LAG(salari) OVER ( ORDER BY empleat_id ) AS salari_ant 
	FROM empleats ORDER BY empleat_id;
    
SELECT empleat_id, nom, cognoms, salari, departament_id, 
		RANK() OVER ( PARTITION BY departament_id ORDER BY salari) AS salari_rank 
        FROM empleats 
        WHERE departament_id IS NOT NULL 
        ORDER BY departament_id;
        
SELECT empleat_id, cognoms, departament_id,salari, (SELECT SUM(salari) 
														FROM empleats e2 
														WHERE e2.departament_id = e1.departament_id) AS salari 
		FROM empleats e1;
        
-- CTE Recursivitat

WITH RECURSIVE qn(contador) AS ( SELECT  1 AS contador
									UNION ALL
									SELECT contador + 1
                                    FROM qn
                                    WHERE contador < 3)
SELECT contador
	FROM qn;
  -------------------------------------------  
use rrhh;
-----------------------------------------------------
CREATE TABLE vendes (
	data DATE,
    import INT,
    qt INT 
);

INSERT INTO vendes (data,import,qt)
	values ("2026-01-01",1000,10),
			("2026-01-02",1500,10),
            ("2026-01-03",1300,10),
            ("2026-01-06",2000,10),
            ("2026-01-07",1400,10),
            ("2026-01-10",1100,10);
            
WITH RECURSIVE dates (data) AS 
(
SELECT MIN(data) AS data
FROM vendes
UNION ALL
SELECT ADDDATE(data,1) AS data
FROM dates
WHERE adddate(data,1) <= (SELECT MAX(data) FROM vendes)
)

SELECT d.data,IFNULL(v.import,0) AS import
	FROM dates d 
    LEFT JOIN vendes v ON v.data = d.data;
    
-----------------------------------------------------
-- HACER RECURVIDIDAD DE UN ARBOL

WITH RECURSIVE emp_path AS (  
  SELECT e0.empleat_id,e0.nom,e0.cognoms,e0.id_cap, 0 nivell  
    FROM empleats e0         /*--> PRIMER NIVELL 0*/ 
  WHERE e0.id_cap IS NULL 
  UNION ALL 
  SELECT en.empleat_id,en.nom,en.cognoms,en.id_cap, nivell+1 
     FROM empleats en       /* ---> RESTA NIVELLS*/ 
     INNER JOIN emp_path ep on ep.empleat_id = en.id_cap    
) 
SELECT *  
   FROM emp_path 
ORDER BY  nivell; 
------------------------------------------------------------
-- CON UN PATH PARA SABER DE DONDE VIENE
WITH RECURSIVE empleats_paths (empleat_id, nom,cognoms, path) AS 
( 
  SELECT empleat_id, nom,cognoms 
         ,CAST(CONCAT(nom,' ',cognoms) AS CHAR(500)) 
    FROM empleats 
    WHERE id_cap IS NULL 
  UNION ALL 
  SELECT e.empleat_id 
         ,e.nom,e.cognoms 
         ,CONCAT(ep.path, '->', CONCAT(e.nom,' ',e.cognoms)) 
    FROM empleats_paths AS ep JOIN empleats AS e 
      ON ep.empleat_id = e.id_cap 
) 
SELECT * FROM empleats_paths ORDER BY path;

-- transacions : el concepto basico es que dos o mas instrucciones se ejecuten de forma atomica es decir o se ejceutan todas o no se ejecutan

-- para hacer eso tenemos que empezar con un BEGIN y acabar con un COMMIT para confirmar o ROLLBACK para desacerlo

BEGIN;

SELECT * FROM historial_feines;

DELETE FROM historial_feines;

DELETE FROM vendes;

UPDATE empleats
	set id_cap = null ;

DELETE FROM empleats;

ROLLBACK;

-- tipos de aillament que se pueden configurar 

-- READ UNCOMMIT (esto lee los datos sin que esten commitadas es decir si cambias algo los selects se veran para todos los usuarios en el momento)
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ;

-- ideal para poder aumentar la cantidad de usuarios que pueden entrar y para datos que nos da igual si los cambios se ven o no
 
 -- ------------------------------------------------------------------------------------------------------------------------------------------------
 
-- READ COMMITTED (Este es el que viene por defecto y lo que hace es que los selects de datos cambiados no se ven los cambios hasta que se haga el commit correspondiente)
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- el problema que tenemos con este es que si tu estas haciendo un tipo de calculo con un valor y ese valor se esta cambiando y vuelves acceder a el y ha cambiado porque el usuario ha hecho el commit tendras incongluencias

-- -------------------------------------------------------------------------------------------------------------------------------------------------

-- REPEATABLE READ (Hace que una vez leemos una dada aunq la cambien con un commit seguirmemos leyendo ese dato)
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Hay un problema poprque cuando hay un insert en la lectura esta no lo aisla siempre que hagas un update de esa taula esto se llama lecturas fantasma 

-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- SERIALIZABLE (esto es el nivel maximo de aislamiento y obliga a bloquear la tabla entera en cualquier tipo de caso incluso con selects)
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- en el caso de que alguien haga un select de esa tabla esta bloqueada hasta el commit

-- --------------------------------------------------------------------------------------------------
-- Indices 
-- a la hora de hacer un indice con mas de un campo siempre hay que poner primero el indice que tiene menos variantes como por ejemplo (popularitat(1-3),ciutat(nombre))

-- a la hora de decidir si aprobechamos un index siempre se puede aprovechar si lo que se busca esta en orden es decir el de arriba no se puede aprobechar para buscar ciutats pero si para buscar popularitat

-- si por ejemplo queremos aprovechar una para no tener dos indexos podemos hacer un cambio, es decir queremos si necesitamos si o si un index para ciutat, es mas facil hacer (ciutat,popularitat) 

-- lo que tenemos que tener claro es que cuantos menos necesitemos mejor, pero si solucionan problemas pues se tienen que usar y son necesarios

CREATE INDEX idx_factures_data -- el nombre que le ponemo
	USING BTREE
    ON FACTURES (data_facura);  -- Esto es la creacion de un index de la tabla facturas creamos un index de data_factura
    
-- podemos desabilitar los index de una tabla sin borrarlos se mantienen y tienen un coste pero no se usan para optimizar
ALTER TABLE paisos ALTER INDEX c INVISIBLE;

SHOW INDEX FROM empleats -- esto te enseña el idnex y te dice si esta activo o desactivado

-- EXPLAIN  esta instruccion nos da la informacion del coste que tiene una consulta y si necesitamos un idex o mejor una consulta



            

                                    
    