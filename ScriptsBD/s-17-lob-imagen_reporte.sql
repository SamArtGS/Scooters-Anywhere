-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

/*
Archivos Locales
conn sys as sysdba
CREATE OR REPLACE DIRECTORY BLOB_DIR AS '/tmp/';
grant read, write on directory BLOB_DIR to CG_PROY_ADMIN
conn CG_PROY_ADMIN/samjor

*/
-- Archivos de Texto en AWS:
BEGIN
  RDSADMIN.RDSADMIN_UTIL.CREATE_DIRECTORY('BLOB_DIR');
END;
/
DECLARE
  fHandle  UTL_FILE.FILE_TYPE;
BEGIN
  fHandle := UTL_FILE.FOPEN('BLOB_DIR', 'hola.png', 'w');
  UTL_FILE.PUT_LINE(fHandle, 'This is the first line' );
  UTL_FILE.PUT_LINE(fHandle, 'This is the second line');
  UTL_FILE.PUT_LINE(fHandle, 'This is the third line' );
  UTL_FILE.FCLOSE(fHandle);
END;
/

create or replace function dbst_load_a_file(
  p_file_name in varchar2
) return clob
as
    l_clob    clob;
    l_bfile   bfile;
    dst_offset  number := 1 ;
    src_offset  number := 1 ;
    lang_ctx    number := DBMS_LOB.DEFAULT_LANG_CTX;
    warning     number;
begin
    l_bfile := bfilename( 'BLOB_DIR', p_file_name );
    dbms_lob.fileopen( l_bfile );
    dbms_lob.createtemporary(l_clob, true);
    dbms_lob.loadclobfromfile(
      DEST_LOB     => l_clob
    , SRC_BFILE    => l_bfile
    , AMOUNT       => dbms_lob.getlength( l_bfile )
    , DEST_OFFSET  => dst_offset
    , SRC_OFFSET   => src_offset
    , BFILE_CSID   => DBMS_LOB.DEFAULT_CSID
    , LANG_CONTEXT => lang_ctx
    , WARNING      => warning);
    dbms_lob.fileclose( l_bfile );
    return l_clob;
end;
/

