USE nexshop_db;

INSERT INTO CATEGORIA (ID_Categoria, Nombre, Descripcion, ID_Categoria_Padre) VALUES
(1, 'Informatica', 'Productos de tecnologia e informatica', NULL),
(2, 'Portatiles', 'Ordenadores portatiles', 1),
(3, 'Portatiles gaming', 'Portatiles de alto rendimiento para juegos', 2),
(4, 'Perifericos', 'Accesorios y dispositivos externos', 1),
(5, 'Hogar', 'Productos para el hogar', NULL);

INSERT INTO UBICACION (ID_Ubicacion, Nombre, Tipo, Direccion, Ciudad, Activa) VALUES
(1, 'Almacen Central Valencia', 'ALMACEN_CENTRAL', 'Avenida Logistica 10', 'Valencia', TRUE),
(2, 'Tienda Valencia Centro', 'TIENDA', 'Calle Colon 25', 'Valencia', TRUE),
(3, 'Tienda Madrid Norte', 'TIENDA', 'Calle Serrano 80', 'Madrid', TRUE),
(4, 'Tienda Barcelona Eixample', 'TIENDA', 'Carrer Arago 210', 'Barcelona', TRUE);

INSERT INTO CLIENTE (ID_Cliente, Nombre, Apellidos, Email, Contrasena, Fecha_Nacimiento, Fecha_Registro, Activo) VALUES
(1, 'Laura', 'Garcia Perez', 'laura.garcia@example.com', 'hash_laura_01', '1994-05-18', '2025-01-12', TRUE),
(2, 'Mario', 'Sanchez Lopez', 'mario.sanchez@example.com', 'hash_mario_02', '1988-09-03', '2025-02-04', TRUE),
(3, 'Nuria', 'Martinez Ruiz', 'nuria.martinez@example.com', 'hash_nuria_03', NULL, '2025-03-15', TRUE),
(4, 'Carlos', 'Romero Vidal', 'carlos.romero@example.com', 'hash_carlos_04', '1991-12-22', '2025-04-02', FALSE);

INSERT INTO DIRECCION_CLIENTE (ID_Direccion, Calle, Numero, Piso, Codigo_Postal, Ciudad, Pais, Tipo_Direccion, ID_Cliente) VALUES
(1, 'Calle Mayor', '14', '2A', '46001', 'Valencia', 'Espana', 'DOMICILIO', 1),
(2, 'Avenida del Puerto', '88', NULL, '46023', 'Valencia', 'Espana', 'TRABAJO', 1),
(3, 'Calle Alcala', '120', '5B', '28009', 'Madrid', 'Espana', 'DOMICILIO', 2),
(4, 'Carrer Mallorca', '55', '1C', '08029', 'Barcelona', 'Espana', 'DOMICILIO', 3),
(5, 'Calle Granada', '7', NULL, '28007', 'Madrid', 'Espana', 'OTRA', 4);

INSERT INTO PRODUCTO (ID_Producto, Nombre, Marca, Descripcion, SKU, Activo, ID_Categoria) VALUES
(1, 'Portatil NovaBook 14', 'NovaTech', 'Portatil ultraligero para oficina', 'NB14-2026', TRUE, 2),
(2, 'Portatil Gamer Xtreme 16', 'XtremePC', 'Portatil gaming con grafica dedicada', 'GX16-2026', TRUE, 3),
(3, 'Raton Inalambrico Pro', 'ClickPro', 'Raton ergonomico inalambrico', 'MOUSE-PRO', TRUE, 4),
(4, 'Teclado Mecanico RGB', 'KeyMaster', 'Teclado mecanico retroiluminado', 'KEY-RGB', TRUE, 4),
(5, 'Aspirador Smart Home', 'HomePlus', 'Aspirador inteligente para el hogar', 'ASH-100', TRUE, 5);

INSERT INTO HISTORIAL_PRECIO_PRODUCTO (ID_Historial_Precio, PVP, Fecha_Inicio, Fecha_Fin, ID_Producto) VALUES
(1, 899.99, '2025-01-01', '2025-06-30', 1),
(2, 849.99, '2025-07-01', NULL, 1),
(3, 1499.99, '2025-01-01', NULL, 2),
(4, 39.99, '2025-01-01', NULL, 3),
(5, 89.99, '2025-01-01', NULL, 4),
(6, 229.99, '2025-01-01', NULL, 5);

