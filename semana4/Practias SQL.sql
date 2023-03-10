-- 1. CREAR UNA BASE DE DATOS LLAMADA MINIMARKET
CREATE DATABASE minimarket;

-- 2. CREAR UNA TABLA LLAMADA CATEGORIA:
-- id entero llave primaria y auto incrementable
-- nombre text

CREATE TABLE categorias(
id			INT PRIMARY KEY AUTO_INCREMENT,
nombre		TEXT
);


-- 3. CREAR UNA TABLA LLAMADA PRODUCTOS en la cual tengamos lo siguiente:
-- id entero llave primaria y auto incrementable
-- nombre text
-- imagen text
-- fecha_vencimiento date
-- precio float
-- disponible boolean defecto (verdadero)

CREATE TABLE productos (
id				INT PRIMARY KEY AUTO_INCREMENT,
nombre			TEXT,
imagen			TEXT,
fecha_vencimiento	DATE,
precio			FLOAT,
disponible		BOOLEAN DEFAULT TRUE,
categoria_id	INT,
FOREIGN KEY (categoria_id) REFERENCES categorias(id) 
);


-- 4. CREAR UNA TABLA LLAMADA ALMACEN en la cual seria de la sgte manera:
-- id entero llave primaria y auto incrementable
-- nombre text
-- direccion text
CREATE TABLE almacenes(
id			INT PRIMARY KEY AUTO_INCREMENT,
nombre		TEXT,
direccion	TEXT
);
-- Una categoria puede tener varios productos pero un producto pertenece a una sola categoria
CREATE TABLE almacen_producto(
id			INT PRIMARY KEY AUTO_INCREMENT,
almacen_id	INT NOT NULL,
producto_id	INT NOT NULL,
FOREIGN KEY (almacen_id) REFERENCES almacenes(id),
FOREIGN KEY (producto_id) references productos(id)
);

INSERT INTO categorias (id, nombre) VALUES (DEFAULT, 'Frutas'), 
										   (DEFAULT, 'Legumbres'), 
                                           (DEFAULT, 'Snacks'), 
                                           (DEFAULT, 'Otros');

INSERT INTO productos (id, nombre, imagen, fecha_vencimiento, precio, disponible, categoria_id) VALUES (DEFAULT, 'Lechuga Carola', 'https://google.com','2022-01-10',2.90, true, 2),
                                                                                                       (DEFAULT, 'Beterraga', 'https://google.com','2022-02-14',1.90, true, 2),
                                                                                                       (DEFAULT, 'Papitas fritas', 'https://google.com','2025-01-10',2.90, true, 3),
                                                                                                       (DEFAULT, 'Platano de seda', 'https://google.com','2022-01-10',4.75, true, 1),
                                                                                                       (DEFAULT, 'Short playero', 'https://google.com','2022-12-31',39.90, true, 4),
                                                                                                       (DEFAULT, 'Mandarina', 'https://google.com','2022-05-23',2.90, true, 1);

INSERT INTO almacenes (id, nombre, direccion ) VALUES (DEFAULT, 'ALMACEN A', 'Calle los ruise??ores 1080'),
                                                      (DEFAULT, 'ALMACEN B', 'Calle los girasoles 570'),
                                                      (DEFAULT, 'ALMACEN C', 'Av Venezuela 3040');

INSERT INTO almacen_producto (id, almacen_id, producto_id) VALUES (DEFAULT, 1, 1),
                                                                  (DEFAULT, 1, 2),
                                                                  (DEFAULT, 2, 2),
                                                                  (DEFAULT, 2, 3),
                                                                  (DEFAULT, 3, 4),
                                                                  (DEFAULT, 1, 5),
                                                                  (DEFAULT, 2, 6),
                                                                  (DEFAULT, 3, 5);
                                                                  
SELECT * FROM productos;

-- Ejercicios
-- 1. Mostrar todos los productos que tengan un precio mayor o igual que 3
SELECT * FROM productos where precio >= 3;

-- 2. Mostrar todos los productos cuya fecha de vencimiento sea menor al 1 de agosto del 2022
select * from productos where fecha_vencimiento < '2022-08-01';

-- 3. Mostrar los nombres de los productos concatenados con su url de la imagen en una sola columna que 
-- se llame 'producto imagen'
select concat (nombre, ' ', imagen) AS 'producto imagen' from productos;

-- 4. Devolver todos los productos de la categoria 'frutas'
select * from productos as p inner join categorias as c on p.categoria_id = c.id
where c.nombre = 'frutas';

-- 5. devolver el nombre de la categoria, nombre del producto y el precio del producto si es mayor a 10
select c.nombre as 'categoria nombre',
 p.nombre as 'producto nombre',
 p.precio 
 from productos as p inner join categorias as c on p.categoria_id = c.id
where p.precio > 10;

-- 6. devolver los almacenes con sus productos 
select *
from almacenes AS a INNER JOIN almacen_producto as ap on a.id = ap.almacen_id
					inner join productos as p on ap.producto_id = p.id

-- 7. Mostrar lo siguiente:
-- Tabla categorias:
-- * nombre 
-- Tabla Productos:
-- * nombre
-- * precio
-- Tabla Almacenes:
-- * nombre
-- * direccion 

select c.nombre, p.nombre, p.precio, a.nombre, a.direccion 
from categorias as c INNER JOIN productos as p on c.id = p.categoria_id
					  INNER JOIN almacen _producto as ap on p.id = ap.producto_id
					  INNER JOIN almacenes as a on ap.almacen_id = a.id;
