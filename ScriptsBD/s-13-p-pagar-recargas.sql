-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

PROMPT Procedimiento 2: Se requiere actualizar el pago, que inicialmente es -1,
PROMPT de los servicios de recarga de scooters, para ello se deberá obtener el 
PROMPT total de un servicio tipo 'B' considerando el nivel de bateria de todos
PROMPT los scooters que fueron reemplazados, por cada scooter con un nivel de 
PROMPT carga equivalente al 100% se le pagará al usuario $200.

set serveroutput on
create or replace procedure sp_pagar_recargas(
  p_servicio_id     in  number
) is
  v_validador       number(1);
  v_num_recargas    number(2,0) := 0;
  v_tipo_servicio   char(1);
  v_precio_actual   number(8,3);
  v_precio          number(8,3) := 0;
  cursor cur_scooters is
    select rs.nivel_carga
    from servicio s
    join servicio_recarga sr
      on s.servicio_id = sr.servicio_id
    join recarga_scooter rs
      on sr.servicio_id = rs.servicio_id
    where s.servicio_id = p_servicio_id;
  cursor cur_usuario is
    select u.*
    from usuario u, servicio s
    where u.usuario_id = s.usuario_id
      and s.servicio_id = p_servicio_id;
begin
  select count(*) into v_validador
  from servicio
  where servicio_id = p_servicio_id;
  if v_validador = 0 then
    raise_application_error(-20000, 'ERROR: P_SERVICIO_ID invalido.');
  end if;
  select tipo_servicio into v_tipo_servicio
  from servicio
  where servicio_id = p_servicio_id;
  if v_tipo_servicio != 'B' then
    raise_application_error(-20001, 'ERROR: Tipo de Servicio incorrecto,'
      || ' se esperaba B, se obtuvo '
      || v_tipo_servicio || '.'
    );
  end if;
  select precio into v_precio_actual
  from servicio
  where servicio_id = p_servicio_id;
  if v_precio_actual != -1 then
    raise_application_error(-20002, 'ERROR: El Servicio ya ha sido pagado al usuario');
  end if;
  for r in cur_scooters loop
    v_num_recargas :=  v_num_recargas + 1;
    v_precio := v_precio + r.nivel_carga * 2;
  end loop;
  if v_num_recargas = 0 then
    raise_application_error(-20003, 'ERROR: No se encontro ningun scooter asociado al servicio.');
  end if;
  update servicio
  set precio = v_precio
  where servicio_id = p_servicio_id;
  dbms_output.put_line('PAGO POR CONCEPTO DE RECARGAS DE SCOOTERS');
  dbms_output.put_line('================================================================================');
  dbms_output.put_line('Servicio: ' || p_servicio_id);
  for r in cur_usuario loop
    dbms_output.put_line('Nombre del Usuario: ' 
    || r.nombre || ' '
    || r.ap_paterno || ' '
    || r.ap_materno );
    dbms_output.put_line('Correo electrónico: ' || r.email);
  end loop;
  dbms_output.put_line('Número de scooters recargados: ' || v_num_recargas);
  dbms_output.put_line('Total a pagar al usuario: ' || v_precio);
end;
/
show errors;

declare
begin
  sp_pagar_recargas(
    p_servicio_id   =>  631
  );
end;
/
rollback;