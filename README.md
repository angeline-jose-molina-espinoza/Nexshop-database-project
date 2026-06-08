# NexShop Database Project

Proyecto de base de datos para NexShop Group S.A. El trabajo parte del enunciado de negocio y lo transforma en un modelo entidad-relación, un modelo relacional y una implementación SQL preparada para MySQL Workbench.

La base de datos recoge la parte online y presencial de NexShop: clientes, direcciones, pedidos, ventas, envíos, devoluciones, catálogo, categorías, proveedores, stock, promociones, valoraciones, incidencias y puntos de fidelización.

## Contenido del repositorio

```text
Nexshop-database-project/
|-- consultas/
|   `-- consultas.sql
|-- docs/
|   |-- diagrama_er.png
|   |-- modelo_relacional.png
|   |-- memoria_nexshop.docx
|   `-- memoria_nexshop.pdf
|-- sql/
|   |-- schema.sql
|   `-- datos.sql
`-- README.md
```

## Archivos principales

- `docs/diagrama_er.png`: modelo entidad-relación con entidades, atributos, claves y relaciones.
- `docs/modelo_relacional.png`: modelo relacional final con tablas, PK, FK y cardinalidades.
- `docs/memoria_nexshop.docx`: memoria del proyecto en formato Word.
- `docs/memoria_nexshop.pdf`: memoria del proyecto en formato PDF.
- `sql/schema.sql`: script de creación de la base de datos y de sus tablas.
- `sql/datos.sql`: datos de prueba para comprobar el funcionamiento del modelo.
- `consultas/consultas.sql`: consultas MySQL solicitadas en la guía, más consultas extra de comprobación.

## Cómo ejecutar el proyecto

Abrir MySQL Workbench y ejecutar los scripts en este orden:

1. `sql/schema.sql`

   Crea la base de datos `nexshop_db` y las 25 tablas del modelo. El script empieza eliminando la base de datos si ya existe, para poder repetir la ejecución desde cero.

2. `sql/datos.sql`

   Inserta registros de prueba en las tablas. Estos datos sirven para probar pedidos online, ventas presenciales, stock, proveedores, devoluciones, valoraciones, tickets y movimientos de puntos.

3. `consultas/consultas.sql`

   Ejecuta las consultas de comprobación. Incluye las 14 consultas obligatorias y un bloque final con consultas adicionales: LEFT JOIN, agregaciones, subconsulta, vista y saldo de puntos.

## Comprobaciones incluidas

El proyecto permite revisar, entre otras cosas:

- creación completa del esquema `nexshop_db`;
- carga de datos de prueba;
- consulta de clientes, productos, pedidos y ventas;
- filtrados con `WHERE`, `LIKE` y `BETWEEN`;
- ordenaciones con `ORDER BY`;
- actualizaciones con `UPDATE`;
- consultas con `JOIN`;
- revisión de relaciones y claves foráneas;
- consultas avanzadas para reforzar la comprobación del modelo.

## Notas de diseño

El modelo separa los pedidos online de las ventas presenciales porque representan procesos distintos. Los pedidos online tienen dirección de envío y pueden generar envíos, mientras que las ventas presenciales se registran en una tienda, con empleado y cliente opcional.

También se separan precios históricos, promociones y condiciones de proveedor para no mezclar conceptos diferentes: el PVP base del producto, los descuentos temporales y el precio de coste negociado con cada proveedor.

## Autora

Angeline José Molina Espinoza

Mini Proyecto Avanzado - Base de Datos | NexShop Group S.A.
