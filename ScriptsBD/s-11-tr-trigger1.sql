-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

/*
Casos de estudio para evaluar con profesor:

-Excepciones: Fecha movida hacia clase padre entonces validar las 8 horas y los 14 días de los subtipos servicio.
Además al iniciar un servicio 
                              -> Insertar un cambio al historial del status del scooter
                              -> Actualizar el status del servicio del scooter a "en viaje" o "en renta" etc.
                              -> Al eliminar un servicio mandar ese registro a tabla externa "Eliminados"
                              
                              -> Asignar la recompensa de los 1000 puntos al usuario al mandar un insert reporte falla
                              -> Cambiar el status a fuera de zona al insertar una ubicación fuera del las coordenadas de la zona.


                              -> Cobrar el servicio. Al iniciar un servicio descontar primero los puntos ganados y que estén en fecha.
                              -> Fondos en tarjetas. 

                              ->Otros: checar la validez de las claves o tarjetas de crédito.
                              
                              -> Al momento de añadir un scooter de reemplazo que este se encuentre "disponible"
                              -> Checar que los status de los scooters pasen por los diagramas de estados
*/


/*  
    Primer trigger: Checar la fecha de insersión sea con respecto al caso de estudio.
    Segundo trigger: INICIAR SERVICIO. -> CAMBIAR STATUS DEL SCOOTER, QUITAR MONEY O CRÉDITO.
    TERCER TRIGGER: VERIFICAR QUE LA TARJETA DE CRÉDITO TENGA FONDOS
    CUARTO: ASIGNAR FUERA DE ZONA AL INSERTAR COORDENADAS
    QUINTO: VERIFICAR QUE EL SCOOTER NO SE ENCUENTRA EN OTRO SERVICIO EN CURSO.
*/

CREATE OR REPLACE TRIGGER COBRAR
BEFORE INSERT OR UPDATE ON SERVICIO
FOR EACH ROW
DECLARE
  V_PUNTOS NUMBER:=0;
  V_MES_EXPIRA NUMBER:=0;
  V_ANIO_EXPIRA NUMBER:=0;
BEGIN
SELECT PUNTOS INTO V_PUNTOS FROM USUARIO WHERE USUARIO_ID = :NEW.USUARIO_ID;
IF V_PUNTOS > :NEW.PRECIO THEN
    UPDATE USUARIO SET PUNTOS = PUNTOS - :NEW.PRECIO WHERE USUARIO_ID = :NEW.USUARIO_ID;
ELSE
  SELECT MES_EXPIRACION INTO V_MES_EXPIRA FROM TARJETA_CLIENTE WHERE USUARIO_ID = :NEW.USUARIO_ID;
  SELECT ANIO_EXPIRACION INTO V_ANIO_EXPIRA FROM TARJETA_CLIENTE WHERE USUARIO_ID = :NEW.USUARIO_ID;
  IF V_MES_EXPIRA  < EXTRACT(MONTH FROM SYSDATE) AND V_ANIO_EXPIRA < EXTRACT(YEAR FROM SYSDATE) THEN
      RAISE_APPLICATION_ERROR(-20001, 'LA TARJETA DE CRÉDITO NO SE ENCUENTRA VIGENTE.');
  END IF;
END IF;
END;
/

CREATE OR REPLACE TRIGGER DISPONIBILIDAD_SCOOTER_VIAJE
BEFORE INSERT OR UPDATE ON SERVICIO_VIAJE
FOR EACH ROW
DECLARE
  V_STATUS NUMBER:=0;
BEGIN
  SELECT STATUS_ID INTO V_STATUS FROM SCOOTER WHERE SCOOTER_ID = :NEW.SCOOTER_ID;
  IF V_STATUS != 2 THEN
    RAISE_APPLICATION_ERROR(-20002, 'EL SCOOTER NO SE ENCUENTRA DISPONIBLE PARA VIAJE');
  END IF;
END;

CREATE OR REPLACE TRIGGER DISPONIBILIDAD_SCOOTER_RENTA
BEFORE INSERT OR UPDATE ON SERVICIO_RENTA
FOR EACH ROW
DECLARE
  V_STATUS NUMBER:=0;
BEGIN
  SELECT STATUS_ID INTO V_STATUS FROM SCOOTER WHERE SCOOTER_ID = :NEW.SCOOTER_ID;
  IF V_STATUS != 2 THEN
    RAISE_APPLICATION_ERROR(-20003, 'EL SCOOTER NO SE ENCUENTRA DISPONIBLE PARA RENTA');
  END IF;
END;

CREATE OR REPLACE TRIGGER DISPONIBILIDAD_SCOOTER_RECARGA
BEFORE INSERT OR UPDATE ON RECARGA_SCOOTER
FOR EACH ROW
DECLARE
  V_STATUS NUMBER:=0;
BEGIN
  SELECT STATUS_ID INTO V_STATUS FROM SCOOTER WHERE SCOOTER_ID = :NEW.SCOOTER_ID;
  IF V_STATUS != 1 OR V_STATUS != 2 OR V_STATUS != 4 THEN
    RAISE_APPLICATION_ERROR(-20004, 'EL SCOOTER NO SE ENCUENTRA DISPONIBLE PARA REALIZAR RECARGA');
  END IF;
END;


CREATE OR REPLACE TRIGGER DIAS_CUSTODIA_TRG
AFTER INSERT OR UPDATE ON SERVICIO
FOR EACH ROW
DECLARE
 V_DIAS_CUSTODIA NUMBER:=0;
 V_EXCENTO SERVICIO_VIAJE.SERVICIO_ID%TYPE;
BEGIN
  SELECT SERVICIO_ID INTO V_EXCENTO FROM SERVICIO_VIAJE WHERE SERVICIO_ID = :NEW.SERVICIO_ID;
  IF :NEW.TIPO_SERVICIO = 'R' AND V_EXCENTO IS NOT NULL THEN
    UPDATE SERVICIO_RENTA SET DIAS_CUSTODIA = TRUNC(:NEW.FECHA_FIN) - TRUNC(:NEW.FECHA_INICIO);
  END IF;
END;
/


CREATE OR REPLACE PROCEDURE CORREGIR_DIAS_CUSTODIA
CUR CUR_DIAS
BEGIN

END;