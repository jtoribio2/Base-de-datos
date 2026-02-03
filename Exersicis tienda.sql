-- EX1
SELECT nombre
FROM producto;
-- EX2
SELECT nombre, precio
FROM producto;
-- EX3
SELECT *
FROM producto;
-- EX4
SELECT nombre AS 'nom de producte', precio AS 'euros', precio*1.9 AS 'dolars'
FROM producto;
-- EX 5
SELECT UPPER(nombre),precio
FROM producto;
-- EX 6 
SELECT LOWER(nombre),precio
FROM producto;
-- EX 7
SELECT nombre, substring(nombre,1,2)
FROM fabricante;
-- EX 8 
SELECT nombre, round(precio,2)
FROM producto;
-- EX 9
SELECT nombre, truncate(precio,0)
FROM producto;
-- EX 10
SELECT codigo_fabricante
FROM producto;
-- EX 11
SELECT DISTINCT codigo_fabricante
FROM producto;
-- EX 12
SELECT nombre
	FROM fabricante
    ORDER BY nombre ASC;
-- EX 13
SELECT nombre
	FROM fabricante
    ORDER BY nombre DESC;
-- EX 14
SELECT nombre
	FROM producto
    ORDER BY nombre ASC, precio DESC;
-- EX 15
SELECT *
	FROM fabricante
    LIMIT 5;
-- EX 16
SELECT *
	FROM fabricante
    LIMIT 3,2;
-- EX 17
SELECT nombre, precio
	FROM producto
    ORDER BY precio ASC
    LIMIT 1;
-- EX 18 
SELECT nombre, precio
	FROM producto
    ORDER BY precio ASC
    LIMIT 1;
-- EX 19
SELECT nombre
	FROM producto
    WHERE codigo_fabricante = 2;
-- EX 20
SELECT nombre
	FROM producto
    WHERE precio <= 120;
-- EX 21
SELECT nombre
	FROM producto
    WHERE precio >= 400;
-- EX 22
SELECT nombre
	FROM producto
    WHERE precio < 400;
-- EX 23
SELECT *
	FROM producto
    WHERE precio >=80 AND precio <= 300;
-- EX 24
SELECT *
	FROM producto
    WHERE precio BETWEEN 60 AND 200;
-- EX 25
SELECT *
	FROM producto
    WHERE precio >200 AND codigo_fabricante = 6;
-- EX 26
SELECT *
	FROM producto
    WHERE codigo = 1 OR codigo = 3 OR codigo = 5;
-- EX 27
SELECT *
	FROM producto
    WHERE codigo IN (1,3,5);
-- EX 28
SELECT nombre, precio*100 AS 'Centims'
	FROM producto;
-- EX 29
SELECT nombre
	FROM fabricante
    WHERE substring(nombre,1,1)='S';
-- EX30
SELECT nombre
	FROM fabricante
    WHERE substring(nombre,length(nombre),1)='e';
-- EX 31
SELECT nombre
	FROM fabricante
    WHERE nombre LIKE '%w%';
-- EX 32
SELECT nombre
	FROM fabricante
    WHERE length(nombre)=4;
-- EX 33
SELECT nombre
	FROM producto
    WHERE nombre LIKE '%Portatil%';
-- EX 34
SELECT nombre
	FROM producto
    WHERE nombre LIKE '%Monitor%' AND precio < 215;
-- EX 35
SELECT nombre, precio
	FROM producto
    WHERE precio >= 180
    ORDER BY precio DESC, nombre ASC;

