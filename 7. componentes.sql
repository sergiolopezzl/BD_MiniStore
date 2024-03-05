--CRUDE
--CICLO UNO
    --CRUD: Proveedores
    CREATE OR REPLACE PACKAGE PC_Proveedores AS
        PROCEDURE adicionar_Proveedores(p_id IN CHAR, p_nombre IN VARCHAR, p_direccion IN VARCHAR, p_correo IN VARCHAR);
        PROCEDURE modificar_Proveedores(p_id IN CHAR, p_correo IN VARCHAR);
        PROCEDURE eliminar_Proveedores(p_id IN CHAR);
        FUNCTION obtener_Precio_Proveedor(p_id IN CHAR) RETURN NUMBER;
    END PC_Proveedores;
    /
    --CRUD: Compras
    CREATE OR REPLACE PACKAGE PC_Compras AS
        PROCEDURE adicionar_Compras(p_id IN CHAR, p_idempleados IN CHAR, p_fecha IN DATE, p_estado IN CHAR);
        PROCEDURE adicionar_detalleCompras(p_id IN CHAR, p_idcompra IN CHAR, p_detalle IN VARCHAR, p_cantidad IN NUMBER, p_deuda IN NUMBER);
        PROCEDURE adicionar_detalleProductosCompras(p_idPerecederos IN CHAR, p_idNoPerecederos IN CHAR, p_idetallesCompras IN CHAR, p_idcompra IN CHAR);
        PROCEDURE adicionar_ComprasProveedores(p_idcompra IN CHAR, p_idproveedor IN CHAR, p_precio IN NUMBER);
        PROCEDURE modificar_Compras(p_id IN CHAR, p_estado IN CHAR);
        PROCEDURE modificar_detalleCompra(p_id IN CHAR, p_deuda IN NUMBER);
        PROCEDURE eliminar_Compras(p_id IN CHAR);
        FUNCTION obtener_Total_Compras(p_id IN CHAR) RETURN SYS_REFCURSOR;
    END PC_Compras;
    /
    --CRUD: Personas
    CREATE OR REPLACE PACKAGE PC_Personas AS
        PROCEDURE adicionar_persona(p_id IN CHAR, p_nombre IN VARCHAR, p_apellido IN VARCHAR, p_telefono IN NUMBER, p_direccion IN VARCHAR, p_fechadenacimiento IN DATE);
        PROCEDURE adicionar_empleado(p_idpersona IN CHAR, p_sueldo IN CHAR, p_puesto IN NUMBER, p_departamento IN VARCHAR);
        PROCEDURE adicionar_cliente(p_idpersona IN CHAR, p_puntosdefidelidad IN NUMBER);
        PROCEDURE modificar_persona(p_id IN CHAR, p_nombre IN VARCHAR, p_apellido IN VARCHAR, p_telefono IN NUMBER, p_direccion IN VARCHAR, p_fechadenacimiento IN DATE);
        PROCEDURE modificarDepartamento(p_idpersona IN CHAR, p_departamento IN CHAR);
        PROCEDURE modificar_empleado_ascenso(p_idpersona IN CHAR);
        PROCEDURE modificar_empleado_descenso(p_idpersona IN CHAR);
        PROCEDURE eliminar_empleado(p_idpersona IN CHAR);
        PROCEDURE eliminar_cliente(p_idpersona IN CHAR);
        PROCEDURE eliminar_persona(p_id IN CHAR);
        FUNCTION obtener_Compras_Totales_Empleado(p_idpersona IN CHAR) RETURN NUMBER;
        FUNCTION obtenerRendimientoEmpleado(p_idpersona IN CHAR) RETURN SYS_REFCURSOR;
    END PC_Personas;
    /  
    
    --CRUD: Productos
    CREATE OR REPLACE PACKAGE PC_Productos AS
        PROCEDURE adicionar_perecedero(p_id IN CHAR, p_fechadevencimiento IN DATE, p_nombre IN VARCHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR);
        PROCEDURE modificar_perecedero(p_id IN CHAR, p_fechadevencimiento IN DATE, p_nombre IN VARCHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR);
        PROCEDURE eliminar_perecedero(p_id IN CHAR);
        PROCEDURE adicionar_noPerecedero(p_id IN CHAR, p_tipo IN CHAR, p_nombre IN CHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR);
        PROCEDURE modificar_noPerecedero(p_id IN CHAR, p_tipo IN CHAR, p_nombre IN CHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR);
        PROCEDURE eliminar_noPerecedero(p_id IN CHAR);
        FUNCTION obtenerProximos_aVencer(p_numero IN NUMBER)  RETURN SYS_REFCURSOR;
        FUNCTION obtenerVencidos RETURN SYS_REFCURSOR;
        FUNCTION obtenerinventarioPerecederos(longitud IN NUMBER) RETURN SYS_REFCURSOR;
        FUNCTION obtenerinventarioNoPerecederos(longitud IN NUMBER) RETURN SYS_REFCURSOR;
        FUNCTION obtenerPerecederosMasVendidos(longitud IN NUMBER) RETURN SYS_REFCURSOR;
        FUNCTION obtenerNoPerecederosMasVendidos(longitud IN NUMBER) RETURN SYS_REFCURSOR;       
    END PC_Productos;
    /
