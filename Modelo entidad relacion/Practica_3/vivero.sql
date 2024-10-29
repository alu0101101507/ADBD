/*
 * Nombre: Jose miguel hernandez santana
 * Alu: alu0101101507
 * Uso: psql
 *      \i vivero.sql
 *
 */

SET client_min_messages TO WARNING;
/* --DROP TABLES-- */
DROP TABLE IF EXISTS vivero CASCADE;
DROP TABLE IF EXISTS zonas CASCADE;
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS cliente_afiliado CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;

/* -- Create tables --*/
-- Tabla Vivero
CREATE TABLE vivero (
    vivero_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    longitud FLOAT NOT NULL,
    latitud FLOAT NOT NULL
);

-- Tabla Zonas
CREATE TABLE zonas (
    zona_id SERIAL PRIMARY KEY,
    tipo_zona VARCHAR(50) NOT NULL,
    longitud FLOAT NOT NULL,
    latitud FLOAT NOT NULL,
    vivero_id INT REFERENCES vivero(vivero_id) ON DELETE cascade,
    cantidad_stock INT DEFAULT 0 CHECK (cantidad_stock >= 0)
);

-- Tabla Producto
CREATE TABLE producto (
    producto_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    zona_id INT REFERENCES zonas(zona_id) ON DELETE cascade
);

-- Tabla Empleados
CREATE TABLE empleados (
    DNI CHAR(10) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE,
    puesto VARCHAR(50) NOT NULL,
    historial TEXT,  -- Campo opcional, puede ser NULL y se trata de un atributo derivado
    zona_id INT REFERENCES zonas(zona_id) ON DELETE cascade,
    CHECK (fecha_finalizacion IS NULL OR fecha_inicio <= fecha_finalizacion)
);

-- Tabla Cliente
CREATE TABLE cliente (
    DNI CHAR(10) PRIMARY KEY,
    nombre_cliente VARCHAR(50) NOT NULL
);

-- Tabla Cliente_Afiliado
CREATE TABLE cliente_afiliado (
    DNI CHAR(10) PRIMARY KEY REFERENCES cliente(DNI) ON DELETE CASCADE,
    compras_mensuales INT CHECK (compras_mensuales >= 0),
    fecha_ingreso DATE NOT NULL,
    valor_bonificacion NUMERIC(10, 2) DEFAULT 0 CHECK (valor_bonificacion >= 0)
);

-- Tabla Pedido
CREATE TABLE pedido (
    pedido_ID SERIAL PRIMARY KEY,
    fecha_compra DATE NOT NULL,
    fecha_pedido DATE NOT NULL,
    empleado_DNI CHAR(10) NOT NULL REFERENCES empleados(DNI) ON DELETE cascade,
    cliente_DNI CHAR(10) NOT NULL REFERENCES cliente(DNI) ON DELETE cascade,
    producto_ID INT NOT NULL REFERENCES producto(producto_id) ON DELETE cascade,
    CHECK (Fecha_compra <= Fecha_pedido),
    UNIQUE (empleado_DNI)
);

/* Insertado de datos */
--Datos de viveros
INSERT INTO vivero (Nombre, Longitud, Latitud) VALUES
('Vivero Norte', -3.70379, 40.41678),
('Vivero Sur', -3.70380, 40.41679),
('Vivero Este', -3.70381, 40.41680),
('Vivero Oeste', -3.70382, 40.41681),
('Vivero Central', -3.70383, 40.41682);

-- Datos de zonas
INSERT INTO zonas (tipo_zona, longitud, latitud, vivero_id, cantidad_stock) VALUES
('Almacen', -3.70379, 40.41678, 1, 100),
('Zona exterior', -3.70380, 40.41679, 2, 200),
('Zona interior', -3.70381, 40.41780, 3, 150),
('Area de plantacion', -3.70382, 40.41781, 4, 50),
('Cerco', -3.70383, 40.41782, 5, 80);

-- Datos de Producto

INSERT INTO producto(nombre, zona_id) VALUES
('Eucalipto', 1),
('Olmo', 2),
('Pinos', 3),
('Acacias', 4),
('Ceibo', 5);

-- Datos de empleados
INSERT INTO empleados (dni, nombre, fecha_inicio, fecha_finalizacion, puesto, historial, zona_id) VALUES
('68295374W', 'Maria', '2022-01-01', '2023-01-01', 'supervisor', 'buen trabajador', 1),
('35262646N', 'Jose', '2022-01-15', '2023-01-15', 'jardinero', 'promedio', 2),
('91746739S', 'Adrian', '2022-03-01', '2023-03-01', 'administrador', 'promovido recientemente', 3),
('10168568S', 'Joel', '2022-05-01', '2023-05-01', 'mozo', 'trabajador centrado, muchas ventas', 4),
('77921676E', 'Miguel', '2022-04-01', '2023-04-01', 'auxiliar', 'genera buen ambiente de trabajo', 5);

-- Datos de clientes

INSERT INTO cliente (dni, nombre_cliente) VALUES
('54963662X', 'Mauro Gonzales'),
('42176740F', 'Maria Becerra'),
('86402473Y', 'Joel Alvarez'),
('43626486V', 'Daniel Cornmier'),
('50144958J', 'Dustin Poirier'),
('00257270S', 'Luis Suarez');


-- Datos de clientes afiliado
INSERT INTO cliente_afiliado (dni, compras_mensuales, fecha_ingreso, valor_bonificacion) VALUES
('42176740F', 10, '2022-06-01', 50.00),
('54963662X', 5, '2023-01-05', 20.00),
('50144958J', 15, '2023-02-06', 70.00),
('43626486V', 20, '2022-05-18', 80.00),
('86402473Y', 10, '2022-06-01', 50.00);

--  Datos de pedidos
INSERT INTO pedido (fecha_compra, fecha_pedido, empleado_dni, cliente_dni, producto_id) VALUES
('2023-01-10', '2023-01-12', '68295374W', '42176740F', 1),
('2023-02-10', '2023-02-12', '35262646N', '54963662X', 2),
('2023-03-10', '2023-03-12', '91746739S', '50144958J', 3),
('2023-04-10', '2023-04-12', '10168568S', '43626486V', 4),
('2023-05-10', '2023-05-12', '77921676E', '86402473Y', 5);

/* Select a las tablas */

-- Select tabla vivero
SELECT * FROM vivero;

-- Select tabla zonas
SELECT * FROM zonas;

-- Select tabla empleados
SELECT * FROM empleados;

-- Select tabla producto
SELECT * FROM producto;

-- Select tabla cliente
SELECT * FROM cliente;

-- Select tabla cliente_afiliado
SELECT * FROM cliente_afiliado;

-- Select tabla pedido
SELECT * FROM pedido;