--Prueba 1 Cristian Alvarez
--CRUD Persona, CRUD Ventas, consulta en productos y en compras.
--Quiero ingresar dos nuevas personas (empleados) que contrate el martes dice que uno es bueno en el area de ventas 
--y otro maneja muy bien los inventarios y las compras, esperemos que sea asi. Julian Monsalve manejará las ventas, Julio Torres manjerá las compras
--Se ingresan al sistema
    BEGIN
        PC_Personas.adicionar_persona(10000000, 'Julian', 'Monsalve', 3150036654, 'Cra 34 # 45-25 sur', '14/05/1985');
        PC_Personas.adicionar_persona(10000000, 'Julio', 'Torres', 3114006654, 'Cra 34 # 45-25 sur', '30/12/2001');
    END;
    /
    SELECT * FROM Personas WHERE id BETWEEN 10000199 AND 10000202;

--Se ingresan como empleados
    BEGIN
        PC_Personas.adicionar_empleado(10000200, 150, 1, 'Ventas');
        PC_Personas.adicionar_empleado(10000201, 150, 1, 'Compras');
    END;
    /
    SELECT * FROM Empleados WHERE idpersonas BETWEEN 10000199 AND 10000201;
--Julian me ha informado por correo electronico que su nombre quedó mal digitado, es Monsalvo en vez de Monsalve y su año de nacimiento es en 1986, debo corregirlo 
--Julio me informó que su dirección estaba mal, vive en la carrera 7 con calle 22.
    SELECT * FROM Personas WHERE id BETWEEN 10000200 AND 10000201;
    BEGIN
        PC_Personas.modificar_persona(10000200, 'Julian', 'Monsalvo', 3154636654, 'Cra 34 # 45-25 sur', '14/05/1986');
        PC_Personas.modificar_persona(10000201, 'Julio', 'Torres', 3114636654, 'Cra 7 # calle 22', '30/12/2000');
    END;
    /
    SELECT * FROM Personas WHERE id BETWEEN 10000200 AND 10000201;
--Julian se pone manos a la obra y comienza a vender productos a diestra y siniestra
    BEGIN
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '13/08/2017');
        PC_Ventas.adicionar_ventas('V1000', '10000200', '30/05/2023');
    END;
    /

    SELECT * FROM Ventas WHERE idempleado = 10000200;
    BEGIN
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1101', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1102', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1103', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1104', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1105', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1106', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1107', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);                                                      
    END;
    /
    SELECT * FROM DetallesVentas WHERE id BETWEEN 'V1101' AND 'V1107';  