--CICLO DOS
    CREATE OR REPLACE PACKAGE PC_Ventas AS
        PROCEDURE adicionar_ventas(p_id IN CHAR, p_idempleado IN CHAR, p_fecha IN DATE);
        PROCEDURE adicionar_detalles_ventas(p_id IN CHAR, p_idventa IN CHAR, p_detalle IN XMLtype, p_cantidad IN NUMBER, p_idPerecederos IN CHAR, p_idNoPerecederos IN CHAR);
        PROCEDURE modificar_detalles_ventas(p_id IN CHAR, p_detalle IN XMLType, p_cantidad IN NUMBER);
        PROCEDURE eliminar_ventas(p_id IN CHAR);
        FUNCTION obtenerComprasClientes(p_id IN CHAR) RETURN NUMBER;
        FUNCTION obtenerVentasTotalEmpleado(p_idpersona IN CHAR) RETURN NUMBER;
        FUNCTION obtenerPerecederosRentabilidad(longitud IN NUMBER) RETURN SYS_REFCURSOR;
        FUNCTION obtenerNoPerecederosRentabilidad(longitud IN NUMBER) RETURN SYS_REFCURSOR;
        FUNCTION obtenerDetalleVentaProducto(longitud IN NUMBER) RETURN SYS_REFCURSOR;
    END PC_Ventas;
    /  

