-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020



set serveroutput on format wrapped


create or replace procedure sp_crear_servicio_recarga(
  p_usuario_id      in  number,
  p_fecha_fin       in  date,
  p_nombre_banco    in  varchar2,
  p_clabe_inter     in  number,
  p_num_scooters    in  number
) is
  cursor cur_scooters_carga is
    select scooter_id
    from scooter
    where status_id = 4   -- Bateria Baja
      and rownum = p_num_scooters;
  v_bateria_actual  number(3,0);
  v_nombre          usuario.nombre%type;
  v_ap_parterno     usuario.ap_paterno%type;
  v_ap_materno      usuario.ap_materno%type;
  v_validador       number(1,0);
begin
  if p_usuario_id is null then
    raise_application_error(-20020, 'ERROR: P_USUARIO_ID contiene valores nulos');
  end if;
  select count(1) into v_validador
  from usuario
  where usuario_id = p_usuario_id;
  if v_validador = 0 then
    raise_application_error(-20021, 'ERROR: USUARIO_ID no existe');
  end if;
  open cur_scooters_carga;
  if cur_scooters_carga%rowcount = 0 then
    raise_application_error(-20022, 'Actualmente no hay scooters para recargar');
  end if;
  close cur_scooters_carga;
  insert into servicio (servicio_id, usuario_id, precio, fecha_inicio, fecha_fin,
    tipo_servicio)
  values (seq_servicio.nextval, p_usuario_id, 1000, sysdate, p_fecha_fin, 'B');
  insert into servicio_recarga (servicio_id, nombre_banco, clabe_interbancaria)
  values (seq_servicio.currval, p_nombre_banco, p_clabe_inter);

  select nombre, ap_paterno, ap_materno 
  into v_nombre, v_ap_parterno, v_ap_materno
  from usuario
  where usuario_id = p_usuario_id;
  dbms_output.put_line('Scooter_id     ->     Nivel de Bateria');
  for r in cur_scooters_carga loop
    v_bateria_actual := dbms_random.value(20, 40);
    actualiza_status(r.scooter_id, 7); -- Servicio Carga
    -- insert into recarga_scooter (servicio_id, scooter_id, nivel_carga)
    -- values (seq_servicio.currval, r.scooter_id, v_bateria_actual);
    dbms_output.put_line(lpad(to_char(r.scooter_id), 10)
      || '     ->     ' || v_bateria_actual);
  end loop;
  dbms_output.put_line('');
  dbms_output.put_line('Datos del Usuario: ');
  dbms_output.put_line('  Usuario_id : ' || p_usuario_id);
  dbms_output.put_line('  Nombre     : ' || v_nombre || ' ' || v_ap_parterno || ' '
    
  );
  dbms_output.put_line('Servicio Registrado !!!');
end;
/
show errors;