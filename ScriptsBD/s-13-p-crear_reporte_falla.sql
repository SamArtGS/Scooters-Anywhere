-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020



set serveroutput on


create or replace procedure sp_crear_reporte_falla(
  p_latitud       in  number  default null,
  p_longitud      in  number  default null,
  p_descripcion   in  varchar,
  p_usuario_id    in  number,
  p_scooter_id    in  number,
  p_reporte_falla_id  out number
) is
  v_count_img     number(1,0) := 0;
  v_validador     number(1,0);
  cursor cur_imagenes is
    select imagen
    from t_imagen_reporte
    where usuario_id = p_usuario_id
      and scooter_id = p_usuario_id;
begin
  select count(*) into v_validador
  from usuario
  where usuario_id = p_usuario_id;
  if v_validador = 0 then
    raise_application_error(-20000, 'ERROR: P_USUARIO_ID invalido');
  end if;
  select count(*) into v_validador
  from scooter
  where scooter_id = p_scooter_id;
  if v_validador = 0 then
    raise_application_error(-20001, 'ERROR: P_SCOOTER invalido');
  end if;
  if p_descripcion is null then
    raise_application_error(-20002, 'ERROR: P_DESCRIPCION es nulo');
  end if;
  insert into reporte_falla (reporte_falla_id, fecha_reporte, latitud, longitud,
  descripcion, usuario_id, scooter_id)
  values (seq_reporte_falla.nextval, sysdate, p_latitud, p_longitud,
  p_descripcion, p_usuario_id, p_scooter_id);
  for r in cur_imagenes loop
    insert into imagen_reporte (imagen_reporte_id, imagen, reporte_falla_id)
    values (seq_imagen_reporte.nextval, dbst_load_a_file(r.imagen),
      seq_reporte_falla.currval);
    v_count_img := v_count_img + 1;
    exit when v_count_img = 5; 
  end loop;
  delete from t_imagen_reporte 
  where usuario_id = p_usuario_id and scooter_id = p_scooter_id;
p_reporte_falla_id := seq_reporte_falla.currval;
end;
/
show errors;