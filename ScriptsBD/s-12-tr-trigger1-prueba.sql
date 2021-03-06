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
  SELECT PUNTOS INTO V_PUNTOS_ANTES FROM USUARIO WHERE USUARIO_ID = 371;
  INSERT INTO SERVICIO VALUES(5000, 371, 100, 
  TO_DATE('22/06/2020 09:34:12','dd/mm/yyyy hh24:mi:ss'), 
  TO_DATE('24/06/2020 10:08:37','dd/mm/yyyy hh24:mi:ss'), 'R');
  SELECT PUNTOS INTO V_PUNTOS_DESPUES FROM USUARIO WHERE USUARIO_ID = 371;
  IF V_PUNTOS_ANTES = V_PUNTOS_DESPUES + 100 THEN
    DBMS_OUTPUT.PUT_LINE('PRUEBA 1: INICIAR SERVICIO A USUARIO CON PUNTOS SUFICIENTES -> OK!');
  ELSE
    RAISE_APPLICATION_ERROR(-20033,'NO SE REALIZÓ EL COBRO');
  END IF;
  SELECT PUNTOS INTO V_PUNTOS_ANTES FROM USUARIO WHERE USUARIO_ID = 200;
  INSERT INTO SERVICIO 
  (SERVICIO_ID, USUARIO_ID, PRECIO, FECHA_INICIO, FECHA_FIN,TIPO_SERVICIO) 
  VALUES(5002, 200, 100, TO_DATE('22/06/2020 10:30:21','dd/mm/yyyy hh24:mi:ss'), 
  TO_DATE('25/06/2020 13:54:04','dd/mm/yyyy hh24:mi:ss'), 'R');
  SELECT PUNTOS INTO V_PUNTOS_DESPUES FROM USUARIO WHERE USUARIO_ID = 200;
  DBMS_OUTPUT.PUT_LINE('PRUEBA 2: INICIAR SERVICIO A USUARIO SIN PUNTOS PERO TARJETA VIGENTE -> OK!');

  INSERT INTO SERVICIO (SERVICIO_ID, USUARIO_ID, PRECIO, FECHA_INICIO, FECHA_FIN,TIPO_SERVICIO) 
  VALUES(5004, 13, 1200, TO_DATE('21/06/2020 10:30:21','dd/mm/yyyy hh24:mi:ss'), TO_DATE('26/06/2020 10:54:04','dd/mm/yyyy hh24:mi:ss'), 'B');
  
  DBMS_OUTPUT.PUT_LINE('PRUEBA 3: INICIAR SERVICIO DE RECARGA DE BATERIA SIN PROBLEMA ALGUNO -> OK!');

  INSERT INTO SERVICIO (SERVICIO_ID, USUARIO_ID, PRECIO, FECHA_INICIO, FECHA_FIN,TIPO_SERVICIO) 
  VALUES(5003, 13, 120, TO_DATE('23/06/2020 10:30:21','dd/mm/yyyy hh24:mi:ss'), TO_DATE('24/06/2020 13:54:04','dd/mm/yyyy hh24:mi:ss'), 'R');

EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20145 THEN
      DBMS_OUTPUT.PUT_LINE('PRUEBA 4: SE GENERO ERROR ESPERADO -20145 AL QUERER INICIAR SERVICIO CON TARJETA VENCIDA O TARJETA NO EXISTENTE -> OK!');
      DBMS_OUTPUT.PUT_LINE('VALIDACION DEL TRIGGER 1 -> OK!');
    ELSE
      RAISE;
  END IF;
END;
/
ROLLBACK;
SET SERVEROUTPUT OFF
WHENEVER SQLERROR CONTINUE