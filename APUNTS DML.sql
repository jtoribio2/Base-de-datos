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