INSERT INTO PROMOCION (ID_Promocion, Nombre, Descripcion, Porcentaje_Descuento, Fecha_Inicio, Fecha_Fin, Activa) VALUES
(1, 'Rebajas de verano', 'Descuentos especiales de verano', 15.00, '2025-07-01', '2025-07-31', TRUE),
(2, 'Black Friday', 'Promocion de noviembre', 25.00, '2025-11-20', '2025-11-30', FALSE),
(3, 'Vuelta al cole', 'Promocion para informatica y perifericos', 10.00, '2025-09-01', '2025-09-15', TRUE);

INSERT INTO PROMOCION_PRODUCTO (ID_Promocion_Producto, Fecha_Inicio_Aplicacion, Fecha_Fin_Aplicacion, Activo, ID_Promocion, ID_Producto) VALUES
(1, '2025-07-01', '2025-07-31', TRUE, 1, 1),
(2, '2025-07-01', '2025-07-31', TRUE, 1, 3),
(3, '2025-11-20', '2025-11-30', FALSE, 2, 2),
(4, '2025-09-01', '2025-09-15', TRUE, 3, 4);

INSERT INTO EMPLEADO (ID_Empleado, Nombre, Apellidos, DNI, Email_Corporativo, Fecha_Incorporacion, Puesto, ID_Ubicacion) VALUES
(1, 'Ana', 'Ferrer', '12345678A', 'ana.ferrer@nexshop.es', '2018-03-01', 'Directora de operaciones', 1),
(2, 'David', 'Cano', '23456789B', 'david.cano@nexshop.es', '2019-06-10', 'Responsable de logistica', 1),
(3, 'Laura', 'Pons', '34567890C', 'laura.pons@nexshop.es', '2020-01-20', 'Agente atencion cliente', 1),
(4, 'Sergio', 'Blanco', '45678901D', 'sergio.blanco@nexshop.es', '2021-09-15', 'Responsable IT', 1),
(5, 'Marta', 'Soler', '56789012E', 'marta.soler@nexshop.es', '2022-05-03', 'Vendedora', 2),
(6, 'Jorge', 'Luna', '67890123F', 'jorge.luna@nexshop.es', '2023-02-18', 'Encargado tienda', 3);

INSERT INTO PROVEEDOR (ID_Proveedor, Nombre, CIF, Email, Telefono, Direccion, Ciudad, Pais, Activo, ID_Empleado_Representante) VALUES
(1, 'TecnoDistribuciones SL', 'B12345678', 'ventas@tecnodistribuciones.es', '961234567', 'Poligono Sur 4', 'Valencia', 'Espana', TRUE, 1),
(2, 'Gaming Wholesale SA', 'A87654321', 'contacto@gamingwholesale.es', '910223344', 'Calle Industria 18', 'Madrid', 'Espana', TRUE, 2),
(3, 'Home Supply Iberia', 'B99887766', 'pedidos@homesupply.es', '934455667', 'Carrer Marina 44', 'Barcelona', 'Espana', TRUE, 1);

INSERT INTO CONDICION_PROVEEDOR_PRODUCTO (ID_Condicion, Precio_Coste, Plazo_Entrega_Dias, Fecha_Inicio, Fecha_Fin, ID_Proveedor, ID_Producto) VALUES
(1, 650.00, 5, '2025-01-01', '2025-06-30', 1, 1),
(2, 625.00, 4, '2025-07-01', NULL, 1, 1),
(3, 1120.00, 7, '2025-01-01', NULL, 2, 2),
(4, 18.50, 3, '2025-01-01', NULL, 1, 3),
(5, 55.00, 6, '2025-01-01', NULL, 2, 4),
(6, 150.00, 8, '2025-01-01', NULL, 3, 5);

