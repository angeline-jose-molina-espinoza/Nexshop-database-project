DROP DATABASE IF EXISTS nexshop_db;
CREATE DATABASE nexshop_db;
USE nexshop_db;

CREATE TABLE CATEGORIA (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255),
    ID_Categoria_Padre INT NULL,
    CONSTRAINT fk_Categoria_Padre
        FOREIGN KEY (ID_Categoria_Padre) REFERENCES CATEGORIA(ID_Categoria)
);

CREATE TABLE UBICACION (
    ID_Ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Tipo ENUM('TIENDA', 'ALMACEN_CENTRAL') NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Activa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE CLIENTE (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Contrasena VARCHAR(255) NOT NULL,
    Fecha_Nacimiento DATE NULL,
    Fecha_Registro DATE NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE DIRECCION_CLIENTE (
    ID_Direccion INT AUTO_INCREMENT PRIMARY KEY,
    Calle VARCHAR(150) NOT NULL,
    Numero VARCHAR(20) NOT NULL,
    Piso VARCHAR(20),
    Codigo_Postal VARCHAR(15) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Pais VARCHAR(100) NOT NULL,
    Tipo_Direccion ENUM('DOMICILIO', 'TRABAJO', 'OTRA') NOT NULL,
    ID_Cliente INT NOT NULL,
    CONSTRAINT fk_Direccion_Cliente
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
);

CREATE TABLE PRODUCTO (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    Marca VARCHAR(100),
    Descripcion VARCHAR(255),
    SKU VARCHAR(50) NOT NULL UNIQUE,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    ID_Categoria INT NOT NULL,
    CONSTRAINT fk_Producto_Categoria
        FOREIGN KEY (ID_Categoria) REFERENCES CATEGORIA(ID_Categoria)
);

CREATE TABLE HISTORIAL_PRECIO_PRODUCTO (
    ID_Historial_Precio INT AUTO_INCREMENT PRIMARY KEY,
    PVP DECIMAL(10,2) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NULL,
    ID_Producto INT NOT NULL,
    CONSTRAINT chk_Historial_PVP CHECK (PVP >= 0),
    CONSTRAINT fk_Historial_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto)
);

CREATE TABLE PROMOCION (
    ID_Promocion INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255),
    Porcentaje_Descuento DECIMAL(5,2) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Activa BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_Promocion_Descuento CHECK (Porcentaje_Descuento BETWEEN 0 AND 100),
    CONSTRAINT chk_Promocion_Fechas CHECK (Fecha_Fin >= Fecha_Inicio)
);

CREATE TABLE PROMOCION_PRODUCTO (
    ID_Promocion_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Inicio_Aplicacion DATE NOT NULL,
    Fecha_Fin_Aplicacion DATE NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    ID_Promocion INT NOT NULL,
    ID_Producto INT NOT NULL,
    CONSTRAINT uq_Promocion_Producto UNIQUE (ID_Promocion, ID_Producto),
    CONSTRAINT fk_PromocionProducto_Promocion
        FOREIGN KEY (ID_Promocion) REFERENCES PROMOCION(ID_Promocion),
    CONSTRAINT fk_PromocionProducto_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto)
);

CREATE TABLE EMPLEADO (
    ID_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(150) NOT NULL,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Email_Corporativo VARCHAR(150) NOT NULL UNIQUE,
    Fecha_Incorporacion DATE NOT NULL,
    Puesto VARCHAR(100) NOT NULL,
    ID_Ubicacion INT NOT NULL,
    CONSTRAINT fk_Empleado_Ubicacion
        FOREIGN KEY (ID_Ubicacion) REFERENCES UBICACION(ID_Ubicacion)
);

CREATE TABLE PROVEEDOR (
    ID_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(150) NOT NULL,
    CIF VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(150) NOT NULL,
    Telefono VARCHAR(30),
    Direccion VARCHAR(255),
    Ciudad VARCHAR(100),
    Pais VARCHAR(100),
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    ID_Empleado_Representante INT NOT NULL,
    CONSTRAINT fk_Proveedor_Empleado
        FOREIGN KEY (ID_Empleado_Representante) REFERENCES EMPLEADO(ID_Empleado)
);

CREATE TABLE CONDICION_PROVEEDOR_PRODUCTO (
    ID_Condicion INT AUTO_INCREMENT PRIMARY KEY,
    Precio_Coste DECIMAL(10,2) NOT NULL,
    Plazo_Entrega_Dias INT NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NULL,
    ID_Proveedor INT NOT NULL,
    ID_Producto INT NOT NULL,
    CONSTRAINT chk_Condicion_Precio CHECK (Precio_Coste >= 0),
    CONSTRAINT chk_Condicion_Plazo CHECK (Plazo_Entrega_Dias >= 0),
    CONSTRAINT fk_Condicion_Proveedor
        FOREIGN KEY (ID_Proveedor) REFERENCES PROVEEDOR(ID_Proveedor),
    CONSTRAINT fk_Condicion_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto)
);

