
--INDICES
--CICLO UNO
    CREATE INDEX idx_compras_fecha ON Compras (fecha);
--CICLO DOS
    CREATE INDEX idx_ventas_fecha ON Ventas(fecha);
--VISTAS
--CICLO UNO
    --Consultar total compras
    CREATE OR REPLACE VIEW total_compras AS SELECT compras.id, compras.fecha, COUNT(compras.id)AS cantidadVendida, SUM(DetallesCompras.cantidad) AS TotalVendido
    FROM Compras
    JOIN DetallesCompras ON compras.id = DetallesCompras.idCompra
    GROUP BY compras.id, compras.fecha
    ORDER BY cantidadVendida DESC;

    --Consultar total ventas de un empleado
    CREATE OR REPLACE VIEW compras_empleados AS SELECT empleados.idpersonas, personas.nombre, personas.apellido, COUNT(compras.idEmpleados) AS comprasHechas
    FROM Compras
    JOIN Empleados ON compras.idEmpleados = empleados.idpersonas
    JOIN Personas ON personas.id = empleados.idpersonas
    WHERE EXTRACT(YEAR FROM compras.fecha) = 2023
    GROUP BY empleados.idpersonas, personas.nombre, personas.apellido
    ORDER BY comprasHechas DESC;

    -- Consultar fecha Productos proximos a vencer
    CREATE OR REPLACE VIEW vencimiento_producto AS SELECT id, nombre, fechaDeVencimiento
    FROM (SELECT id, nombre, fechaDeVencimiento FROM Perecederos WHERE (TRUNC(fechaDeVencimiento) - TRUNC(SYSDATE)) > 0 ORDER BY fechaDeVencimiento)
    WHERE ROWNUM <= 100;
    -- Consultar productos vencidos
    CREATE OR REPLACE VIEW productos_vencidos AS SELECT id, nombre, fechaDeVencimiento
    FROM Perecederos WHERE (TRUNC(fechaDeVencimiento) - TRUNC(SYSDATE)) < 0 
    ORDER BY fechaDeVencimiento;
    -- Consultar precios del proveedor
    CREATE OR REPLACE VIEW precio_proveedor AS 
    SELECT proveedores.id AS proveedor_id, compras.id AS compra_id, SUM(comprasProveedores.precio) AS total_compras, proveedores.nombre
    FROM Compras 
    JOIN comprasproveedores ON compras.id = comprasProveedores.idCompra 
    JOIN Proveedores ON comprasproveedores.idproveedor = proveedores.id
    WHERE EXTRACT(YEAR FROM compras.fecha) = 2023
    GROUP BY proveedores.id, compras.id, proveedores.nombre
    ORDER BY compras.id DESC;
--CICLO DOS
    --Consultar total compras del cliente
    CREATE OR REPLACE VIEW total_compras_cliente AS 
    SELECT clientes.idpersonas AS id, personas.nombre, personas.apellido, ventas.fecha,  COUNT(generan.idCliente) AS comprasHechas
    FROM Generan JOIN Ventas ON generan.idventa = ventas.id
    JOIN Clientes ON generan.idCliente = clientes.idpersonas
    JOIN Personas ON personas.id = clientes.idpersonas
    GROUP BY clientes.idpersonas, personas.nombre, personas.apellido, ventas.fecha
    ORDER BY comprasHechas DESC;

    CREATE OR REPLACE VIEW total_ventas_empleado AS
    SELECT personas.id AS id, personas.nombre, personas.apellido, COUNT(ventas.id) AS VentasHechas
    FROM Personas JOIN Empleados ON personas.id = Empleados.idpersonas JOIN Ventas ON ventas.idempleado = empleados.idpersonas
    GROUP BY personas.id, personas.nombre, personas.apellido
    ORDER BY VentasHechas DESC;
    --Consultar aquellos detalles de ventas con mayor cantidad vendida para saber que tipo de productos se venden mas segun estos detalles

    CREATE OR REPLACE VIEW detalle_ventas AS SELECT id, idventa, cantidad,EXTRACTVALUE(detalle, '/descripcion/asunto/text()') AS Producto
    FROM DetallesVentas
    WHERE XMLExists('/descripcion/asunto[contains(text(), "producto")]' PASSING detalle) ORDER BY cantidad DESC;

