--@Autor: Jorge Cárdenas Cárdenas - Samuel Arturo Garrido Sanchez
--@Fecha creación: 05/06/2020
--@Descripción: Proyecto, Creación de usuarios y roles


whenever sqlerror exit
set feedback off

Prompt Conectando como administrador
connect scooters_admin@PROYECTO/samjor123

-----------------------------Código de Limpieza--------------------------------
declare 
  cursor cur_usuarios is
    select username from dba_users where username like 'CG_PROY_%';
  cursor cur_roles is 
    select role from dba_roles where role like 'ROL_%';
begin
  for r in cur_usuarios loop
    execute immediate 'drop user ' ||r.username||' cascade';
  end loop;
  for r in cur_roles loop
    execute immediate 'drop role ' ||r.role;
  end loop;
end;
/

-------------------------------------------------------------------------------

-- Creando Roles
create role rol_admin;
grant create session, create table, create view, create sequence, 
  create procedure to rol_admin;
create role rol_invitado;
grant create session to rol_invitado;

--Creando Usuarios
create user cg_proy_admin identified by samjor quota unlimited on users;
create user cg_proy_invitado identified by samjor quota unlimited on users;

-- Asignando roles 
grant rol_admin to cg_proy_admin;
grant rol_invitado to cg_proy_invitado;

set feedback on

Prompt Creación de usuarios exitosa :)

connect cg_proy_admin/samjor

prompt Conectado a cg_proy_admin

@s-02-entidades.SQL

Prompt Creación de tablas exitosa

whenever sqlerror continue

