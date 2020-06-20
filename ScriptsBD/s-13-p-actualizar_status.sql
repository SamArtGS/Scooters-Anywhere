-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020



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