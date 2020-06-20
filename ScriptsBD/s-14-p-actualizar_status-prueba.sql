-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020



set serveroutput on


declare
  v_scooter_id  scooter.scooter_id%type; -- Scooter de prueba
  v_status_id   status.status_id%type;   -- Status esperado
begin
  dbms_output.put_line('Realizando Validación del Procediiento: sp_actualiza_status');
  select scooter_id into v_scooter_id
  from scooter
  where status_id = 2
  and rownum = 1;
  sp_actualiza_status(
    p_scooter_id  =>  v_scooter_id,
    p_status_id   =>  4 -- Bateria Baja
  );
  begin
    select status_id into v_status_id
    from scooter
    where scooter_id = v_scooter_id;
    if v_status_id != 4 then
      dbms_output.put_line('Validación 1, '
      || 'verficando nuevo status en la tabla Scooter   ->  ERROR.');
      raise_application_error(-20050, 'El status no corresponde con el status esperado');
    end if;
    dbms_output.put_line('Validación 1, '
      || 'verficando nuevo status en la tabla Scooter               ->  OK.');
  exception
    when others then
      raise;
  end;
  begin
    select status_id into v_status_id
    from hist_scooter_status
    where scooter_id = v_scooter_id
      and fecha_status = (
        select max(fecha_status)
        from hist_scooter_status
        where scooter_id = v_scooter_id
      );
    if v_status_id != 4 then
      dbms_output.put_line('Validación 2, '
      || 'verficando nuevo status en la tabla hist_scooter_status   ->  ERROR.');
      raise_application_error(-20050, 'El status no corresponde con el status esperado');
    end if;
    dbms_output.put_line('Validación 2, '
      || 'verficando nuevo status en la tabla hist_scooter_status   ->  OK.');
  exception
    when others then
      raise;
  end;
end;
/
rollback;