INSERT INTO STOCK_UBICACION (ID_Stock, Cantidad_Actual, Stock_Minimo, Stock_Maximo, Fecha_Actualizacion, ID_Producto, ID_Ubicacion) VALUES
(1, 50, 10, 120, '2025-07-01 09:00:00', 1, 1),
(2, 8, 3, 20, '2025-07-01 09:10:00', 1, 2),
(3, 20, 5, 60, '2025-07-01 09:20:00', 2, 1),
(4, 5, 2, 15, '2025-07-01 09:30:00', 2, 3),
(5, 100, 20, 200, '2025-07-01 09:40:00', 3, 1),
(6, 12, 5, 40, '2025-07-01 09:50:00', 4, 4),
(7, 30, 8, 80, '2025-07-01 10:00:00', 5, 1);

INSERT INTO PEDIDO_ONLINE (ID_Pedido, Fecha_Pedido, Estado, Total_Bruto, Puntos_Canjeados, Descuento_Puntos, Total_Final, ID_Cliente, ID_Direccion_Envio) VALUES
(1, '2025-07-02 10:15:00', 'ENTREGADO', 889.98, 1000, 10.00, 879.98, 1, 1),
(2, '2025-07-05 16:45:00', 'ENVIADO', 1499.99, 0, 0.00, 1499.99, 2, 3),
(3, '2025-07-08 12:20:00', 'PENDIENTE', 129.98, 500, 5.00, 124.98, 3, 4);

INSERT INTO DETALLE_PEDIDO_ONLINE (ID_Detalle_Pedido, Cantidad, Precio_Unitario, Descuento_Aplicado, Total_Linea, ID_Pedido, ID_Producto) VALUES
(1, 1, 849.99, 0.00, 849.99, 1, 1),
(2, 1, 39.99, 0.00, 39.99, 1, 3),
(3, 1, 1499.99, 0.00, 1499.99, 2, 2),
(4, 1, 89.99, 0.00, 89.99, 3, 4),
(5, 1, 39.99, 0.00, 39.99, 3, 3);

INSERT INTO ENVIO_PEDIDO (ID_Envio, Numero_Seguimiento, Transportista, Fecha_Envio, Fecha_Estimada_Entrega, Fecha_Entrega_Real, Estado, ID_Pedido, ID_Ubicacion_Origen) VALUES
(1, 'ENV-VAL-0001', 'Correos Express', '2025-07-02', '2025-07-04', '2025-07-04', 'ENTREGADO', 1, 2),
(2, 'ENV-MAD-0002', 'SEUR', '2025-07-06', '2025-07-08', NULL, 'ENVIADO', 2, 3),
(3, 'ENV-BCN-0003A', 'DHL', NULL, '2025-07-11', NULL, 'PREPARANDO', 3, 1),
(4, 'ENV-BCN-0003B', 'DHL', NULL, '2025-07-12', NULL, 'PREPARANDO', 3, 4);

INSERT INTO DETALLE_ENVIO_PEDIDO (ID_Detalle_Envio, Cantidad, ID_Envio, ID_Detalle_Pedido) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 2, 3),
(4, 1, 3, 4),
(5, 1, 4, 5);

INSERT INTO VENTA_PRESENCIAL (ID_Venta, Fecha_Venta, Total_Bruto, Descuento_Aplicado, Total_Final, ID_Cliente, ID_Empleado, ID_Ubicacion) VALUES
(1, '2025-07-03 11:35:00', 89.99, 0.00, 89.99, NULL, 5, 2),
(2, '2025-07-04 18:10:00', 229.99, 20.00, 209.99, 1, 5, 2),
(3, '2025-07-06 13:25:00', 39.99, 0.00, 39.99, 2, 6, 3);

INSERT INTO DETALLE_VENTA_PRESENCIAL (ID_Detalle_Venta, Cantidad, Precio_Unitario, Descuento_Aplicado, Total_Linea, ID_Venta, ID_Producto) VALUES
(1, 1, 89.99, 0.00, 89.99, 1, 4),
(2, 1, 229.99, 20.00, 209.99, 2, 5),
(3, 1, 39.99, 0.00, 39.99, 3, 3);

