--@Autor: Jorge Cárdenas Cárdenas - Samuel Arturo Garrido Sanchez
--@Fecha creación: 05/06/2020
--@Descripción: Proyecto, Creación de usuarios y roles


whenever sqlerror exit
set feedback off

Prompt Conectando como administrador
connect scooters_admin/samjor123

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
grant create session, create table, create view, create sequence,create synonym,create database link, create trigger,create procedure,DROP ANY DIRECTORY to rol_admin;
GRANT execute ON rdsadmin.rdsadmin_util TO rol_admin;
GRANT CREATE PUBLIC SYNONYM TO rol_admin;
create role rol_invitado;
grant create session, create synonym ,create view to rol_invitado;


--Creando Usuarios
create user cg_proy_admin identified by samjor quota unlimited on users;
create user cg_proy_invitado identified by samjor quota unlimited on users;

-- Asignando roles 
grant rol_admin to cg_proy_admin;
grant rol_invitado to cg_proy_invitado;

whenever sqlerror continue

