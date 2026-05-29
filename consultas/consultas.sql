USE nexshop_db;

-- 1. Mostrar todos los registros de una tabla relevante de tu modelo.
SELECT *
FROM CLIENTE;

-- 2. Seleccionar solo algunos campos concretos de una tabla: nombre y email de los clientes registrados.
SELECT Nombre, Email
FROM CLIENTE;

-- 3. Filtrar registros por un valor exacto con WHERE: pedidos con estado 'PENDIENTE'.
SELECT *
FROM PEDIDO_ONLINE
WHERE Estado = 'PENDIENTE';

-- 4. Filtrar usando LIKE para buscar un patron en un campo de texto: productos cuyo nombre contiene una palabra clave.
SELECT ID_Producto, Nombre, Marca, SKU
FROM PRODUCTO
WHERE Nombre LIKE '%Portatil%';

-- 5. Filtrar usando LIKE para buscar registros que empiezan por una letra: clientes cuyo nombre empieza por 'L'.
SELECT ID_Cliente, Nombre, Apellidos, Email
FROM CLIENTE
WHERE Nombre LIKE 'L%';

-- 6. Filtrar por un rango de fechas con BETWEEN: pedidos realizados entre dos fechas concretas.
SELECT ID_Pedido, Fecha_Pedido, Estado, Total_Final
FROM PEDIDO_ONLINE
WHERE Fecha_Pedido BETWEEN '2025-07-01' AND '2025-07-31';

-- 7. Filtrar por un rango numerico con BETWEEN: productos cuyo precio esta entre dos valores.
SELECT
    P.ID_Producto,
    P.Nombre,
    H.PVP
FROM PRODUCTO P
INNER JOIN HISTORIAL_PRECIO_PRODUCTO H
    ON P.ID_Producto = H.ID_Producto
WHERE H.Fecha_Fin IS NULL
  AND H.PVP BETWEEN 40 AND 900;

-- 8. Filtrar por una condicion numerica mayor que un valor: lineas de pedido con cantidad superior a un umbral.
SELECT ID_Detalle_Pedido, ID_Pedido, ID_Producto, Cantidad, Total_Linea
FROM DETALLE_PEDIDO_ONLINE
WHERE Cantidad > 0;

-- 9. Ordenar resultados de forma ascendente con ORDER BY: pedidos del mas antiguo al mas reciente.
SELECT ID_Pedido, Fecha_Pedido, Estado, Total_Final
FROM PEDIDO_ONLINE
ORDER BY Fecha_Pedido ASC;

-- 10. Ordenar resultados de forma descendente con ORDER BY: productos de mayor a menor precio.
SELECT
    P.ID_Producto,
    P.Nombre,
    H.PVP
FROM PRODUCTO P
INNER JOIN HISTORIAL_PRECIO_PRODUCTO H
    ON P.ID_Producto = H.ID_Producto
WHERE H.Fecha_Fin IS NULL
ORDER BY H.PVP DESC;

-- 11. Ordenar alfabeticamente por un campo de texto: clientes ordenados por nombre de la A a la Z.
SELECT ID_Cliente, Nombre, Apellidos, Email
FROM CLIENTE
ORDER BY Nombre ASC, Apellidos ASC;

-- 12. Actualizar un campo de un registro concreto con UPDATE: cambiar el estado de un pedido especifico.
UPDATE PEDIDO_ONLINE
SET Estado = 'EN_PREPARACION'
WHERE ID_Pedido = 3;

-- 13. Actualizar un campo usando WHERE para identificar el registro: modificar el telefono de un proveedor por su identificador.
UPDATE PROVEEDOR
SET Telefono = '961111222'
WHERE ID_Proveedor = 1;

-- 14. Combinar dos tablas relacionadas con JOIN y mostrar campos de ambas: nombre del cliente junto con sus pedidos.
SELECT
    C.ID_Cliente,
    C.Nombre,
    C.Apellidos,
    P.ID_Pedido,
    P.Fecha_Pedido,
    P.Estado,
    P.Total_Final
FROM CLIENTE C
INNER JOIN PEDIDO_ONLINE P
    ON C.ID_Cliente = P.ID_Cliente
ORDER BY C.ID_Cliente, P.Fecha_Pedido;

-- CONSULTAS DE COMPROBACION DEL MODELO
-- Estas consultas sirven para verificar en MySQL Workbench que la base de datos,
-- las tablas, sus columnas y sus claves foraneas se han creado correctamente.

-- COMPROBACION 1: ver todas las tablas creadas.
SHOW TABLES;

-- COMPROBACION 2: contar el numero total de tablas del modelo.
SELECT COUNT(*) AS total_tablas
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'nexshop_db';

-- COMPROBACION 3: ver la estructura de la tabla CLIENTE.
DESCRIBE CLIENTE;

-- COMPROBACION 4: listar todas las columnas de todas las tablas del proyecto.
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'nexshop_db'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- COMPROBACION 5: listar todas las claves foraneas del modelo.
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'nexshop_db'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, COLUMN_NAME;
