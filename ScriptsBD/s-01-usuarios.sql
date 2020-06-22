-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020


whenever sqlerror exit rollback;
set feedback off

Prompt Conectando como administrador

--connect sys/proteco123 as sysdba;
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
grant create session, create table, create view, create 
  sequence,create synonym,create database link, 
  create trigger,create procedure,DROP ANY DIRECTORY to rol_admin;
GRANT execute ON rdsadmin.rdsadmin_util TO rol_admin;
grant execute on rdsadmin.rds_file_util to rol_admin
GRANT CREATE PUBLIC SYNONYM TO rol_admin;
create role rol_invitado;
grant create session, create synonym ,create view to rol_invitado;


--Creando Usuarios
create user prueba_sam_admin identified by samjor quota unlimited on users;
create user prueba_sam_invitado identified by samjor quota unlimited on users;

-- Asignando roles
grant rol_admin to prueba_sam_admin;
grant rol_invitado to prueba_sam_invitado;

whenever sqlerror continue