--VISTAS GERENCIALES CICLO 1 y 2
    --Consultar el inventario de los productos
    --Perecederos
    CREATE OR REPLACE VIEW inventario_perecedero AS
    SELECT perecederos.id, perecederos.nombre, perecederos.cantidad, COUNT(detallesventas.idperecederos) AS promedioVenta
    FROM perecederos
    JOIN detallesventas ON perecederos.id = detallesventas.idperecederos
    GROUP BY perecederos.id, perecederos.cantidad, perecederos.nombre ORDER BY perecederos.cantidad;

    --NoPerecederos
    CREATE OR REPLACE VIEW inventario_noperecedero AS
    SELECT noperecederos.id, noperecederos.nombre, noperecederos.cantidad, COUNT(detallesventas.idnoperecederos) AS promedioVenta
    FROM noperecederos
    JOIN detallesventas ON noperecederos.id = detallesventas.idnoperecederos
    GROUP BY noperecederos.id, noperecederos.cantidad, noperecederos.nombre ORDER BY noperecederos.cantidad;

    --Consultar productos más vendidos
    --Perecederos

    CREATE OR REPLACE VIEW perecederos_mas_vendidos AS
    SELECT perecederos.id, perecederos.nombre, perecederos.cantidad, COUNT(detallesventas.idperecederos) AS promedioVenta
    FROM perecederos
    JOIN detallesventas ON perecederos.id = detallesventas.idperecederos
    GROUP BY perecederos.id, perecederos.cantidad, perecederos.nombre ORDER BY promedioVenta DESC;

    --NoPerecederos
    CREATE OR REPLACE VIEW noperecederos_mas_vendido AS
    SELECT noperecederos.id, noperecederos.nombre, noperecederos.cantidad, COUNT(detallesventas.idnoperecederos) AS promedioVenta
    FROM noperecederos
    JOIN detallesventas ON noperecederos.id = detallesventas.idnoperecederos
    GROUP BY noperecederos.id, noperecederos.cantidad, noperecederos.nombre ORDER BY promedioVenta DESC;

    --Consultar rentabilidad del producto
    --Perecederos
    CREATE OR REPLACE VIEW perecederos_rentabilidad AS
    SELECT perecederos.id, perecederos.nombre, SUM(perecederos.precio) - SUM(Comprasproveedores.precio) AS Ganancia_Perdida, ROUND(SUM(detallesventas.cantidad) / SUM(DetallesCompras.cantidad), 2) TasaRentabilidad,  COUNT(detallesventas.idperecederos) AS totalVentas
    FROM DetallesCompras JOIN DetalleProductosCompras ON detallescompras.id = DetalleProductosCompras.idDetalleCompra
    JOIN perecederos ON DetalleProductosCompras.idperecederos = perecederos.id
    JOIN Proveedores ON perecederos.idproveedor = Proveedores.id 
    JOIN ComprasProveedores ON proveedores.id = comprasProveedores.idproveedor
    JOIN DetallesVentas ON DetallesVentas.idperecederos = perecederos.id
    GROUP BY perecederos.id, perecederos.nombre
    ORDER BY totalVentas DESC;

    --NoPerecederos
    CREATE OR REPLACE VIEW noperecederos_rentabilidad AS
    SELECT noperecederos.id, noperecederos.nombre, SUM(noperecederos.precio) - SUM(Comprasproveedores.precio) AS Ganancia_Perdida, ROUND(SUM(detallesventas.cantidad) / SUM(DetallesCompras.cantidad), 2) TasaRentabilidad,  COUNT(detallesventas.idnoperecederos) AS totalVentas
    FROM DetallesCompras JOIN DetalleProductosCompras ON detallescompras.id = DetalleProductosCompras.idDetalleCompra
    JOIN noperecederos ON DetalleProductosCompras.idnoperecederos = noperecederos.id
    JOIN Proveedores ON noperecederos.idproveedor = Proveedores.id 
    JOIN ComprasProveedores ON proveedores.id = comprasProveedores.idproveedor
    JOIN DetallesVentas ON DetallesVentas.idnoperecederos = noperecederos.id
    GROUP BY noperecederos.id, noperecederos.nombre
    ORDER BY totalVentas DESC;

    --Consultar rendimiento de empleado
    CREATE OR REPLACE VIEW rendimiento_empleado AS
    SELECT empleados.idpersonas AS idEmpleado, personas.nombre, personas.apellido, COUNT(ventas.id) AS CantidadVentas FROM Personas JOIN Empleados ON personas.id = empleados.idpersonas JOIN Ventas ON 
    empleados.idpersonas = ventas.idempleado GROUP BY empleados.idpersonas, personas.nombre, personas.apellido
    ORDER BY CantidadVentas DESC;