CREATE TABLE STOCK_UBICACION (
    ID_Stock INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad_Actual INT NOT NULL,
    Stock_Minimo INT NOT NULL DEFAULT 0,
    Stock_Maximo INT,
    Fecha_Actualizacion DATETIME NOT NULL,
    ID_Producto INT NOT NULL,
    ID_Ubicacion INT NOT NULL,
    CONSTRAINT uq_Stock_Producto_Ubicacion UNIQUE (ID_Producto, ID_Ubicacion),
    CONSTRAINT chk_Stock_Cantidad CHECK (Cantidad_Actual >= 0),
    CONSTRAINT chk_Stock_Minimo CHECK (Stock_Minimo >= 0),
    CONSTRAINT fk_Stock_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto),
    CONSTRAINT fk_Stock_Ubicacion
        FOREIGN KEY (ID_Ubicacion) REFERENCES UBICACION(ID_Ubicacion)
);

CREATE TABLE PEDIDO_ONLINE (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Pedido DATETIME NOT NULL,
    Estado ENUM('PENDIENTE', 'EN_PREPARACION', 'ENVIADO', 'ENTREGADO', 'CANCELADO') NOT NULL,
    Total_Bruto DECIMAL(10,2) NOT NULL,
    Puntos_Canjeados INT NOT NULL DEFAULT 0,
    Descuento_Puntos DECIMAL(10,2) NOT NULL DEFAULT 0,
    Total_Final DECIMAL(10,2) NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Direccion_Envio INT NOT NULL,
    CONSTRAINT chk_Pedido_Totales CHECK (Total_Bruto >= 0 AND Descuento_Puntos >= 0 AND Total_Final >= 0),
    CONSTRAINT chk_Pedido_Puntos CHECK (Puntos_Canjeados >= 0),
    CONSTRAINT fk_Pedido_Cliente
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    CONSTRAINT fk_Pedido_Direccion
        FOREIGN KEY (ID_Direccion_Envio) REFERENCES DIRECCION_CLIENTE(ID_Direccion)
);

CREATE TABLE DETALLE_PEDIDO_ONLINE (
    ID_Detalle_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    Descuento_Aplicado DECIMAL(10,2) NOT NULL DEFAULT 0,
    Total_Linea DECIMAL(10,2) NOT NULL,
    ID_Pedido INT NOT NULL,
    ID_Producto INT NOT NULL,
    CONSTRAINT chk_DetallePedido_Valores CHECK (Cantidad > 0 AND Precio_Unitario >= 0 AND Descuento_Aplicado >= 0 AND Total_Linea >= 0),
    CONSTRAINT fk_DetallePedido_Pedido
        FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO_ONLINE(ID_Pedido),
    CONSTRAINT fk_DetallePedido_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto)
);

CREATE TABLE ENVIO_PEDIDO (
    ID_Envio INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Seguimiento VARCHAR(100) NOT NULL UNIQUE,
    Transportista VARCHAR(100) NOT NULL,
    Fecha_Envio DATE,
    Fecha_Estimada_Entrega DATE NOT NULL,
    Fecha_Entrega_Real DATE NULL,
    Estado ENUM('PREPARANDO', 'ENVIADO', 'ENTREGADO', 'INCIDENCIA', 'CANCELADO') NOT NULL,
    ID_Pedido INT NOT NULL,
    ID_Ubicacion_Origen INT NOT NULL,
    CONSTRAINT fk_Envio_Pedido
        FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO_ONLINE(ID_Pedido),
    CONSTRAINT fk_Envio_Ubicacion
        FOREIGN KEY (ID_Ubicacion_Origen) REFERENCES UBICACION(ID_Ubicacion)
);

CREATE TABLE DETALLE_ENVIO_PEDIDO (
    ID_Detalle_Envio INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    ID_Envio INT NOT NULL,
    ID_Detalle_Pedido INT NOT NULL,
    CONSTRAINT chk_DetalleEnvio_Cantidad CHECK (Cantidad > 0),
    CONSTRAINT fk_DetalleEnvio_Envio
        FOREIGN KEY (ID_Envio) REFERENCES ENVIO_PEDIDO(ID_Envio),
    CONSTRAINT fk_DetalleEnvio_DetallePedido
        FOREIGN KEY (ID_Detalle_Pedido) REFERENCES DETALLE_PEDIDO_ONLINE(ID_Detalle_Pedido)
);

