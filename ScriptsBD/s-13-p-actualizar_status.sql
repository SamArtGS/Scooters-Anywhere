-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

PROMPT Procedimiento 1: Se desea poder actualizar el status de un scooter 
PROMPT sin tener que hacer manualmente las actualizaciones en la tabla scooter
PROMPT ni las inserciones en la tabla his_scooter_status, para ello basta con
PROMPT proporcionar el id del scooter y el id del nuevo status.



set serveroutput on
create or replace procedure sp_actualiza_status(
  p_scooter_id    in  number,
  p_status_id     in number
) is
begin
  insert into hist_scooter_status (hist_scoo_status_id, status_id, scooter_id, 
    fecha_status)
  values(seq_hist_scooter_status.nextval, p_status_id, p_scooter_id, sysdate);
  update scooter
  set status_id = p_status_id,
    fecha_status = sysdate
  where scooter_id = p_scooter_id;
exception
  when others then
    dbms_output.put_line('ERROR: Al actualizar status');
    raise;
end;
/
