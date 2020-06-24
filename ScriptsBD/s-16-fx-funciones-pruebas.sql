-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

SET SERVEROUTPUT ON
SET LINESIZE 200
WHENEVER SQLERROR EXIT ROLLBACK

BEGIN
  DBMS_OUTPUT.PUT_LINE('FUNCIÓN 1: CHECAR GANACIAS NETAS EN UN MES DADO UN GOBIERNO');
  DBMS_OUTPUT.PUT_LINE('EN ABRIL DEL 2020 CON EL PRI LAS GANANCIAS ES: $'||FN_UTILIDAD(5,2020,'EL PRI')||' MXN');
  DBMS_OUTPUT.PUT_LINE('EN JUNIO DEL 2020 CON LA 4T LAS GANANCIAS ES: $' ||FN_UTILIDAD(6,2020,'EL PRI')||' MXN');
  DBMS_OUTPUT.PUT_LINE(' ');
  DBMS_OUTPUT.PUT_LINE('FUNCIÓN 2: CHECAR EN QUÉ PROMOCION GASTA LA COMPANIA MAS PUNTOS');
  DBMS_OUTPUT.PUT_LINE('EN LA PRIMERA PROMOCION SE DARAN: '||FN_CLIENTES_FAVORITOS(1,4,2020)||' PUNTOS');
  DBMS_OUTPUT.PUT_LINE('EN LA SEGUNDA PROMOCION SE DARAN: '||FN_CLIENTES_FAVORITOS(2,4,2020)||' PUNTOS');
  DBMS_OUTPUT.PUT_LINE('EN LA TERCERA PROMOCION SE DARAN: '||FN_CLIENTES_FAVORITOS(3,4,2020)||' PUNTOS');
  DBMS_OUTPUT.PUT_LINE(' ');
  --DBMS_OUTPUT.PUT_LINE('EL FOLIO GENERADO POR UN USUARIO ES: ' ||FN_FOLIO(60,SYSDATE,'SAMUEL','GARRIDO','SANCHEZ'));
END;
/