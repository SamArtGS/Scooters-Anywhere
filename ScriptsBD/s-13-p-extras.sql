-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

CREATE OR REPLACE PROCEDURE CORREGIR_DIAS_CUSTODIA IS
V_FECHA_INICIO DATE;
V_FECHA_FIN DATE;
CURSOR CUR_SERV_RENTA IS  
  SELECT * FROM SERVICIO_RENTA;
BEGIN
  FOR R IN CUR_SERV_RENTA LOOP
    SELECT FECHA_INICIO INTO V_FECHA_INICIO FROM SERVICIO WHERE SERVICIO_ID = R.SERVICIO_ID;
    SELECT FECHA_FIN INTO V_FECHA_FIN FROM SERVICIO WHERE SERVICIO_ID = R.SERVICIO_ID;
    UPDATE SERVICIO_RENTA SET DIAS_CUSTODIA = (TRUNC(V_FECHA_FIN) - TRUNC(V_FECHA_INICIO)) WHERE SERVICIO_ID = R.SERVICIO_ID;
  END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE TERMINAR_SERVICIO(SCOOTER_ID NUMBER) IS
  V_FECHA_FIN DATE;
BEGIN
  UPDATE SCOOTER SET STATUS_ID = 1 WHERE SCOOTER_ID = SCOOTER_ID;
  UPDATE SERVICIO SET FECHA_FIN=SYSDATE WHERE SCOOTER_ID = SCOOTER_ID;
END;
/
