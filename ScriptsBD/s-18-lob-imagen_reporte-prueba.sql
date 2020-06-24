-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

PROMPT Realizando Prueba de la conversion de archivos a blob's.
select dbms_lob.getlength(dbst_load_a_file('scooter.png')) len_blob from dual;