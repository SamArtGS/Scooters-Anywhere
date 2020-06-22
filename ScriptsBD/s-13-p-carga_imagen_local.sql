-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020



drop database link db2_dblink;
create database link db2_dblink
  connect to CG_PROY_ADMIN identified by samjor
  using '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)
  (HOST=cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com)
  (PORT=1521))(CONNECT_DATA=(SID=SCOOTERS)))';

conn sys as sysdba
CREATE OR REPLACE DIRECTORY BLOB_DIR AS '/tmp/';
grant read, write on directory BLOB_DIR to CG_PROY_ADMIN;
--conn CG_PROY_ADMIN/samjor


create or replace procedure sp_cargar_imagenes(
  p_file_name in varchar2
)is
  lfh utl_file.file_type;
  rfh utl_file.file_type@db2_dblink;
  ldata raw(32767);
begin
  -- open file handles
  lfh := utl_file.fopen(
    location  =>  'BLOB_DIR', 
    filename  =>  p_file_name, 
    open_mode =>  'rb'
  );
  rfh := utl_file.fopen@db2_dblink(
    location  =>  'BLOB_DIR', 
    filename  =>  p_file_name, 
    open_mode =>  'wb'
  );
  -- iterate local file and write it to remote
  begin
    loop
      begin
        utl_file.get_raw(lfh, ldata, 32767);
        utl_file.put_raw@db2_dblink(rfh, ldata, true);
      exception
        when no_data_found then
          dbms_output.put_line('ERROR');
          exit;
      end;
    end loop;
  end;
  -- close file handles
  utl_file.fclose(lfh);
  utl_file.fclose@db2_dblink(rfh);  
exception 
  -- exception handling + make sure we dont leak file handles
  when others then
    utl_file.fclose(lfh);
    utl_file.fclose@db2_dblink(rfh);
    raise;
end;
/
show errors;

declare
begin
  sp_cargar_imagenes('scooter.png');
end;
/