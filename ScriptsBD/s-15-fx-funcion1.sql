-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

/*
FUNCIÓN: CALCULAR CUÁNTO LE QUEDA DE GANANCIA A LA COMPAÑÍA EN UN MES DE DETERMINADO AÑO
DESPUÉS DE:
    - SI ES MES 6 O 12 SE RECORTA EL 10% PARA PAGOS DE PERSONAL
    - SI ES GOBIERTO DE 'LA 4T' SE COBRA MÁS IMPUESTOS
    - POR CADA REPARACIÓN DE SCOOTER SE PAGAN 50 PESOS
    - AL FINAL TODO SE LE RESTA A LAS GANACIAS BRUTAS QUE SE OBTUVIERON EN EL MES
    - SE MANDA ESTE NÚMERO DE VUELTA.
*/

CREATE OR REPLACE FUNCTION FN_UTILIDAD(MES NUMBER, ANIO NUMBER,GOBIERNO VARCHAR2) RETURN NUMBER
IS
  V_IVA NUMBER;
  V_IMP_RENTA NUMBER;
  V_GASTOS NUMBER;
  V_GANANCIAS NUMBER;
  V_PERDIDAS NUMBER;
  CURSOR CUR_GANACIAS(MES NUMBER,ANIO NUMBER) IS
    SELECT FECHA_INICIO, PRECIO FROM SERVICIO 
    WHERE EXTRACT(MONTH FROM FECHA_INICIO) = MES AND 
    EXTRACT(YEAR FROM FECHA_INICIO) = ANIO
    AND (TIPO_SERVICIO = 'V' OR TIPO_SERVICIO='R');
BEGIN
    FOR R IN CUR_GANACIAS(MES,ANIO) LOOP
        IF EXTRACT(MONTH FROM R.FECHA_INICIO) = 6 OR  EXTRACT(MONTH FROM R.FECHA_INICIO) =  12 THEN
        --GANANCIAS SE REDUCEN EN VACACIONES O FIN DE AÑO PARA PAGO DE EMPLEADOS
          V_GANANCIAS := V_GANANCIAS + R.PRECIO*0.90;
        END IF;
        V_GANANCIAS := V_GANANCIAS + R.PRECIO;
    END LOOP;
    IF GOBIERNO = 'LA 4T' THEN
        V_IMP_RENTA := V_GANANCIAS*0.5;
        V_IVA := V_GANANCIAS*0.16;
    ELSE
        V_IMP_RENTA := V_GANANCIAS*0.2;
        V_IVA := V_GANANCIAS*0.1;
    END IF;
    SELECT COUNT(*) INTO V_PERDIDAS FROM HIST_SCOOTER_STATUS 
    WHERE EXTRACT(MONTH FROM FECHA_STATUS) = MES 
    AND EXTRACT(YEAR FROM FECHA_STATUS) = ANIO 
    AND STATUS_ID = 5;
    V_GANANCIAS := V_GANANCIAS - V_PERDIDAS*50 - V_IMP_RENTA - V_IVA;
    RETURN V_GANANCIAS;
END;
/