-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

PROMPT ================================================================================
PROMPT Realizando Validación del Procediento: sp_pagar_recargas
PROMPT ================================================================================

set serveroutput on

declare
  v_servicio_id     number(10,0) := 0;
  v_usuario_id      number(10,0);
  v_scooter_id      number(10,0);
  v_precio          number(10,2);
begin
  begin
    sp_pagar_recargas(
      p_servicio_id => null
    );
    dbms_output.put_line('Validación 1, P_SERVICIO_ID no acepta valores nulos                   ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20000) then
        dbms_output.put_line('Validación 1, P_SERVICIO_ID no acepta valores nulos                   ->     OK.');
      else
        raise;
      end if;
  end;
  begin
    sp_pagar_recargas(
      p_servicio_id => -1
    );
    dbms_output.put_line('Validación 2, P_SERVICIO_ID debe ser un servicio valido               ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20000) then
        dbms_output.put_line('Validación 2, P_SERVICIO_ID no acepta valores nulos                   ->     OK.');
      else
        raise;
      end if;
  end;
  -- Generar servicio aleatorio donde ya se haya fijado el pago al cliente;
  select max(servicio_id) + 1 into v_servicio_id
  from servicio;
  select u.usuario_id into v_usuario_id
  from usuario u, servicio s
  where u.usuario_id = s.usuario_id
    and fecha_fin < sysdate
    and rownum = 1;
  insert into servicio(servicio_id, precio, fecha_inicio, fecha_fin, 
    tipo_servicio, usuario_id)
  values(v_servicio_id, 500, sysdate -10, sysdate, 'B', v_usuario_id);
  insert into servicio_recarga (servicio_id, nombre_banco, clabe_interbancaria)
  values(v_servicio_id, 'BBVA', 562252896320472842);
  begin
    sp_pagar_recargas(
      p_servicio_id => v_servicio_id
    );
    dbms_output.put_line('Validación 3, PS_PAGAR_RECARGAS no efectua dos veces un pago          ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20002) then
        dbms_output.put_line('Validación 3, PS_PAGAR_RECARGAS no efectua dos veces un pago          ->     OK.');
      else
        raise;
      end if;
  end;
  update servicio
  set precio = -1
  where servicio_id = v_servicio_id;
  begin
    sp_pagar_recargas(
      p_servicio_id => v_servicio_id
    );
    dbms_output.put_line('Validación 4, PS_PAGAR_RECARGAS sólo efectua pagos con scooters       ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20003) then
        dbms_output.put_line('Validación 4, PS_PAGAR_RECARGAS sólo efectua pagos con scooters       ->     OK.');
      else
        raise;
      end if;
  end;
  for i in 1..dbms_random.value(2,20) loop
    select scooter_id into v_scooter_id
    from scooter
    where status_id = 4
      and rownum = 1;
    insert into recarga_scooter(servicio_id, scooter_id, nivel_carga)
    values(v_servicio_id, v_scooter_id, dbms_random.value(80, 100));
    sp_actualiza_status(
      p_scooter_id  =>  v_scooter_id,
      p_status_id   =>  7 -- Bateria Baja
    );
  end loop;
  sp_pagar_recargas(
      p_servicio_id => v_servicio_id
    );
  select precio into v_precio
  from servicio
  where servicio_id = v_servicio_id;
  if v_precio != -1 then
    dbms_output.put_line('Validación 5, Pago efectuado                                          ->     OK.');
  else
    dbms_output.put_line('Validación 5, Pago efectuado                                          ->  ERROR.');
  end if;

end;
/
rollback;