INSERT INTO DEVOLUCION_PRESENCIAL (ID_Devolucion, Fecha_Devolucion, Motivo, Estado, Importe_Total_Devuelto, ID_Venta, ID_Empleado) VALUES
(1, '2025-07-05', 'Producto defectuoso', 'DEVUELTA', 89.99, 1, 5),
(2, '2025-07-07', 'Cambio de opinion del cliente', 'ACEPTADA', 39.99, 3, 6);

INSERT INTO DETALLE_DEVOLUCION_PRESENCIAL (ID_Detalle_Devolucion, Cantidad, Importe_Devuelto, ID_Devolucion, ID_Detalle_Venta) VALUES
(1, 1, 89.99, 1, 1),
(2, 1, 39.99, 2, 3);

INSERT INTO TRANSFERENCIA_STOCK (ID_Transferencia, Fecha_Transferencia, Cantidad, Estado, ID_Producto, ID_Ubicacion_Origen, ID_Ubicacion_Destino, ID_Empleado_Autoriza) VALUES
(1, '2025-07-04 09:00:00', 5, 'RECIBIDA', 1, 1, 2, 2),
(2, '2025-07-06 10:30:00', 3, 'EN_TRANSITO', 2, 1, 3, 2),
(3, '2025-07-08 08:45:00', 10, 'AUTORIZADA', 3, 1, 4, 1);

INSERT INTO TICKET_INCIDENCIA (ID_Ticket, Asunto, Descripcion, Fecha_Apertura, Estado, Fecha_Cierre, Nota_Resolucion, ID_Cliente, ID_Empleado_Agente, ID_Pedido) VALUES
(1, 'Consulta sobre envio', 'El cliente pregunta por el estado de su pedido.', '2025-07-03 09:30:00', 'RESUELTO', '2025-07-03 12:00:00', 'Se informa del numero de seguimiento.', 1, 3, 1),
(2, 'Devolucion online', 'El cliente solicita recogida de un producto recibido.', '2025-07-06 14:15:00', 'EN_GESTION', NULL, NULL, 2, 3, 2),
(3, 'Consulta general', 'Pregunta sobre disponibilidad de productos gaming.', '2025-07-09 17:40:00', 'ABIERTO', NULL, NULL, 3, 3, NULL);

INSERT INTO ENVIO_RECOGIDA (ID_Recogida, Fecha_Solicitud, Fecha_Recogida, Transportista, Numero_Seguimiento, Estado, Fecha_Estimada_Recogida, ID_Ticket, ID_Ubicacion_Destino) VALUES
(1, '2025-07-06', NULL, 'DHL', 'REC-0001', 'PROGRAMADA', '2025-07-09', 2, 1);

INSERT INTO VALORACION_PRODUCTO (ID_Valoracion, Puntuacion, Comentario, Fecha_Valoracion, Verificada, Activa, ID_Cliente, ID_Producto, ID_Pedido) VALUES
(1, 5, 'Entrega rapida y producto perfecto.', '2025-07-05', TRUE, TRUE, 1, 1, 1),
(2, 4, 'Buen rendimiento para juegos.', '2025-07-09', TRUE, TRUE, 2, 2, 2),
(3, 3, 'Valoracion historica sin pedido asociado.', '2024-12-15', FALSE, TRUE, 3, 3, NULL);

INSERT INTO MOVIMIENTO_PUNTOS (ID_Movimiento, Tipo_Movimiento, Puntos, Fecha_Movimiento, Descripcion, ID_Cliente, ID_Pedido) VALUES
(1, 'GANADO', 8800, '2025-07-02 10:20:00', 'Puntos ganados por pedido online 1', 1, 1),
(2, 'CANJEADO', 1000, '2025-07-02 10:21:00', 'Puntos canjeados en pedido online 1', 1, 1),
(3, 'GANADO', 15000, '2025-07-05 16:50:00', 'Puntos ganados por pedido online 2', 2, 2),
(4, 'CANJEADO', 500, '2025-07-08 12:25:00', 'Puntos canjeados en pedido online 3', 3, 3),
(5, 'AJUSTE', 250, '2025-07-09 09:00:00', 'Ajuste manual de fidelizacion', 1, NULL);