--CRUDI
--CICLO UNO
    --CRUD: Proveedores
    CREATE OR REPLACE PACKAGE BODY PC_Proveedores IS
        PROCEDURE adicionar_Proveedores(p_id IN CHAR, p_nombre IN VARCHAR, p_direccion IN VARCHAR, p_correo IN VARCHAR) IS
        BEGIN   
            INSERT INTO Proveedores(id, nombre, direccion, correo)
            VALUES (p_id, p_nombre, p_direccion, p_correo);
            COMMIT;
        END adicionar_Proveedores;

        PROCEDURE modificar_Proveedores(p_id IN CHAR, p_correo IN VARCHAR) IS
        BEGIN
            UPDATE proveedores SET correo = p_correo WHERE id = p_id;
            COMMIT;
        END modificar_Proveedores;

        PROCEDURE eliminar_Proveedores(p_id IN CHAR) IS
            v_estado_correo VARCHAR(50);
        BEGIN
            SELECT correo INTO v_estado_correo FROM Proveedores WHERE id = p_id;
            IF v_estado_correo is NULL THEN
                DELETE FROM proveedores WHERE id = p_id;
                COMMIT;
            ELSE
                RAISE_APPLICATION_ERROR(-20045, 'No se puede eliminar un proveedor si su correo no es nulo');
                ROLLBACK;
            END IF;
        END eliminar_Proveedores;

        FUNCTION obtener_Precio_Proveedor(p_id IN CHAR) RETURN NUMBER IS
            v_precio NUMBER;
        BEGIN
            SELECT SUM(Total_Compras) INTO v_precio
            FROM precio_proveedor
            WHERE proveedor_id = p_id;
            RETURN v_precio;
        END obtener_Precio_Proveedor;
    END PC_Proveedores;
    /
    --CRUD: Compras
    CREATE OR REPLACE PACKAGE BODY PC_Compras IS
        PROCEDURE adicionar_Compras(p_id IN CHAR, p_idempleados IN CHAR, p_fecha IN DATE, p_estado IN CHAR) IS
        BEGIN
            INSERT INTO Compras(id, idempleados, fecha, estado)
            VALUES(p_id, p_idempleados, p_fecha, p_estado);
            COMMIT;
        END adicionar_Compras;
        
        PROCEDURE adicionar_detalleCompras(p_id IN CHAR, p_idcompra IN CHAR, p_detalle IN VARCHAR, p_cantidad IN NUMBER, p_deuda IN NUMBER) IS
        BEGIN
            INSERT INTO DetallesCompras(id, idcompra, detalle, cantidad, deuda)
            VALUES(p_id, p_idcompra, p_detalle, p_cantidad, p_deuda);
            COMMIT;
        END adicionar_detalleCompras;

        PROCEDURE adicionar_detalleProductosCompras(p_idPerecederos IN CHAR, p_idNoPerecederos IN CHAR, p_idetallesCompras IN CHAR, p_idcompra IN CHAR) IS
        BEGIN
            INSERT INTO DetalleProductosCompras(idPerecederos, idNoPerecederos, idDetalleCompra, idcompra)
            VALUES (p_idPerecederos, p_idNoPerecederos, p_idetallesCompras, p_idcompra);
            COMMIT;
        END adicionar_detalleProductosCompras;

        PROCEDURE adicionar_ComprasProveedores(p_idcompra IN CHAR, p_idproveedor IN CHAR, p_precio IN NUMBER) IS
        BEGIN
            INSERT INTO ComprasProveedores(idcompra, idproveedor, precio)
            VALUES (p_idcompra, p_idproveedor, p_precio);
            COMMIT;
        END adicionar_ComprasProveedores;

        PROCEDURE modificar_Compras(p_id IN CHAR, p_estado IN CHAR) IS 
            deuda_actual NUMBER(9);
        BEGIN
            SELECT SUM(deuda) INTO deuda_actual
            FROM DetallesCompras
            WHERE idcompra = p_id;

            IF deuda_actual = 0 THEN
                UPDATE Compras SET estado = p_estado WHERE id = p_id;
                COMMIT;
            ELSE
                RAISE_APPLICATION_ERROR(-20008, 'Solo se puede modificar el estado de una compra si la deuda esta pagada');
                ROLLBACK;
            END IF;
        END modificar_Compras;

        PROCEDURE modificar_detalleCompra(p_id IN CHAR, p_deuda IN NUMBER) IS
        BEGIN
            UPDATE DetalleCompra SET deuda = p_deuda WHERE id = p_id;
            COMMIT;
        END modificar_detalleCompra;

        PROCEDURE eliminar_Compras(p_id IN CHAR) IS
            v_estado_compra CHAR(1);
        BEGIN
            SELECT estado INTO v_estado_compra FROM Compras WHERE id = p_id;
            IF v_estado_compra = 'C' THEN
                DELETE FROM Compras WHERE id = p_id;
                COMMIT;
            ELSE
                RAISE_APPLICATION_ERROR(-20009, 'Solo se puede eliminar una compra que se encuentre en estado Cancelada');
                ROLLBACK;
            END IF;
        END eliminar_Compras;

        FUNCTION obtener_Total_Compras(p_id IN CHAR) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
                SELECT * FROM total_compras WHERE id = p_id;
            RETURN v_cursor;
        END obtener_Total_Compras;
    END PC_Compras;
    /

    --CRUD: Personas
    CREATE OR REPLACE PACKAGE BODY PC_Personas AS
        PROCEDURE adicionar_persona(p_id IN CHAR, p_nombre IN VARCHAR, p_apellido IN VARCHAR, p_telefono IN NUMBER, p_direccion IN VARCHAR, p_fechadenacimiento IN DATE) IS
        BEGIN
            INSERT INTO Personas(id, nombre, apellido, telefono, direccion, fechaDeNacimiento)
            VALUES(p_id, p_nombre, p_apellido, p_telefono, p_direccion, p_fechadenacimiento);
            COMMIT;
        END adicionar_persona;
        
        PROCEDURE adicionar_empleado(p_idpersona IN CHAR, p_sueldo IN CHAR, p_puesto IN NUMBER, p_departamento IN VARCHAR) IS
        BEGIN
            INSERT INTO Empleados(idpersonas, sueldo, puesto, departamento)
            VALUES(p_idpersona, p_sueldo, p_puesto, p_departamento);
            COMMIT;
        END adicionar_empleado;
        
        PROCEDURE adicionar_cliente(p_idpersona IN CHAR, p_puntosdefidelidad IN NUMBER) IS
        BEGIN
            INSERT INTO Clientes(idPersonas, puntosdefidelidad)
            VALUES(p_idpersona, p_puntosdefidelidad);
            COMMIT;
        END adicionar_cliente;
        
        PROCEDURE modificar_persona(p_id IN CHAR, p_nombre IN VARCHAR, p_apellido IN VARCHAR, p_telefono IN NUMBER, p_direccion IN VARCHAR, p_fechadenacimiento IN DATE) IS
        BEGIN
            UPDATE Personas 
            SET nombre = p_nombre, apellido = p_apellido, telefono = p_telefono, direccion = p_direccion, fechaDeNacimiento = p_fechadenacimiento
            WHERE id = p_id;
            COMMIT;
        END modificar_persona;
        
        PROCEDURE modificarDepartamento(p_idpersona IN CHAR, p_departamento IN CHAR) IS
        BEGIN
            IF p_departamento IN ('Financiero', 'Recursos Humanos', 'Marketing', 'Comercial', 'Compras', 'Control de Gestion', 'Logistica',  'Ventas', 'Comunicacion') THEN
                UPDATE Empleados SET departamento = p_departamento WHERE idpersonas = p_idpersona;
                COMMIT;
            ELSE
                RAISE_APPLICATION_ERROR(-20008, 'El departamento ingresado no existe');
                ROLLBACK;
            END IF;
        END modificarDepartamento;
        
        PROCEDURE modificar_empleado_ascenso(p_idpersona IN CHAR) IS
            v_puesto NUMBER(1);
        BEGIN
            SELECT puesto INTO v_puesto
            FROM Empleados
            WHERE idpersonas = p_idpersona;
            
            IF v_puesto = 1 THEN
                UPDATE Empleados SET puesto = 2 WHERE idpersonas = p_idpersona;
                COMMIT;
            ELSIF v_puesto = 2 THEN
                UPDATE Empleados SET puesto = 3 WHERE idpersonas = p_idpersona;
                COMMIT;
            ELSE
                RAISE_APPLICATION_ERROR(-20032, 'Maximo puesto alcanzado, no se puede ascender más');
                ROLLBACK;
            END IF;
        END modificar_empleado_ascenso;
        
        PROCEDURE modificar_empleado_descenso(p_idpersona IN CHAR) IS
            v_puesto NUMBER(1);
        BEGIN
            SELECT puesto INTO v_puesto
            FROM Empleados
            WHERE idpersonas = p_idpersona;
            
            IF v_puesto = 3 THEN
                UPDATE Empleados SET puesto = 2 WHERE idpersonas = p_idpersona;
                COMMIT;
            ELSIF v_puesto = 2 THEN
                UPDATE Empleados SET puesto = 1 WHERE idpersonas = p_idpersona;
                COMMIT;
            ELSE
                RAISE_APPLICATION_ERROR(-20032, 'Minimo puesto alcanzado, no se puede descender más. Sugerencia: Despedir');
                ROLLBACK;
            END IF;
        END modificar_empleado_descenso; 
        
        PROCEDURE eliminar_empleado(p_idpersona IN CHAR) IS
        BEGIN
            DELETE FROM Empleados WHERE idpersonas = p_idpersona;
            COMMIT;
        END eliminar_empleado; 
        PROCEDURE eliminar_cliente(p_idpersona IN CHAR) IS
        BEGIN
            DELETE FROM Clientes WHERE idPersonas = p_idpersona;
            COMMIT;
        END eliminar_cliente;
        PROCEDURE eliminar_persona(p_id IN CHAR) IS
        BEGIN
            DELETE FROM Personas WHERE id = p_id;
            COMMIT;
        END eliminar_persona;
        FUNCTION obtener_Compras_Totales_Empleado(p_idpersona IN CHAR) RETURN NUMBER IS
            v_ventas NUMBER(2);
        BEGIN
            SELECT comprasHechas INTO  v_ventas FROM compras_empleados WHERE idpersonas = p_idpersona;
            RETURN v_ventas;
        END obtener_Compras_Totales_Empleado;

        FUNCTION obtenerRendimientoEmpleado(p_idpersona IN CHAR) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM rendimiento_empleado WHERE idempleado = p_idpersona;
            RETURN v_cursor;
        END obtenerRendimientoEmpleado;
    END PC_Personas;
    /


    --CRUD: Productos
    CREATE OR REPLACE PACKAGE BODY PC_Productos AS
        PROCEDURE adicionar_perecedero(p_id IN CHAR, p_fechadevencimiento IN DATE, p_nombre IN VARCHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR) IS
        BEGIN
            INSERT INTO Perecederos(id, fechaDeVencimiento, nombre, precio, cantidad, idProveedor)
            VALUES(p_id, p_fechadevencimiento, p_nombre, p_precio, p_cantidad, p_idproveedor);
            COMMIT;
        END adicionar_perecedero;

        PROCEDURE modificar_perecedero(p_id IN CHAR, p_fechadevencimiento IN DATE, p_nombre IN VARCHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR) IS
        BEGIN
            UPDATE Perecederos SET fechaDeVencimiento = p_fechadevencimiento, nombre = p_nombre, precio = p_precio, cantidad = p_cantidad, idProveedor = p_idproveedor
            WHERE id = p_id;
            COMMIT;
        END modificar_perecedero; 

        PROCEDURE eliminar_perecedero(p_id IN CHAR) IS       
        BEGIN
            DELETE FROM Perecederos WHERE id = p_id;
            COMMIT;
        END eliminar_perecedero;

        PROCEDURE adicionar_noPerecedero(p_id IN CHAR, p_tipo IN CHAR, p_nombre IN CHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR) IS
        BEGIN
            INSERT INTO NoPerecederos(id, tipo, nombre, precio, cantidad, idProveedor)
            VALUES(p_id, p_tipo, p_nombre, p_precio, p_cantidad, p_idproveedor);
            COMMIT;
        END adicionar_noPerecedero;

        PROCEDURE modificar_noPerecedero(p_id IN CHAR, p_tipo IN CHAR, p_nombre IN CHAR, p_precio IN NUMBER, p_cantidad IN NUMBER, p_idproveedor IN CHAR) IS
        BEGIN
            UPDATE NoPerecederos SET tipo = p_tipo, nombre = p_nombre, precio = p_precio, cantidad = p_cantidad, idProveedor = p_idproveedor
            WHERE id = p_id;
            COMMIT;
        END modificar_noPerecedero;

        PROCEDURE eliminar_noPerecedero(p_id IN CHAR) IS
        BEGIN
            DELETE FROM NoPerecederos WHERE id = p_id;
            COMMIT;
        END eliminar_noPerecedero; 
        FUNCTION obtenerProximos_aVencer(p_numero IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT id, nombre, fechaDeVencimiento FROM vencimiento_producto WHERE ROWNUM <= p_numero; 
            RETURN v_cursor;
        END obtenerProximos_aVencer;

        FUNCTION obtenerVencidos RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM productos_vencidos; 
            RETURN v_cursor;
        END obtenerVencidos;

        FUNCTION obtenerinventarioPerecederos(longitud IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM inventario_perecedero WHERE ROWNUM <= longitud;
            RETURN v_cursor;
        END obtenerinventarioPerecederos;

        FUNCTION obtenerinventarioNoPerecederos(longitud IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM inventario_noperecedero WHERE ROWNUM <= longitud;
            RETURN v_cursor;
        END obtenerinventarioNoPerecederos;

        FUNCTION obtenerPerecederosMasVendidos(longitud IN NUMBER)  RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM perecederos_mas_vendidos WHERE ROWNUM <= longitud;
            RETURN v_cursor;
        END obtenerPerecederosMasVendidos;

        FUNCTION obtenerNoPerecederosMasVendidos(longitud IN NUMBER)  RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM noperecederos_mas_vendido WHERE ROWNUM <= longitud;
            RETURN v_cursor;
        END obtenerNoPerecederosMasVendidos;
    END PC_Productos;
    /

--CICLO DOS
    --CRUD: Ventas
    CREATE OR REPLACE PACKAGE BODY PC_Ventas IS
        PROCEDURE adicionar_ventas(p_id IN CHAR, p_idempleado IN CHAR, p_fecha IN DATE) IS
        BEGIN
            INSERT INTO ventas(id, idempleado, fecha)
            VALUES (p_id, p_idempleado, p_fecha);
            COMMIT;
        END adicionar_ventas;

        PROCEDURE adicionar_detalles_ventas(p_id IN CHAR, p_idventa IN CHAR, p_detalle IN XMLType, p_cantidad IN NUMBER, p_idPerecederos IN CHAR, p_idNoPerecederos IN CHAR) IS
        BEGIN
            INSERT INTO detallesventas(id, idventa, detalle, cantidad, idPerecederos, idNoPerecederos)
            VALUES (p_id, p_idventa, p_detalle, p_cantidad, p_idPerecederos, p_idNoPerecederos);
            COMMIT;
        END adicionar_detalles_ventas;

        PROCEDURE modificar_detalles_ventas(p_id IN CHAR, p_detalle IN XMLType, p_cantidad IN NUMBER) IS
        BEGIN
            UPDATE detallesventas SET detalle = p_detalle, cantidad = p_cantidad WHERE id = p_id;
            COMMIT;
        END modificar_detalles_ventas;

        PROCEDURE eliminar_ventas(p_id IN CHAR) IS
            v_fecha DATE;
        BEGIN
            SELECT fecha INTO v_fecha FROM Ventas WHERE id = p_id; 
            IF TRUNC(SYSDATE - v_fecha) < (365*2) THEN
                RAISE_APPLICATION_ERROR(-20024, 'Solo se puede borrar una venta si ha pasado más de dos años desde su registro');
            ELSE
                DELETE FROM Ventas WHERE id = p_id;
                COMMIT;
            END IF;
        END eliminar_ventas;

        FUNCTION obtenerComprasClientes(p_id IN CHAR) RETURN NUMBER IS
            Compras NUMBER;
        BEGIN
            SELECT comprasHechas INTO compras FROM total_compras_cliente WHERE id = p_id;
            RETURN compras;
        END obtenerComprasClientes; 

        FUNCTION obtenerVentasTotalEmpleado(p_idpersona IN CHAR) RETURN NUMBER IS
            Ventas NUMBER;
        BEGIN
            SELECT VentasHechas INTO Ventas FROM total_ventas_empleado WHERE id = p_idpersona;
            RETURN Ventas;
        END obtenerVentasTotalEmpleado;

        FUNCTION obtenerPerecederosRentabilidad(longitud IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM perecederos_rentabilidad WHERE ROWNUM <= longitud;
            RETURN v_cursor;
        END obtenerPerecederosRentabilidad;

        FUNCTION obtenerNoPerecederosRentabilidad(longitud IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM noperecederos_rentabilidad WHERE ROWNUM <= longitud;
            RETURN v_cursor;
        END obtenerNoPerecederosRentabilidad;

        FUNCTION obtenerDetalleVentaProducto(longitud IN NUMBER) RETURN SYS_REFCURSOR IS
            v_cursor SYS_REFCURSOR;
        BEGIN
            OPEN v_cursor FOR
            SELECT * FROM detalle_ventas WHERE ROWNUM <= longitud ORDER BY cantidad DESC;
            RETURN v_cursor;
        END obtenerDetalleVentaProducto;
    END PC_Ventas;
    /

--CRUDOK
--CICLO UNO
    --CRUD:Proveedores
    --Adicionar
    BEGIN
        PC_Proveedores.adicionar_Proveedores('P5555', 'El Carnal', 'CRA 45 # 43', null);
    END;
    /
    SELECT * FROM Proveedores WHERE nombre = 'El Carnal';
    --Modificar
    SELECT * FROM Proveedores WHERE id = 'P1100';
    BEGIN
        PC_Proveedores.modificar_Proveedores('P1100','elcarnal@carnes.org');
    END;
    /
    BEGIN
        PC_Proveedores.modificar_Proveedores('P1100', null);
    END;
    /
    SELECT * FROM Proveedores WHERE id = 'P1100';
    --Eliminar
    SELECT * FROM Proveedores WHERE id BETWEEN 'P1099' AND 'P1100';
    BEGIN
        PC_Proveedores.eliminar_Proveedores('P1100');
    END;
    /
    SELECT * FROM Proveedores WHERE id BETWEEN 'P1099' AND 'P1100';
    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_precio NUMBER;
    BEGIN
        v_precio := PC_Proveedores.obtener_Precio_Proveedor('P1099'); 
        DBMS_OUTPUT.PUT_LINE('El precio de los productos del proveedor con codigo P1099 es: ' || v_precio);
    END;
    /
    --CRUD: Compras
    --Adicionar compra
    BEGIN
        PC_Compras.adicionar_Compras('C4105', 10000137 , SYSDATE, 'P');
    END;
    /
    SELECT * FROM Compras WHERE id = 'C1100';
    --Adicionar DetalleCompra
    BEGIN
        PC_Compras.adicionar_detalleCompras('C1001', 'C1100', 'EFzx1D3wE8N0IW297V68', 60, 100);
    END;
    /
    SELECT * FROM DetallesCompras WHERE id = 'C1100';
    --Modificar Compra
    UPDATE DetallesCompras SET deuda = 0 WHERE idcompra = 'C1100';
    SELECT * FROM Compras WHERE id = 'C1100';
    BEGIN
        PC_Compras.modificar_Compras('C1100', 'C');
    END;
    /
    SELECT * FROM Compras WHERE id = 'C1100';
    --Eliminar Compra
    SELECT * FROM Compras WHERE id BETWEEN 'C1098' AND 'C1100';
    BEGIN
        PC_Compras.eliminar_Compras('C1100');
    END;
    /
    SELECT * FROM Compras WHERE id BETWEEN 'C1098' AND 'C1100';
    --Consultar
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el total de compras para la compra 'C1088'
        v_cursor := PC_Compras.obtener_Total_Compras('C1088');
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
    --CRUD: Personas
    --Adicionar persona
    BEGIN
        PC_Personas.adicionar_persona(10000000, 'Cristian', 'Alvarez', 3154636654, 'Cra 34 # 45-25 sur', '25/07/02');
        PC_Personas.adicionar_persona(10000000, 'Sergio', 'Lopez', 3114636654, 'Cra 34 # 45-25 sur', '15/12/02');
    END;
    /
    SELECT * FROM Personas WHERE id BETWEEN 10000199 AND 10000202;
    --Adicionar empleado
    BEGIN
        PC_Personas.adicionar_empleado(10000200, 150, 1, 'Comercial');
        PC_Personas.adicionar_empleado(10000201, 150, 3, 'Financiero');
    END;
    /
    SELECT * FROM Empleados WHERE idpersonas BETWEEN 10000199 AND 10000201;

    --Adicionar cliente
    BEGIN
        PC_Personas.adicionar_cliente(10000200, 8);
    END;
    /
    SELECT * FROM CLientes WHERE idpersonas = 10000200;
    --Modificar persona
    BEGIN
        PC_Personas.modificar_persona(10000201, 'Sergio', 'Lopez', 3104636654, 'Cra 34 # 45-25 sur', '15/12/02');
    END;
    /
    SELECT * FROM Personas WHERE id = 10000201;
    --Modificar departamento
    SELECT * FROM EMPLEADOS WHERE idpersonas = 10000200;
    BEGIN
        PC_Personas.modificarDepartamento(10000200, 'Financiero');
    END;
    /
    SELECT * FROM EMPLEADOS WHERE idpersonas = 10000200;

    --Modificar empleado_ascenso
    BEGIN
        PC_Personas.modificar_empleado_ascenso(10000200);
        PC_Personas.modificar_empleado_ascenso(10000200);
    END;
    /
    SELECT * FROM Empleados WHERE idpersonas = 10000200;
    --Modificar empleado_descenso
    BEGIN
        PC_Personas.modificar_empleado_descenso(10000201);
        PC_Personas.modificar_empleado_descenso(10000201);
    END;
    /
    SELECT * FROM Empleados WHERE idpersonas = 10000201;
    --eliminar empleado
    SELECT * FROM Empleados WHERE idpersonas BETWEEN 10000198 AND 10000201;
    BEGIN
        PC_Personas.eliminar_empleado(10000200);
        PC_Personas.eliminar_empleado(10000201);
    END;
    /
    SELECT * FROM Empleados WHERE idpersonas BETWEEN 10000198 AND 10000201;

    --Eliminar cliente
    SELECT * FROM CLientes WHERE idpersonas BETWEEN 10000198 AND 10000200;
    BEGIN
        PC_Personas.eliminar_cliente(10000200);
    END;
    /
    SELECT * FROM CLientes WHERE idpersonas BETWEEN 10000198 AND 10000200;

    --Eliminar persona
    SELECT * FROM Personas WHERE id BETWEEN 10000198 AND 10000201;
    BEGIN
        PC_Personas.eliminar_persona(10000200);
        PC_Personas.eliminar_persona(10000201);
    END;
    /
    SELECT * FROM Personas WHERE id BETWEEN 10000198 AND 10000201;

    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_comprasTotales NUMBER;
    BEGIN
        v_comprasTotales := PC_Personas.obtener_Compras_Totales_Empleado(10000137); 
        DBMS_OUTPUT.PUT_LINE('Las compras del empleado con codigo 10000137 son: ' || v_comprasTotales);
    END;
    /
    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el rendimeinto del empleado con codigo 10000157
        v_cursor := PC_Personas.obtenerRendimientoEmpleado(10000157);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
    --CRUD: Productos
    --Adicionar Perecedero
    BEGIN
        PC_Productos.adicionar_perecedero(010, '24/09/26', 'Coco De celular', 15000, 68, 'P1026');
    END;
    /
    SELECT * FROM Perecederos WHERE id = 10000100;
    --Modificar Perecedero
    BEGIN
        PC_Productos.modificar_perecedero(10000100, '24/09/19', 'Coco De azucar', 15000, 68, 'P1026');
    END;
    /
    SELECT * FROM Perecederos WHERE id = 10000100;
    --Eliminar Perecedero
    SELECT * FROM Perecederos WHERE id BETWEEN 10000098 AND 10000100;
    BEGIN
        PC_Productos.eliminar_perecedero(10000100);
    END;
    /
    SELECT * FROM Perecederos WHERE id BETWEEN 10000098 AND 10000100;
    --Adicionar NoPerecedero
    BEGIN
        PC_Productos.adicionar_noPerecedero(010, 'D', 'Cuaderno esmeralda', 15000, 68, 'P1026');
    END;
    /
    SELECT * FROM NoPerecederos WHERE id = 10001100;
    --Modificar NoPerecedero
    SELECT * FROM NoPerecederos WHERE id = 10001100;
    BEGIN
        PC_Productos.modificar_noPerecedero(10001100, 'D', 'Cuaderno argollado', 15000, 0, 'P1026');
    END;
    /
    SELECT * FROM NoPerecederos WHERE id = 10001100;
    --Eliminar No Perecedero
    SELECT * FROM NoPerecederos WHERE id BETWEEN 10001098 AND 10001100;
    BEGIN
        PC_Productos.eliminar_noPerecedero(10001100);
    END;
    /

    SELECT * FROM NoPerecederos WHERE id BETWEEN 10001098 AND 10001100;
    --Consulta
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
    --Consulta
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


    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el inventario de los productos perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Productos.obtenerinventarioPerecederos(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el inventario de los productos no perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Productos.obtenerinventarioNoPerecederos(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /

    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el inventario de los productos perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Productos.obtenerPerecederosMasVendidos(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
    --Consulta
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener el inventario de los productos perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Productos.obtenerNoPerecederosMasVendidos(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
--CICLO DOS
    --CRUD: Ventas
    --Adicionar
    BEGIN
        PC_Ventas.adicionar_ventas('V1000', '10000134', '13/08/2017');
    END;
    /
    SELECT * FROM Ventas WHERE id = 'V1100';
    --Adicionar
    BEGIN
        PC_Ventas.adicionar_detalles_ventas('V1000', 'V1100', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron varios productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>ejemplo@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>'), 43074, 10000059, 10001028);
    END;
    /
    SELECT * FROM DetallesVentas WHERE id = 'V1100';
    --Modificar
    BEGIN
        PC_Ventas.modificar_detalles_ventas('V1100', XMLType('<descripcion>
                    <asunto>Venta de productos perecederos</asunto>
                    <texto>Se vendieron un productos perecederos.</texto>
                    <telefono>3133456756</telefono>
                    <correo>correomodificado@gmail.com</correo>
                    <direccion>Calle Principal, Bogotá</direccion>
                 </descripcion>') , 274);
    END;
    /
    SELECT * FROM DetallesVentas WHERE id = 'V1100';
    --Eliminar
    BEGIN
        PC_Ventas.eliminar_ventas('V1100');
    END;
    /
    SELECT * FROM Ventas WHERE id = 'V1100';
    SELECT * FROM DetallesVentas WHERE id = 'V1100';

    --Consultas
    SET SERVEROUTPUT ON;
    DECLARE
        v_compras NUMBER;
    BEGIN
        -- Obtener el inventario de los productos perecederos, de parametro enviar cuantos quiere que se muestren
        v_compras := PC_Ventas.obtenerComprasClientes(10000121); 
        DBMS_OUTPUT.PUT_LINE('Las compras del cliente con código 10000121 son: ' || v_compras);
    END;
    /

    --Consultas
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener la rentabilidad de los productos perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Ventas.obtenerPerecederosRentabilidad(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /

    --Consultas
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Obtener la rentabilidad de los productos no perecederos, de parametro enviar cuantos quiere que se muestren
        v_cursor := PC_Ventas.obtenerNoPerecederosRentabilidad(15);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
    -- Consultas
    SET SERVEROUTPUT ON;
    DECLARE
        v_cursor SYS_REFCURSOR;
    BEGIN
        -- Consultar aquellos detalles de ventas con mayor cantidad vendida para saber que tipo de productos se venden mas segun estos detalles
        v_cursor := PC_Ventas.obtenerDetalleVentaProducto(10);
        -- Mostrar los resultados en forma de tabla
        DBMS_SQL.RETURN_RESULT(v_cursor);
    END;
    /
--CRUDNOOK
--CICLO UNO
    --CRUD:Proveedores
    --No se puede eliminar un proveedor si su correo no es nulo
    EXECUTE  PC_Proveedores.eliminar_Proveedores('P1003');
    --CRUD: Compras
    --modificar
    --Solo se puede modificar el estado de una compra si la deuda está pagada
    EXECUTE PC_Compras.modificar_Compras('C1032', 'C');
    --eliminar
    --Solo se puede eliminar una compra que se encuentre en estado Cancelada
    EXECUTE PC_Compras.eliminar_Compras('C1032');
    --CRUD: Personas
    --Modificar
    --Departamento no permitido
    EXECUTE PC_Personas.modificarDepartamento(10000200, 'Inventarios');
    --Maximo puesto alcanzado, no se puede ascender más
    EXECUTE PC_Personas.modificar_empleado_ascenso(10000078);
    --Minimo puesto alcanzado, no se puede descender más. Sugerencia: Despedir
    EXECUTE PC_Personas.modificar_empleado_descenso(10000123);
    --CRUD; Productos
    --Solo se pueden eliminar productos caducados
    EXECUTE PC_Productos.eliminar_perecedero(10000002);
    --Solo se pueden eliminar productos cuya existencia sea 0
    EXECUTE PC_Productos.eliminar_noPerecedero(10001004);
--CICLO DOS
    --CRUD:Ventas
    --Solo se puede borrar una venta si ha pasado más de dos años desde su registro
    EXECUTE PC_Ventas.eliminar_ventas('V1004');

--XCRUD
--CICLO UNO
/*
--XCRUD
    DROP PACKAGE PC_Proveedores;
    DROP PACKAGE PC_Compras;
    DROP PACKAGE PC_Personas;
    DROP PACKAGE PC_Productos;
--CICLO DOS
    DROP PACKAGE PC_Ventas;
*/