-- EXERCICI4

WITH RECURSIVE jerarquia AS (
    SELECT empleat_id, nom, cognoms, id_cap
    FROM empleats
    WHERE empleat_id = 149

    UNION ALL

    SELECT e.empleat_id, e.nom, e.cognoms, e.id_cap
    FROM empleats e
    INNER JOIN jerarquia j
        ON e.id_cap = j.empleat_id
)
SELECT *
FROM jerarquia;

-- EX4
WITH RECURSIVE mesos AS (
    SELECT 1 AS mes
    UNION ALL
    SELECT mes + 1
    FROM mesos
    WHERE mes < 12
)
SELECT 
    m.mes,
    COUNT(e.empleat_id) AS quantitat
FROM mesos m
LEFT JOIN empleats e ON MONTH(e.data_contractacio) = m.mes AND YEAR(e.data_contractacio) = 1999
GROUP BY m.mes
ORDER BY m.mes;

-- ex5
WITH regions_paisos AS (
    SELECT 
        r.regio_id,
        r.nom AS nom_regio,
        p.pais_id
    FROM regions r
    LEFT JOIN paisos p
        ON p.regio_id = r.regio_id
)
SELECT 
    nom_regio,
    COUNT(pais_id) AS quantitat_paisos
FROM regions_paisos
GROUP BY nom_regio
ORDER BY nom_regio;
 -- ex6
 
 SELECT 
    empleat_id,
    nom,
    cognoms,
    departament_id,
    COUNT(*) OVER (PARTITION BY departament_id) AS total_empleats_departament -- aqui lo que hacemos es agrupar por departament id y hacemos un count sobre eso 
FROM empleats;

-- ex7
 SELECT 
    empleat_id,
    nom,
    cognoms,
    salari,
    departament_id,
    AVG(salari) OVER (PARTITION BY departament_id) AS mitjana,
	MAX(salari) OVER (PARTITION BY departament_id) AS maxim, 
	MIN(salari) OVER (PARTITION BY departament_id) AS minim,
    MAX(salari) OVER (PARTITION BY departament_id) - MIN(salari) OVER (PARTITION BY departament_id) AS diferencia
FROM empleats;



