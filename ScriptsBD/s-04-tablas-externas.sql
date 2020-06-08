whenever sqlerror exit rollback
drop database link db2_dblink;
create database link db2_dblink
  connect to CG_PROY_ADMIN identified by samjor
  using '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=cursodb.c7rbflvluzyk.us-east-2.rds.amazonaws.com)(PORT=1521))(CONNECT_DATA=(SID=SCOOTERS)))';
declare
  lfh utl_file.file_type;
  rfh utl_file.file_type@db2_dblink;
  ldata raw(32767);
begin
  lfh := utl_file.fopen(location=>'ScriptsBD', filename=>'ZONA_TABLA.csv', open_mode=>'rb');
  rfh := utl_file.fopen@db2_dblink(location=>'TABLA_EXTERNA', filename=>'ZONA_TABLA.csv', open_mode=>'wb');
  begin
    loop
    dbms_output.put_line('HI99');
      begin
        utl_file.get_raw(lfh, ldata, 32767);
        utl_file.put_raw@db2_dblink(rfh, ldata, true);
      exception
        when no_data_found then
          dbms_output.put_line('HI');
          exit;
      end;
    end loop;
  end;
  utl_file.fclose(lfh);
  utl_file.fclose@db2_dblink(rfh);  
exception 
  when others then
    dbms_output.put_line('HI5');
    utl_file.fclose(lfh);
    utl_file.fclose@db2_dblink(rfh);
    raise;
end;
/ 

CREATE TABLE ZONA(
  ZONA_ID     NUMBER(10,0)    NOT NULL,
  NOMBRE      VARCHAR2(40)    NOT NULL,
  POLIGONO    VARCHAR2(8000)  NOT NULL,
  CONSTRAINT ZONA_PK PRIMARY KEY (ZONA_ID),
  CONSTRAINT ZONA_NOMBRE_UK UNIQUE(NOMBRE),
  CONSTRAINT ZONA_POLIGONO_UK UNIQUE(POLIGONO)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY ZONA_JSON_DIR
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
    MISSING FIELD VALUES ARE NULL
    (ZONA_ID,NOMBRE,POLIGONO)
  )
  LOCATION ('ZONA_TABLA.csv')
)
PARALLEL
REJECT LIMIT UNLIMITED;

whenever sqlerror continue
