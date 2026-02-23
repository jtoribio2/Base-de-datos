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
    

	
SELECT ea.nom AS nom_equip, SUM(
		CASE estadistic_id
			WHEN 3 THEN epj.valor*1
            WHEN 5 THEN epj.valor*2
            WHEN 7 THEN epj.valor*3
		END) AS punts
	FROM equips_anys ea
   INNER JOIN partits p ON p.equip_local =ea.equip_any_id OR p.equip_visitant = ea.equip_any_id
   INNER JOIN contractes c ON c.equip_any_id = ea.equip_any_id
   INNER JOIN estadistic_partit_jugador epj ON epj.jugador_id = c.jugador_id AND epj.partit_id= p.partit_id
   WHERE p.partit_id =1 AND epj.estadistic_id IN (3,5,7)
   GROUP BY ea.equip_any_id;
   
   SELECT j.lloc_naixement -- junta las dos selects y quita las repetidas, si delante del union ponemos all salen todos menos los repetidos
	FROM equips_anys ea
    INNER JOIN contractes c ON c.equip_any_id = ea.equip_any_id
    INNER JOIN jugadors j ON j.jugador_id = c.jugador_id
    WHERE ea.equip_any_id = 2
    UNION
    SELECT j.lloc_naixement
	FROM equips_anys ea
    INNER JOIN contractes c ON c.equip_any_id = ea.equip_any_id
    INNER JOIN jugadors j ON j.jugador_id = c.jugador_id
    WHERE ea.equip_any_id = 1;