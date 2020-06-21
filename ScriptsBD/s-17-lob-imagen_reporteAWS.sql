Prompt creando objeto DATA_DIR

-- CREATE OR REPLACE DIRECTORY BLOB_DIR AS '/tmp/';
-- grant read, write on directory BLOB_DIR to CG_PROY_ADMIN
-- conn CG_PROY_ADMIN@proyecto/samjor

create or replace function f_clob(
  p_file_varchar2 in varchar2
)
return clob is
  l_clob      CLOB := EMPTY_CLOB;
  l_len       BINARY_INTEGER;
  l_content   VARCHAR2(32000);
BEGIN
  dbms_lob.createtemporary(l_clob, TRUE);
  dbms_lob.open(l_clob, dbms_lob.lob_readwrite);
  l_len := length(p_file_varchar2);
  dbms_lob.writeappend(l_clob, l_len, p_file_varchar2);
  dbms_lob.close(l_clob);
  return l_clob;
end f_clob;
/
show errors;
