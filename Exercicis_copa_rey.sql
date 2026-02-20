use copa_rey_18_db;

SELECT * 
	FROM jugadors;

SELECT COUNT(*) AS quants
	FROM jugadors
    WHERE nom_complet REGEXP '[AEIOUaeiou]{3}';
    
SELECT nom_complet
	FROM jugadors
ORDER BY CHAR_LENGTH(SUBSTRING_INDEX(nom_complet, ',', 1)) DESC
LIMIT 1;

SELECT nom, web
	FROM clubs
WHERE web REGEXP '.cat$'
ORDER BY club_id;

SELECT *
	FROM partits;

SELECT COUNT(*) AS quantitat
	FROM partits
    WHERE month(data_hora)=5 ;
    
SELECT COUNT(*) AS qt_desembre
	FROM jugadors
    WHERE month(data_naixement)=12 ;
    
SELECT DISTINCT lloc_naixement
	FROM jugadors
    WHERE lloc_naixement REGEXP '^[b,B]'
    ORDER BY lloc_naixement ASC;
    
SELECT partit_id
	FROM partits
    WHERE equip_local_punts = equip_visitant_punts
    ORDER BY partit_id;
    
SELECT nom_complet
	FROM jugadors
WHERE twitter IS NULL
ORDER BY nom_complet ASC;

SELECT COUNT(*) AS quantitat
	FROM partits
    WHERE year(data_hora)=2019
    ORDER BY partit_id; 
    
SELECT nom
	FROM clubs
    WHERE web IS NULL
    ORDER BY nom ASC;

SELECT*
FROM clubs;

SELECT  *
	FROM partits p
    INNER JOIN competicions c ON c.competicio_id = p.competicio_id
    INNER JOIN equips_anys ea ON ea.competicio_id = c.competicio_id
    INNER JOIN clubs cu ON cu.club_id = ea.club_id
    WHERE cu.nom = "F.C. Barcelona" AND dayofweek(p.data_hora)=1;
    
SELECT *
	FROM partits p
    INNER JOIN
    WHERE p.partit_id = 1;
	