--Es necesario corregir algunas inserciones de detalles ventas ya que por nuevo se equivoco varias veces.
    BEGIN
        PC_Ventas.modificar_detalles_ventas('V1101', XMLType('<descripcion>
                    <asunto>Venta de productos deportivos</asunto>
                    <texto>Se vendieron diferentes artículos deportivos y equipos.</texto>
                    <telefono>3156789015</telefono>
                    <correo>ventas@deportes.com</correo>
                    <direccion>Calle Central, Bogotá</direccion>
                 </descripcion>') , 200);
        PC_Ventas.modificar_detalles_ventas('V1104', XMLType('<descripcion>
                    <asunto>Venta de verduras orgánicas</asunto>
                    <texto>Se vendieron verduras orgánicas frescas de agricultores locales.</texto>
                    <telefono>3145678906</telefono>
                    <correo>ventas@verdurasorganicas.com</correo>
                    <direccion>Carrera Principal, Bogotá</direccion>
                 </descripcion>'), 187);
        PC_Ventas.modificar_detalles_ventas('V1105', XMLType('<descripcion>
                    <asunto>Venta de productos para mascotas</asunto>
                    <texto>Se vendieron productos para el cuidado y alimentación de mascotas.</texto>
                    <telefono>3156789016</telefono>
                    <correo>ventas@mascotas.com</correo>
                    <direccion>Calle Central, Bogotá</direccion>
                 </descripcion>'), 100);
        PC_Ventas.modificar_detalles_ventas('V1107', XMLType('<descripcion>
                    <asunto>Venta de productos de tecnología</asunto>
                    <texto>Se vendieron productos de tecnología como dispositivos móviles y accesorios.</texto>
                    <telefono>3187654327</telefono>
                    <correo>ventas@tecnologia.com</correo>
                    <direccion>Av. Central, Bogotá</direccion>
                 </descripcion>') , 150);                                  
    END;
    /
    SELECT * FROM DetallesVentas WHERE id BETWEEN 'V1101' AND 'V1107';
--Se elimina una venta que se registro con una fecha erronea
    SELECT * FROM Ventas WHERE idempleado = 10000200;
    BEGIN
        PC_Ventas.eliminar_ventas('V1109');
    END;
    /
    SELECT * FROM Ventas WHERE idempleado = 10000200;    

--Julian sugiere hacer una busqueda de cuales entre los detalles de ventas cuales son los productos que mas suelen venderse, le pido que me reporte solo los primeros cinco
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Consultar aquellos detalles de ventas con mayor cantidad vendida para saber que tipo de productos se venden mas segun estos detalles
        v_cursor := PC_Ventas.obtenerDetalleVentaProducto(5);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /

--En base a esto Julian sugiere hacer mas compras de productos orgánicos, ya que son los que más se venden

--Quiero verificar cuantas ventas a generado mi nuevo empleado para ver si se gana un aumento.
    SET SERVEROUTPUT ON;
    DECLARE
        v_ventas NUMBER;
    BEGIN
        v_ventas := PC_Ventas.obtenerVentasTotalEmpleado(10000200); 
        DBMS_OUTPUT.PUT_LINE('Las ventas del empleado con código 10000200 son: ' || v_ventas);
    END;
    /

-- como veo que ya alcanzó las 10 ventas, procedo a ascenderlo y verifico que se le haya asignado correctamente el nuevo salario.
    BEGIN
        PC_Personas.modificar_empleado_ascenso(10000200);
    END;
    /
    SELECT * FROM Empleados WHERE idpersonas = 10000200;
--Quiero verificar los productos proxmos a vencer para solicitarle a mi empleado de Compras que haga las compras correspondientes
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el inventario de los productos perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Productos.obtenerProximos_aVencer(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /

--Aparte quiero ver los productos vencidos para ver  como ha manejado el inventario mi otro empleado, hago la consulta de cuantos productos se nos han vencido
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el inventario de los productos vencidos
        v_cursor := PC_Productos.obtenerVencidos();
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /


-- como veo que son varios productos ya vencidos, concretamente 8, veo que no es apto para el trabajo por lo cual lo muevo al area de ventas a ayudar a Julian. 

    SELECT * FROM EMPLEADOS WHERE idpersonas = 10000201;
    BEGIN
        PC_Personas.modificarDepartamento(10000201, 'Ventas');
    END;
    /
    SELECT * FROM EMPLEADOS WHERE idpersonas = 10000201;


--Registra nuevas ventas pero todas con la fecha mal y no genero detalle de ventas, las ventas son eliminadas. 
    BEGIN
        PC_Ventas.adicionar_ventas('V1000', '10000201', '13/08/2017');
        PC_Ventas.adicionar_ventas('V1000', '10000201', '13/08/2017');
        PC_Ventas.adicionar_ventas('V1000', '10000201', '13/08/2017');
        PC_Ventas.adicionar_ventas('V1000', '10000201', '13/08/2017');
        PC_Ventas.adicionar_ventas('V1000', '10000201', '13/08/2017');
        PC_Ventas.adicionar_ventas('V1000', '10000201', '13/08/2017');
    END;
    /   
   --Se eliminan las ventas
    SELECT * FROM ventas WHERE idempleado = 10000201;
    BEGIN
        PC_Ventas.eliminar_ventas('V1111');
        PC_Ventas.eliminar_ventas('V1112');
        PC_Ventas.eliminar_ventas('V1113');
        PC_Ventas.eliminar_ventas('V1114');
        PC_Ventas.eliminar_ventas('V1115');
        PC_Ventas.eliminar_ventas('V1116');
    END;
    /
    SELECT * FROM ventas WHERE idempleado = 10000201;
--Teniendo en cuenta su bajo desempeño en la nueva area se decide despedir al empleado.
    SELECT * FROM Personas WHERE id BETWEEN 10000199 AND 10000202;  
    BEGIN
        PC_Personas.eliminar_empleado(10000201);
        PC_Personas.eliminar_persona(10000201);
    END;
    /
    SELECT * FROM Personas WHERE id BETWEEN 10000199 AND 10000202;


--Prueba 2 Sergio Lopez
--Prueba 2 Sergio Lopez
--CRUD Productos, CRUD Proveedores.
--Quiero ingresar nuevos productos (compras por parte del empleado), 
--un proveedor A me vende productos con la afirmacion de son productos que no se vencen y sera muy vendidos, 
--el proovedor B me venden sus productos con la promesa de que son los precios tiene los precios mas bajos y 
--el proveedorC dice que tiene los productos mas duraderos y baratos.
--Antes de finalizar comprobare que proveedor me es mas rentable para contratar y comprarle lo que queda del año.

--Creo el Empleado que realizara las compras (empleado).
BEGIN
    PC_Personas.adicionar_persona(10000200, 'Sergio', 'Lopez', '3115977777', 'carrera 111 67c 98', '16/12/2002');
    PC_Personas.adicionar_empleado(10000200, 2500000, '2', 'Compras');
END;
/
SELECT * FROM Personas WHERE id = 10000200;
SELECT * FROM Empleados WHERE idPersonas = 10000200;

--Creo los proveedores. (proveedorA, proovedorB, proveedorC)  
BEGIN
    PC_Proveedores.adicionar_Proveedores('P1100', 'proveedorA', 'calle 67 111c 57', 'proveedorA@gmail.com');
    PC_Proveedores.adicionar_Proveedores('P1101', 'proveedorB', 'calle 24 Av 56b', 'proveedorH@gmail.com');
    PC_Proveedores.adicionar_Proveedores('P1102', 'proveedorC', 'calle 24 76 sur', null);
END;
/
SELECT * FROM Proveedores WHERE id BETWEEN 'P1100' AND 'P1102';

--Me doy cuenta que el proveedorC no tiene correo entoces procedo a eliminarlo (queda descalificado)
BEGIN
    PC_Proveedores.eliminar_Proveedores('P1102');
END;
/
SELECT * FROM Proveedores WHERE id BETWEEN 'P1100' AND 'P1102';

--Y el proveedorB se da cuenta que puso el correo mal entoces modifico el correo al correcto.
BEGIN
    PC_Proveedores.modificar_Proveedores('P1101', 'proveedorB@gmail.com');
END;
/
SELECT * FROM Proveedores WHERE id BETWEEN 'P1100' AND 'P1101';


--Inserto las compras a los dos proveedores(compras, detallesCompras, comprasProveedores).
BEGIN
    --Compras a provedorA
    PC_Compras.adicionar_Compras('C1100', '10000200', '10/05/2024', 'C');
    PC_Compras.adicionar_detalleCompras('C1100', 'C1100', 'Arroz Diana Larga vida', 10, 0);
    PC_Compras.adicionar_comprasProveedores('C1100', 'P1100', 10000);

    PC_Compras.adicionar_Compras('C1101', '10000200', '30/05/2024', 'P');
    PC_Compras.adicionar_detalleCompras('C1101', 'C1101', 'Pasta Doria Larga Vida', 10, 0);
    PC_Compras.adicionar_comprasProveedores('C1101', 'P1100', 13000);

    PC_Compras.adicionar_Compras('C1102', '10000200', '20/05/2024', 'C');
    PC_Compras.adicionar_detalleCompras('C1102', 'C1102', 'Huevos AAA Larga Vida', 10, 0);
    PC_Compras.adicionar_comprasProveedores('C1102', 'P1100', 16000);

    --Compras a provedorB
    PC_Compras.adicionar_Compras('C1103', '10000200', '10/01/2024', 'C');
    PC_Compras.adicionar_detalleCompras('C1103', 'C1103', 'Arroz Diana', 10, 0);
    PC_Compras.adicionar_comprasProveedores('C1103', 'P1101', 5000);

    PC_Compras.adicionar_Compras('C1104', '10000200', '20/03/2024', 'P');
    PC_Compras.adicionar_detalleCompras('C1104', 'C1104', 'Pasta Doria', 10, 0);
    PC_Compras.adicionar_comprasProveedores('C1104', 'P1101', 7000);

    PC_Compras.adicionar_Compras('C1105', '10000200', '27/02/2024', 'P');
    PC_Compras.adicionar_detalleCompras('C1105', 'C1105', 'Huevos AAA Larga Vida', 10, 100);
    PC_Compras.adicionar_comprasProveedores('C1105', 'P1101', 10000);
END;
/

SELECT * FROM compras WHERE id  BETWEEN 'C1100' AND 'C1105';
SELECT * FROM detallesCompras WHERE id  BETWEEN 'C1100' AND 'C1105';
SELECT * FROM comprasProveedores WHERE idproveedor = 'P1100' OR idproveedor = 'P1101';

--Me doy cuenta que no tengo deudas del producto pasta y la compra esta en estado P pendiende entoces procedo a actualizarla a estado cancelado.
BEGIN
    PC_Compras.modificar_Compras('C1101','C');
    PC_Compras.modificar_Compras('C1104','C');
END;
/
SELECT * FROM compras WHERE id  BETWEEN 'C1100' AND 'C1105';


--Creo los productos comprados en el inventario (arroz, pasta, huevos) para la venta.
BEGIN
    --ProveedorA
    PC_Productos.adicionar_perecedero(10000100, '24/10/2024', 'Arroz Diana Larga vida', 20000, 10, 'P1100');
    PC_Productos.adicionar_perecedero(10000101, '24/06/2024', 'Pasta Doria Larga Vida', 26000, 10, 'P1100');
    PC_Productos.adicionar_perecedero(10000102, '24/10/2023', 'Huevos AAA Larga Vida', 16000, 10, 'P1100');

    --ProveedorB
    PC_Productos.adicionar_perecedero(10000103, '24/07/2023', 'Arroz Diana', 10000, 10, 'P1101');
    PC_Productos.adicionar_perecedero(10000104, '24/07/2023', 'Pasta Doria', 7000, 10, 'P1101');
    PC_Productos.adicionar_perecedero(10000105, '05/06/2023', 'Huevos AAA', 10000, 10, 'P1101');
END;
/

SELECT * FROM perecederos WHERE id BETWEEN 10000100 AND 10000105;

--Los agrego a los detalleProductosCompras
BEGIN
    PC_Compras.adicionar_detalleProductosCompras(10000100, 10001028,'C1100', 'C1100');
    PC_Compras.adicionar_detalleProductosCompras(10000101, 10001028,'C1101', 'C1101');
    PC_Compras.adicionar_detalleProductosCompras(10000102, 10001028,'C1102', 'C1102');

    PC_Compras.adicionar_detalleProductosCompras(10000103, 10001028,'C1103', 'C1103');
    PC_Compras.adicionar_detalleProductosCompras(10000104, 10001028,'C1104', 'C1104');
    PC_Compras.adicionar_detalleProductosCompras(10000105, 10001028,'C1105', 'C1105');
END;
/
SELECT * FROM detalleProductosCompras WHERE idperecederos BETWEEN 10000100 AND 10000105;

--*genero ventas*
BEGIN
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');

    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
    PC_Ventas.adicionar_ventas('V1000',10000200,'30/05/2023');
END;
/

BEGIN
    PC_Ventas.adicionar_detalles_ventas('V1000', 'V1100', null, 3, 10000100, 10001028);
    PC_Ventas.adicionar_detalles_ventas('V1000', 'V1101', null, 3, 10000101, 10001028);
    PC_Ventas.adicionar_detalles_ventas('V1000', 'V1102', null, 3, 10000102, 10001028);


    PC_Ventas.adicionar_detalles_ventas('V1000', 'V1103', null, 8, 10000103, 10001028);
    PC_Ventas.adicionar_detalles_ventas('V1000', 'V1104', null, 8, 10000104, 10001028);
    PC_Ventas.adicionar_detalles_ventas('V1000', 'V1105', null, 8, 10000105, 10001028);
    
END;
/

SELECT * FROM   ventas WHERE id between 'V1100' AND 'V1105';
SELECT * FROM detallesVentas WHERE id between 'V1100' AND 'V1105';


--Reviso la fecha de caducidad de los productos del proovedorA para ver si cumplio la promesa.
SELECT * FROM vencimiento_producto WHERE id between 10000100 AND 10000105;


--Reviso los precios de los productos del ProveedorB para ver si cumplio su promesa.

SELECT * FROM precio_proveedor WHERE proveedor_id = 'P1100';

SELECT * FROM precio_proveedor WHERE proveedor_id = 'P1101';


--Reviso la rentabilidad de estos ganancias-compras.
--proveedorA
SELECT proveedores.nombre, (SELECT SUM(precio)FROM ComprasProveedores WHERE idproveedor = 'P1100') 
AS compras, (SELECT SUM(precio)FROM perecederos WHERE idproveedor = 'P1100') 
AS ventas, ((SELECT SUM(precio)FROM perecederos WHERE idproveedor = 'P1100')-(SELECT SUM(precio)FROM ComprasProveedores WHERE idproveedor = 'P1100')) 
AS ganancias FROM Perecederos
JOIN Proveedores ON perecederos.idproveedor = proveedores.id
WHERE proveedores.id = 'P1100' AND ROWNUM = 1;

--proveedorB
SELECT proveedores.nombre, (SELECT SUM(precio)FROM ComprasProveedores WHERE idproveedor = 'P1101') 
AS compras, (SELECT SUM(precio)FROM perecederos WHERE idproveedor = 'P1101') 
AS ventas, ((SELECT SUM(precio)FROM perecederos WHERE idproveedor = 'P1101')-(SELECT SUM(precio)FROM ComprasProveedores WHERE idproveedor = 'P1101')) 
AS ganancias FROM Perecederos
JOIN Proveedores ON perecederos.idproveedor = proveedores.id
WHERE proveedores.id = 'P1101' AND ROWNUM = 1;


--Contrato al mejor proveedor y le pido al proveedor perdedor que modifique su correo a nulo para retirarlo de nuestra base de datos 
--ya que no cumplio con las espectativas esperadas.


--Elimino las compras hechas asi libero espacio de mi bd.
BEGIN
    PC_Compras.eliminar_Compras('C1100');
    PC_Compras.eliminar_Compras('C1101');
    PC_Compras.eliminar_Compras('C1102');

    PC_Compras.eliminar_Compras('C1103');
    PC_Compras.eliminar_Compras('C1104');

    --Como se podra observar no puede eliminar la de los huevos del proveedorB ya que no la termine de pagar y 
    --esta en estado pendiente (esta deuda si no la pague).
    PC_Compras.eliminar_Compras('C1105');
END;
/

SELECT * FROM compras WHERE id  BETWEEN 'C1100' AND 'C1105';

--Pagamos la deuda y eliminamos la compra

BEGIN
    PC_Compras.modificar_detalleCompras('C1105', 0);
    PC_Compras.modificar_Compras('C1105','C');
    PC_Compras.eliminar_Compras('C1105');
    PC_Proveedores.eliminar_Proveedores('P1101');
END;
/
SELECT * FROM compras WHERE id  BETWEEN 'C1100' AND 'C1105';
