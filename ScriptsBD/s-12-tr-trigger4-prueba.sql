-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT ROLLBACK
SET LINESIZE 200
DECLARE
  V_REEMPLAZO NUMBER:=0;
  V_REEMPLAZO_STATUS NUMBER:=0;
BEGIN
  UPDATE SCOOTER SET STATUS_ID = 5 WHERE SCOOTER_ID = 425;
  
  SELECT SCOOTER_REEMPLAZO_ID INTO V_REEMPLAZO FROM SCOOTER WHERE SCOOTER_ID = 425;
  SELECT STATUS_ID INTO V_REEMPLAZO_STATUS FROM SCOOTER WHERE SCOOTER_ID = V_REEMPLAZO;

  IF (V_REEMPLAZO IS NOT NULL) AND (V_REEMPLAZO_STATUS = 2) THEN
    DBMS_OUTPUT.PUT_LINE('PRUEBA 1: CAMBIAR STATUS A CON FALLAS Y ELEGIR UN SCOOTER REEMPLAZO DISPONIBLE -> OK!');
  ELSE
    RAISE_APPLICATION_ERROR(-20200,'HUBO PROBLEMAS CON EL TRIGGER');
  END IF;
  DBMS_OUTPUT.PUT_LINE('VALIDACION DEL TRIGGER CONCLUIDA -> OK!');
END;
/
ROLLBACK;
SET SERVEROUTPUT OFF
WHENEVER SQLERROR CONTINUE