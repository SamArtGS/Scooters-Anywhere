-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

CREATE OR REPLACE TRIGGER REEMPLAZAR_SCOOTER
FOR INSERT OR DELETE OR UPDATE OF SCOOTER_REEMPLAZO_ID ON SCOOTER
COMPOUND TRIGGER
DECLARE

  BEFORE STATEMENT IS
  BEGIN
  SELECT * FROM 
  NULL;
  END BEFORE STATEMENT;

  BEFORE EACH ROW IS
  BEGIN 
  NULL;
  END BEFORE EACH ROW;


  AFTER EACH ROW IS
  BEGIN
  NULL;
  END AFTER EACH ROW;


  AFTER STATEMENT IS
  BEGIN
  NULL;
  END AFTER STATEMENT;

END REEMPLAZAR_SCOOTER;