--IndicesVistasOk
--CICLO UNO
    --Ver las primeras dias compras con mayor monto del mes
    SELECT * FROM total_compras WHERE WHERE EXTRACT(MONTH FROM fecha) = 5 AND EXTRACT(YEAR FROM fecha) = 2023 AND ROWNUM <= 10;
    --Ver los 3 mejores empleados y la cantidad de ventas Hechas
    SELECT nombre, apellido, comprasHechas FROM ventas_empleados ORDER BY comprasHechas DESC FETCH FIRST 3 ROWS ONLY;
    -- Ver el nombre de los 5 productos mas prontos a vencer y los que ya estan vencidos, y ver los dias que restan para que se dañe
    SELECT id, nombre, fechaDeVencimiento, TRUNC(fechaDeVencimiento) - TRUNC(SYSDATE) AS diasRestantes FROM vencimiento_producto WHERE ROWNUM <= 20 ORDER BY diasRestantes ASC;
    -- Ver el nombre de los productos vencidos
    SELECT * FROM productos_vencidos;
    --Consultar los 10 proveedores con los precios mas bajos
    SELECT * FROM precio_proveedor WHERE ROWNUM <= 10 ORDER BY total_compras ASC;
--CICLO 2
    --Consultar los diez clientes con mas compras
    SELECT * FROM total_compras_cliente WHERE EXTRACT(YEAR FROM fecha) = 2023 AND ROWNUM <= 10;
    --Consultar los diez empleados con mas ventas
    SELECT * FROM total_ventas_empleado WHERE ROWNUM <= 10;
    --Consultar el detalle de los combos más elegidos y vendidos de productos
    SELECT * FROM detalle_ventas WHERE ROWNUM <= 10;
--GERENCIALES
    --Consultar los 10 productos con menor cantidad de inventario
    SELECT * FROM inventario_perecedero WHERE ROWNUM <= 10;
    --Consultar los 10 productos con menor cantidad de inventario
    SELECT * FROM inventario_noperecedero WHERE ROWNUM <= 10;
    --Consultar los 10 productos más vendidos
    SELECT * FROM perecederos_mas_vendidos WHERE ROWNUM <= 10;
    --Consultar los 10 productos más vendidos
    SELECT * FROM noperecederos_mas_vendido WHERE ROWNUM <= 10;
    --Consultar los 10 productos más vendidos y ver su rentabilidad
    SELECT * FROM perecederos_rentabilidad WHERE ROWNUM <= 10;
    --Consultar los 10 productos más vendidos y ver su rentabilidad
    SELECT * FROM noperecederos_rentabilidad WHERE ROWNUM <= 10;
    --Consultar los 10 empleados con mayor cantidad de ventas
    SELECT * FROM rendimiento_empleado WHERE ROWNUM <= 10;

/*
--XIndices
DROP INDEX idx_compras_fecha;
DROP INDEX idx_ventas_fecha;

--XVistas
DROP VIEW total_compras;
DROP VIEW compras_empleados;
DROP VIEW vencimiento_producto;
DROP VIEW precio_proveedor;
DROP VIEW total_compras_cliente;
DROP VIEW total_ventas_empleado;
DROP VIEW inventario_perecedero;
DROP VIEW inventario_noperecedero;
DROP VIEW perecederos_mas_vendidos;
DROP VIEW noperecederos_mas_vendido;
DROP VIEW perecederos_rentabilidad;
DROP VIEW noperecederos_rentabilidad;
DROP VIEW rendimiento_empleado;
DROP VIEW detalle_ventas;
DROP VIEW productos_vencidos;
*/