CREATE TABLE VENTA_PRESENCIAL (
    ID_Venta INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Venta DATETIME NOT NULL,
    Total_Bruto DECIMAL(10,2) NOT NULL,
    Descuento_Aplicado DECIMAL(10,2) NOT NULL DEFAULT 0,
    Total_Final DECIMAL(10,2) NOT NULL,
    ID_Cliente INT NULL,
    ID_Empleado INT NOT NULL,
    ID_Ubicacion INT NOT NULL,
    CONSTRAINT chk_Venta_Totales CHECK (Total_Bruto >= 0 AND Descuento_Aplicado >= 0 AND Total_Final >= 0),
    CONSTRAINT fk_Venta_Cliente
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    CONSTRAINT fk_Venta_Empleado
        FOREIGN KEY (ID_Empleado) REFERENCES EMPLEADO(ID_Empleado),
    CONSTRAINT fk_Venta_Ubicacion
        FOREIGN KEY (ID_Ubicacion) REFERENCES UBICACION(ID_Ubicacion)
);

CREATE TABLE DETALLE_VENTA_PRESENCIAL (
    ID_Detalle_Venta INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    Descuento_Aplicado DECIMAL(10,2) NOT NULL DEFAULT 0,
    Total_Linea DECIMAL(10,2) NOT NULL,
    ID_Venta INT NOT NULL,
    ID_Producto INT NOT NULL,
    CONSTRAINT chk_DetalleVenta_Valores CHECK (Cantidad > 0 AND Precio_Unitario >= 0 AND Descuento_Aplicado >= 0 AND Total_Linea >= 0),
    CONSTRAINT fk_DetalleVenta_Venta
        FOREIGN KEY (ID_Venta) REFERENCES VENTA_PRESENCIAL(ID_Venta),
    CONSTRAINT fk_DetalleVenta_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto)
);

CREATE TABLE DEVOLUCION_PRESENCIAL (
    ID_Devolucion INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Devolucion DATE NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    Estado ENUM('SOLICITADA', 'ACEPTADA', 'RECHAZADA', 'DEVUELTA') NOT NULL,
    Importe_Total_Devuelto DECIMAL(10,2) NOT NULL,
    ID_Venta INT NOT NULL,
    ID_Empleado INT NOT NULL,
    CONSTRAINT chk_Devolucion_Importe CHECK (Importe_Total_Devuelto >= 0),
    CONSTRAINT fk_Devolucion_Venta
        FOREIGN KEY (ID_Venta) REFERENCES VENTA_PRESENCIAL(ID_Venta),
    CONSTRAINT fk_Devolucion_Empleado
        FOREIGN KEY (ID_Empleado) REFERENCES EMPLEADO(ID_Empleado)
);

CREATE TABLE DETALLE_DEVOLUCION_PRESENCIAL (
    ID_Detalle_Devolucion INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL,
    Importe_Devuelto DECIMAL(10,2) NOT NULL,
    ID_Devolucion INT NOT NULL,
    ID_Detalle_Venta INT NOT NULL,
    CONSTRAINT chk_DetalleDevolucion_Valores CHECK (Cantidad > 0 AND Importe_Devuelto >= 0),
    CONSTRAINT fk_DetalleDevolucion_Devolucion
        FOREIGN KEY (ID_Devolucion) REFERENCES DEVOLUCION_PRESENCIAL(ID_Devolucion),
    CONSTRAINT fk_DetalleDevolucion_DetalleVenta
        FOREIGN KEY (ID_Detalle_Venta) REFERENCES DETALLE_VENTA_PRESENCIAL(ID_Detalle_Venta)
);

CREATE TABLE TRANSFERENCIA_STOCK (
    ID_Transferencia INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Transferencia DATETIME NOT NULL,
    Cantidad INT NOT NULL,
    Estado ENUM('SOLICITADA', 'AUTORIZADA', 'EN_TRANSITO', 'RECIBIDA', 'CANCELADA') NOT NULL,
    ID_Producto INT NOT NULL,
    ID_Ubicacion_Origen INT NOT NULL,
    ID_Ubicacion_Destino INT NOT NULL,
    ID_Empleado_Autoriza INT NOT NULL,
    CONSTRAINT chk_Transferencia_Cantidad CHECK (Cantidad > 0),
    CONSTRAINT chk_Transferencia_Ubicaciones CHECK (ID_Ubicacion_Origen <> ID_Ubicacion_Destino),
    CONSTRAINT fk_Transferencia_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto),
    CONSTRAINT fk_Transferencia_Origen
        FOREIGN KEY (ID_Ubicacion_Origen) REFERENCES UBICACION(ID_Ubicacion),
    CONSTRAINT fk_Transferencia_Destino
        FOREIGN KEY (ID_Ubicacion_Destino) REFERENCES UBICACION(ID_Ubicacion),
    CONSTRAINT fk_Transferencia_Empleado
        FOREIGN KEY (ID_Empleado_Autoriza) REFERENCES EMPLEADO(ID_Empleado)
);

