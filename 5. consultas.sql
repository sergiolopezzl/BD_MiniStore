--CICLO UNO
    --CONSULTAS OPERATIVAS
    --Consultar total compras
    SELECT compras.id, COUNT(compras.id)AS cantidadVendida, SUM(DetallesCompras.cantidad) AS TotalVendido
    FROM Compras
    JOIN DetallesCompras ON compras.id = DetallesCompras.idCompra
    WHERE EXTRACT(MONTH FROM fecha) = 5 AND EXTRACT(YEAR FROM fecha) = 2023
    GROUP BY compras.id
    ORDER BY cantidadVendida DESC;

    --Consultar total compras de un empleado
    SELECT empleados.idpersonas, personas.nombre, personas.apellido, COUNT(compras.idEmpleados) AS comprasHechas
    FROM Compras
    JOIN Empleados ON compras.idEmpleados = empleados.idpersonas
    JOIN Personas ON personas.id = empleados.idpersonas
    WHERE EXTRACT(YEAR FROM compras.fecha) = 2023
    GROUP BY empleados.idpersonas, personas.nombre, personas.apellido
    ORDER BY comprasHechas DESC;


    --Consultar fecha Productos proximos a vencer
    SELECT id, nombre, fechaDeVencimiento 
    FROM Perecederos WHERE (TRUNC(fechaDeVencimiento) - TRUNC(SYSDATE)) > 0 
    ORDER BY fechaDeVencimiento;

    --Consultar productos vencidos
    SELECT id, nombre, fechaDeVencimiento 
    FROM Perecederos WHERE (TRUNC(fechaDeVencimiento) - TRUNC(SYSDATE)) < 0 
    ORDER BY fechaDeVencimiento;

    --Consultar precios del proveedor
    SELECT compras.id, SUM(comprasProveedores.precio) AS Compras, proveedores.nombre
    FROM Compras JOIN comprasproveedores ON compras.id = comprasProveedores.idCompra JOIN Proveedores ON comprasproveedores.idproveedor = proveedores.id
    WHERE EXTRACT(YEAR FROM compras.fecha) = 2023
    GROUP BY compras.id, proveedores.nombre
    ORDER BY compras.id DESC;

    
--CICLO DOS
    --CONSULTAS OPERATIVAS
    --consultar el total de compras de un cliente en el mes PARA PODER redefinir sus puntos de fidelidad
    SELECT personas.nombre, personas.apellido, COUNT(generan.idCliente) AS comprasHechas
    FROM Generan JOIN Ventas ON generan.idventa = ventas.id
    JOIN Clientes ON generan.idCliente = clientes.idpersonas
    JOIN Personas ON personas.id = clientes.idpersonas
    WHERE EXTRACT(YEAR FROM ventas.fecha) = 2023
    GROUP BY clientes.idpersonas, personas.nombre, personas.apellido
    ORDER BY comprasHechas DESC;
    --Consultar el total de ventas de un empleado en el mes para ver su rendimiento
    SELECT personas.id AS id, personas.apellido, COUNT(ventas.id) AS VentasHechas
    FROM Personas JOIN Empleados ON personas.id = Empleados.idpersonas JOIN Ventas ON ventas.idempleado = empleados.idpersonas
    GROUP BY personas.id,personas.apellido
    ORDER BY VentasHechas DESC;


    --Consultar aquellos detalles de ventas con mayor cantidad vendida para saber que tipo de productos se venden mas segun estos detalles
    SELECT id, idventa, cantidad,EXTRACTVALUE(detalle, '/descripcion/asunto/text()') AS Producto
    FROM DetallesVentas
    WHERE XMLExists('/descripcion/asunto[contains(text(), "producto")]' PASSING detalle) ORDER BY cantidad;

--CONSULTAS GERENCIALES CICLO 1 y 2

    --Consultar el inventario de los productos

    --Perecederos
    SELECT perecederos.id, perecederos.nombre, perecederos.cantidad, COUNT(detallesventas.idperecederos) AS promedioVenta
    FROM perecederos
    JOIN detallesventas ON perecederos.id = detallesventas.idperecederos
    GROUP BY perecederos.id, perecederos.cantidad, perecederos.nombre ORDER BY perecederos.cantidad;
    --NoPerecederos
    SELECT noperecederos.id, noperecederos.nombre, noperecederos.cantidad, COUNT(detallesventas.idnoperecederos) AS promedioVenta
    FROM noperecederos
    JOIN detallesventas ON noperecederos.id = detallesventas.idnoperecederos
    GROUP BY noperecederos.id, noperecederos.cantidad, noperecederos.nombre ORDER BY noperecederos.cantidad;
    --Consultar productos más vendidos

    --Perecederos
    SELECT perecederos.id, perecederos.nombre, perecederos.cantidad, COUNT(detallesventas.idperecederos) AS promedioVenta
    FROM perecederos
    JOIN detallesventas ON perecederos.id = detallesventas.idperecederos
    GROUP BY perecederos.id, perecederos.cantidad, perecederos.nombre ORDER BY promedioVenta DESC;
    --NoPerecederos
    SELECT noperecederos.id, noperecederos.nombre, noperecederos.cantidad, COUNT(detallesventas.idnoperecederos) AS promedioVenta
    FROM noperecederos
    JOIN detallesventas ON noperecederos.id = detallesventas.idnoperecederos
    GROUP BY noperecederos.id, noperecederos.cantidad, noperecederos.nombre ORDER BY promedioVenta DESC;

    --Consultar la rentabilidad del producto
    --Perecederos
    SELECT perecederos.id, perecederos.nombre, SUM(detallesventas.cantidad) - SUM(DetallesCompras.cantidad) AS Ganancia_Perdida, ROUND(SUM(detallesventas.cantidad) / SUM(DetallesCompras.cantidad), 2) TasaRentabilidad,  COUNT(detallesventas.idperecederos) AS totalVentas
    FROM DetallesCompras JOIN DetalleProductosCompras ON detallescompras.id = DetalleProductosCompras.idDetalleCompra
    JOIN perecederos ON DetalleProductosCompras.idperecederos = perecederos.id
    JOIN DetallesVentas ON DetallesVentas.idperecederos = perecederos.id
    GROUP BY perecederos.id, perecederos.nombre
    ORDER BY totalVentas DESC;

    --NoPerecederos
    SELECT noperecederos.id, noperecederos.nombre, SUM(detallesventas.cantidad) - SUM(DetallesCompras.cantidad) AS Ganancia_Perdida, ROUND(SUM(detallesventas.cantidad) / SUM(DetallesCompras.cantidad), 2) TasaRentabilidad,  COUNT(detallesventas.idnoperecederos) AS totalVentas
    FROM DetallesCompras JOIN DetalleProductosCompras ON detallescompras.id = DetalleProductosCompras.idDetalleCompra
    JOIN noperecederos ON DetalleProductosCompras.idnoperecederos = noperecederos.id
    JOIN DetallesVentas ON DetallesVentas.idnoperecederos = noperecederos.id
    GROUP BY noperecederos.id, noperecederos.nombre
    ORDER BY totalVentas DESC;

    --Consultar rendimiento de empleado
    SELECT empleados.idpersonas AS idEmpleado, personas.nombre, personas.apellido, COUNT(ventas.id) AS CantidadVentas FROM Personas JOIN Empleados ON personas.id = empleados.idpersonas JOIN Ventas ON 
    empleados.idpersonas = ventas.idempleado GROUP BY empleados.idpersonas, personas.nombre, personas.apellido
    ORDER BY CantidadVentas DESC;
    