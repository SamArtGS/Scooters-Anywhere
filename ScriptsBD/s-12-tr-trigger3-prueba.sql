-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT ROLLBACK

DECLARE
  V_PUNTOS_ANTES NUMBER:=0;
  V_PUNTOS_DESPUES NUMBER:=0;
BEGIN
  SELECT PUNTOS INTO V_PUNTOS_ANTES 
  FROM USUARIO WHERE USUARIO_ID = 33;
  DELETE TARJETA_CLIENTE WHERE USUARIO_ID = 33;
  SELECT PUNTOS INTO V_PUNTOS_DESPUES 
  FROM USUARIO WHERE USUARIO_ID = 33;
  IF V_PUNTOS_ANTES = V_PUNTOS_DESPUES + 50 THEN
    DBMS_OUTPUT.PUT_LINE('PRUEBA 1: AL REMOVER TARJETA CLIENTE SE LE PENALIZA CON -50 PUNTOS -> OK!');
  ELSE
    RAISE_APPLICATION_ERROR(-20033,'NO SE REALIZÓ LA PENALIZACIÓN');
  END IF;
  INSERT INTO TARJETA_CLIENTE VALUES(33,3545022661144556,5,24);
  DBMS_OUTPUT.PUT_LINE('PRUEBA 2: INSERTAR TARJETA CLIENTE VIGENTE -> OK!');
  UPDATE TARJETA_CLIENTE SET ANIO_EXPIRACION = 22;
  DBMS_OUTPUT.PUT_LINE('PRUEBA 3: ACTUALIZAR DATOS TARJETA VIGENTES -> OK!');
  INSERT INTO TARJETA_CLIENTE VALUES(255,3545021331445560,5,19);
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20040 THEN
      DBMS_OUTPUT.PUT_LINE('PRUEBA 4: ERROR - INSERTAR TARJETA EXPIRADA -> OK!');
      DBMS_OUTPUT.PUT_LINE('VALIDACION DEL TRIGGER CONCLUIDA -> OK!');
    ELSE
      RAISE;
  END IF;
END;
/
ROLLBACK;
SET SERVEROUTPUT OFF
WHENEVER SQLERROR CONTINUE