CREATE TABLE TICKET_INCIDENCIA (
    ID_Ticket INT AUTO_INCREMENT PRIMARY KEY,
    Asunto VARCHAR(150) NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha_Apertura DATETIME NOT NULL,
    Estado ENUM('ABIERTO', 'EN_GESTION', 'RESUELTO') NOT NULL,
    Fecha_Cierre DATETIME NULL,
    Nota_Resolucion TEXT NULL,
    ID_Cliente INT NOT NULL,
    ID_Empleado_Agente INT NOT NULL,
    ID_Pedido INT NULL,
    CONSTRAINT fk_Ticket_Cliente
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    CONSTRAINT fk_Ticket_Empleado
        FOREIGN KEY (ID_Empleado_Agente) REFERENCES EMPLEADO(ID_Empleado),
    CONSTRAINT fk_Ticket_Pedido
        FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO_ONLINE(ID_Pedido)
);

CREATE TABLE ENVIO_RECOGIDA (
    ID_Recogida INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Solicitud DATE NOT NULL,
    Fecha_Recogida DATE NULL,
    Transportista VARCHAR(100) NOT NULL,
    Numero_Seguimiento VARCHAR(100) NOT NULL UNIQUE,
    Estado ENUM('SOLICITADA', 'PROGRAMADA', 'RECOGIDA', 'RECIBIDA', 'CANCELADA') NOT NULL,
    Fecha_Estimada_Recogida DATE NOT NULL,
    ID_Ticket INT NOT NULL,
    ID_Ubicacion_Destino INT NOT NULL,
    CONSTRAINT fk_Recogida_Ticket
        FOREIGN KEY (ID_Ticket) REFERENCES TICKET_INCIDENCIA(ID_Ticket),
    CONSTRAINT fk_Recogida_Ubicacion
        FOREIGN KEY (ID_Ubicacion_Destino) REFERENCES UBICACION(ID_Ubicacion)
);

CREATE TABLE VALORACION_PRODUCTO (
    ID_Valoracion INT AUTO_INCREMENT PRIMARY KEY,
    Puntuacion INT NOT NULL,
    Comentario TEXT,
    Fecha_Valoracion DATE NOT NULL,
    Verificada BOOLEAN NOT NULL DEFAULT FALSE,
    Activa BOOLEAN NOT NULL DEFAULT TRUE,
    ID_Cliente INT NOT NULL,
    ID_Producto INT NOT NULL,
    ID_Pedido INT NULL,
    CONSTRAINT uq_Valoracion_Cliente_Producto UNIQUE (ID_Cliente, ID_Producto),
    CONSTRAINT chk_Valoracion_Puntuacion CHECK (Puntuacion BETWEEN 1 AND 5),
    CONSTRAINT fk_Valoracion_Cliente
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    CONSTRAINT fk_Valoracion_Producto
        FOREIGN KEY (ID_Producto) REFERENCES PRODUCTO(ID_Producto),
    CONSTRAINT fk_Valoracion_Pedido
        FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO_ONLINE(ID_Pedido)
);

CREATE TABLE MOVIMIENTO_PUNTOS (
    ID_Movimiento INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Movimiento ENUM('GANADO', 'CANJEADO', 'AJUSTE') NOT NULL,
    Puntos INT NOT NULL,
    Fecha_Movimiento DATETIME NOT NULL,
    Descripcion VARCHAR(255),
    ID_Cliente INT NOT NULL,
    ID_Pedido INT NULL,
    CONSTRAINT chk_Movimiento_Puntos CHECK (Puntos > 0),
    CONSTRAINT fk_Movimiento_Cliente
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente),
    CONSTRAINT fk_Movimiento_Pedido
        FOREIGN KEY (ID_Pedido) REFERENCES PEDIDO_ONLINE(ID_Pedido)
);
SHOW DATABASES;
USE nexshop_db;
SHOW TABLES;
DESCRIBE CLIENTE;
USE nexshop_db;
DESCRIBE CLIENTE;
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'nexshop_db'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
USE nexshop_db;
SHOW TABLES;
SELECT COUNT(*) AS total_tablas
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'nexshop_db';
