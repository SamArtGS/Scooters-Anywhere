-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

/*
Casos de estudio para evaluar con profesor:

-Excepciones: Fecha movida hacia clase padre entonces validar las 8 horas y los 14 días de los subtipos servicio.
Además al iniciar un servicio -> Insertar un cambio al historial del status del scooter
                              -> Actualizar el status del servicio del scooter a "en viaje" o "en renta" etc.
                              -> Al eliminar un servicio mandar ese registro a tabla externa "Eliminados"
                              
                              -> Asignar la recompensa de los 1000 puntos al usuario al mandar un insert reporte falla
                              -> Cambiar el status a fuera de zona al insertar una ubicación fuera del las coordenadas de la zona.
                              -> Cobrar el servicio. Al iniciar un servicio descontar primero los puntos ganados y que estén en fecha.
                              
                              ->Otros: checar la validez de las calves o tarjetas de crédito.
                              -> Al momento de añadir un scooter de reemplazo que este se encuentre "disponible"
                              -> Checar que los status de los scooters pasen por los diagramas de estados


*/

CREATE OR REPLACE TRIGGER INICIAR_SERVICIO AFTER INSERT ON SERVICIO
  FOR EACH ROW
DECLARE
  E_EXCEPTION_1 EXCEPTION;
  E_ERROR_INMUEBLE EXCEPTION;
  V_CLIENTE_AVAL NUMBER;

SELECT INMUEBLE_ID,CLIENTE_ID,STATUS_INMUEBLE_ID FROM INMUEBLE WHERE CLIENTE_ID = P_AVAL_CLIENTE;
  V_PAGADO NUMBER;
BEGIN
   
SHOW ERRORS;