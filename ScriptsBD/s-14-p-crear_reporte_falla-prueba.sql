-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

PROMPT ================================================================================
PROMPT Realizando Validación del Procediento: sp_crear_reporte_falla
PROMPT ================================================================================

set serveroutput on

declare
  v_reporte_falla_id  number(10,0);
  v_count             number(1,0);
begin
  begin
    sp_crear_reporte_falla(
      p_descripcion       =>  null,
      p_usuario_id        =>  100,
      p_scooter_id        =>  100,
      p_reporte_falla_id  =>  v_reporte_falla_id
    );
    dbms_output.put_line('Validación 1, P_DESCRIPCION no acepta valores nulos                   ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20002) then
        dbms_output.put_line('Validación 1, P_DESCRIPCION no acepta valores nulos                   ->     OK.');
      else
        raise;
      end if;
  end;
  begin
    sp_crear_reporte_falla(
      p_descripcion       =>  'Probando Reporte de Fallas',
      p_usuario_id        =>  null,
      p_scooter_id        =>  1,
      p_reporte_falla_id  =>  v_reporte_falla_id
    );
    dbms_output.put_line('Validación 2, P_USUARIO_ID no acepta valores nulos                    ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20000) then
        dbms_output.put_line('Validación 2, P_USUARIO_ID no acepta valores nulos                    ->     OK.');
      else
        raise;
      end if;
  end;
  begin
    sp_crear_reporte_falla(
      p_descripcion       =>  'Probando Reporte de Fallas',
      p_usuario_id        =>  -1,
      p_scooter_id        =>  100,
      p_reporte_falla_id  =>  v_reporte_falla_id
    );
    dbms_output.put_line('Validación 3, P_USUARIO_ID es un usuario valido                       ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20000) then
        dbms_output.put_line('Validación 3, P_USUARIO_ID es un usuario valido                       ->     OK.');
      else
        raise;
      end if;
  end;
  begin
    sp_crear_reporte_falla(
      p_descripcion       =>  'Probando Reporte de Fallas',
      p_usuario_id        =>  100,
      p_scooter_id        =>  null,
      p_reporte_falla_id  =>  v_reporte_falla_id
    );
    dbms_output.put_line('Validación 4, P_SCOOTER no acepta valores nulos                       ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20001) then
        dbms_output.put_line('Validación 4, P_SCOOTER no acepta valores nulos                       ->     OK.');
      else
        raise;
      end if;
  end;
  begin
    sp_crear_reporte_falla(
      p_descripcion       =>  'Probando Reporte de Fallas',
      p_usuario_id        =>  100,
      p_scooter_id        =>  null,
      p_reporte_falla_id  =>  v_reporte_falla_id
    );
    dbms_output.put_line('Validación 5, P_SCOOTER debe ser un scooter valido                    ->  ERROR.');
  exception
    when others then
      if(sqlcode = -20001) then
        dbms_output.put_line('Validación 5, P_SCOOTER debe ser un scooter valido                    ->     OK.');
      else
        raise;
      end if;
  end;
  -- Cargando imagenes en la tabla temporal
  for i in 1..dbms_random.value(0,5) loop
    insert into t_imagen_reporte (usuario_id, scooter_id, imagen)
    values(100, 100, 'Hola');
  end loop;
  sp_crear_reporte_falla(
    p_descripcion       =>  'Probando Reporte de Fallas',
    p_usuario_id        =>  100,
    p_scooter_id        =>  100,
    p_reporte_falla_id  =>  v_reporte_falla_id
  );
  select count(1) into v_count
  from reporte_falla
  where reporte_falla_id = v_reporte_falla_id;
  if v_count = 0 then
    dbms_output.put_line('Validación 6, Reporte Registrado en la tabla REPORTE_FALLA            ->  ERROR.');
  else
    dbms_output.put_line('Validación 6, Reporte Registrado en la tabla REPORTE_FALLA            ->     OK.');
  end if;
end;
/
rollback;