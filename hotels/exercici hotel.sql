USE db_hotels;

SELECT client_id, nom, cognom1
	FROM clients c
    WHERE EXISTS ( SELECT 1
					FROM reserves r
                    WHERE (YEAR(data_inici) = 2015 OR YEAR(data_fi)=2015) AND c.client_id=r.client_id) 
		AND NOT EXISTS ( SELECT 1
					FROM reserves r
                    WHERE (YEAR(data_inici) = 2014 OR YEAR(data_fi)=2014) AND c.client_id=r.client_id) ;
                    
SELECT c.client_id, c.nom, c.cognom1
	FROM clients c
    WHERE EXISTS ( SELECT 1 
					FROM reserves r
                    INNER JOIN habitacions h ON h.hab_id =r.hab_id
                    WHERE YEAR(r.data_inici) = 2015 AND c.client_id = r.client_id AND
                    EXISTS (SELECT 1 
								FROM reserves r2
                                INNER JOIN habitacions h2 ON h2.hab_id =r2.hab_id
                                WHERE YEAR(r2.data_inici) = 2014 AND c.client_id = r2.client_id
                                AND h.hotel_id = h2.hotel_id))
	ORDER BY c.client_id ASC;
                    
                    