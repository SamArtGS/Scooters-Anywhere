-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

CREATE OR REPLACE TRIGGER 
FOR INSERT OR DELETE ON TABLE1
COMPOUND TRIGGER
  TYPE NUMBER_TABLE IS TABLE OF NUMBER;
  tblTABLE2_IDS  NUMBER_TABLE;

  BEFORE STATEMENT IS
  BEGIN
    tblTABLE2_IDS := NUMBER_TABLE();
  END BEFORE STATEMENT;

  AFTER EACH ROW IS
  BEGIN
    IF INSERTING THEN
      UPDATE TABLE2 t2
        SET    t2.TABLE2NUM = :new.NUM
        WHERE  t2.ID = :new.TABLE2_ID;
    ELSIF DELETING THEN
      tblTABLE2_IDS.EXTEND;
      tblTABLE2_IDS(tblTABLE2_IDS.LAST) := :new.TABLE2_ID;
    END IF;
  END AFTER EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF tblTABLE2_IDS.COUNT > 0 THEN
      FOR i IN tblTABLE2_IDS.FIRST..tblTABLE2_IDS.LAST LOOP
        UPDATE TABLE2 t2
          SET t2.TABLE2NUM = (SELECT NUM
                                FROM (SELECT t1.NUM
                                        FROM TABLE1 t1
                                        WHERE t1.TABLE2_ID = tblTABLE2_IDS(i) 
                                        ORDER BY modification_date DESC)
                                WHERE ROWNUM = 1)
          WHERE t2.ID = tblTABLE2_IDS(i);
      END LOOP;
    END IF;
  END AFTER STATEMENT;
END TABLE1_NUM_TRG;