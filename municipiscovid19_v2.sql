USE municipis_covid19;

ALTER TABLE municipis
	RENAME COLUMN comarca TO comarca_id;

ALTER TABLE municipis
	MODIFY COLUMN municipi_id 				SMALLINT UNSIGNED  AUTO_INCREMENT,
    MODIFY COLUMN codi 		  				CHAR (40) NOT NULL,
    MODIFY COLUMN codi_ine 	  				CHAR (5),
    MODIFY COLUMN comarca_id  				TINYINT UNSIGNED AFTER municipi_id,
    ADD	   COLUMN num_habitants				INT UNSIGNED,-- CASCADE
    ADD CONSTRAINT pk_municipis 			PRIMARY KEY (municipi_id),
    ADD CONSTRAINT uk_municipis_codi		UNIQUE(codi),
    ADD CONSTRAINT uk_municipis_codi_ine	UNIQUE(codi_ine);

ALTER TABLE comarca RENAME TO comarcas;
    
ALTER TABLE comarcas
	MODIFY COLUMN comarca_id				TINYINT UNSIGNED AUTO_INCREMENT,
    MODIFY COLUMN codi						CHAR(2) NOT NULL,
    MODIFY COLUMN nom						VARCHAR(25) NOT NULL DEFAULT ' ',
    ADD CONSTRAINT pk_comarcas 				PRIMARY KEY (comarca_id),
    ADD CONSTRAINT uk_municipis_codi		UNIQUE(codi);
    
ALTER TABLE municipis
	ADD CONSTRAINT fk_municipis_comarcas	FOREIGN KEY (comarca_id)
											REFERENCES comarcas (comarca_id)
                                            ON DELETE CASCADE;
ALTER TABLE casos
	DROP CONSTRAINT fk_casos_tipus_casos,
    DROP INDEX fk_casos_tipus_casos;

ALTER TABLE tipus_casos
	DROP PRIMARY KEY,
    MODIFY COLUMN tipus_cas					CHAR(5),
    MODIFY COLUMN nom						VARCHAR(30),
    ADD CONSTRAINT pk_tipus_casos			PRIMARY KEY (tipus_cas),
    ADD CONSTRAINT ck_tipus_casos_tipus_cas CHECK (tipus_cas IN ('PCR', 'TAR', 'ELISA', 'TR', 'EPID'));

ALTER TABLE casos RENAME TO municipi_casos;

UPDATE municipi_casos
	SET quantitat = 0
    WHERE quantitat IS NULL;

ALTER TABLE municipi_casos
    MODIFY COLUMN municipi_id						SMALLINT UNSIGNED,
    MODIFY COLUMN data								DATE,
    MODIFY COLUMN sexe								CHAR(1),
    MODIFY COLUMN tipus_cas							CHAR(5),
    ADD    COLUMN any								CHAR(4) GENERATED ALWAYS AS (YEAR(data)) STORED AFTER tipus_cas,
    MODIFY COLUMN quantitat							SMALLINT NOT NULL DEFAULT 0 ,
    ADD CONSTRAINT pk_municipi_casos				PRIMARY KEY (municipi_id,data,sexe,tipus_cas),
    ADD CONSTRAINT ck_municipi_casos_quantitat 		CHECK (quantitat <= 1000),
    ADD CONSTRAINT fk_municipi_casos_municipis 		FOREIGN KEY (municipi_id)
													REFERENCES municipis (municipi_id) ON DELETE CASCADE,
	ADD CONSTRAINT fk_municipi_casos_tipus_casos 	FOREIGN KEY (tipus_cas)
													REFERENCES tipus_casos(tipus_cas);
                                                    

	CREATE 	INDEX idx_municipi_id_data_sexe_tipus_cas
			USING BTREE
            ON municipi_casos (municipi_id,data,sexe,tipus_cas);

	CREATE VIEW v_municipis_girona AS
		SELECT 	municipi_id,
				comarca_id,
				nom
		FROM municipis
		WHERE comarca_id IN (2, 10, 15, 19, 20, 28, 31, 34);
    
ALTER TABLE municipis
	

     
    
	