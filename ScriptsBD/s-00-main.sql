-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

whenever sqlerror exit rollback;
set feedback off

PROMPT ==============================================
PROMPT BIENVENIDO! - SAMUEL Y JORGE :)
PROMPT ==============================================

PROMPT GENERANDO LOS USUARIOS

@s-01-usuarios.sql

PROMPT CREACIÓN DE USUARIOS          -> OK!

connect cg_proy_admin/samjor
DECLARE
 file_exists NUMBER := 0;
BEGIN
  file_exists := DBMS_LOB.FILEEXISTS(BFILENAME('BLOB_DIR','.'));
  IF ( file_exists = 1 ) THEN
    EXECUTE IMMEDIATE 'DROP DIRECTORY BLOB_DIR';
  ELSE
    NULL;
  END IF;
END;
/
exec rdsadmin.rdsadmin_util.create_directory('BLOB_DIR');
prompt CONECTADO A CG_PROY_ADMIN

PROMPT ==============================================

PROMPT GENERANDO LAS ENTIDADES

@s-02-entidades.SQL

PROMPT CREACIÓN DE ENTIDADES         -> OK!

PROMPT ==============================================

PROMPT GENERANDO LAS TABLAS TEMPORALES

@s-03-tablas-temporales.sql

PROMPT CREACIÓN DE TABLAS TEMPORALES  -> OK!

PROMPT ==============================================

PROMPT GENERANDO LAS TABLAS EXTERNAS

@s-04-tablas-externas.sql

PROMPT CREACIÓN DE TABLAS EXTERNAS.  -> OK!

PROMPT ==============================================

PROMPT GENERANDO SECUENCIAS

@s-05-secuencias.sql

PROMPT CREACIÓN DE SECUENCIAS        -> OK!

PROMPT ==============================================

PROMPT GENERANDO ÍNDICES

@s-06-indices.sql

PROMPT CREACIÓN DE ÍNDICES.         -> OK!

PROMPT ==============================================

PROMPT GENERANDO SINÓNIMOS

@s-07-sinonimos.sql

PROMPT CREACIÓN DE SINÓNIMOS.              -> OK!

PROMPT ==============================================

PROMPT GENERANDO VISTAS

@s-08-vistas.sql

PROMPT CREACIÓN DE VISTAS.           -> OK!

PROMPT ==============================================================

PROMPT GENERANDO CARGAS INICIALES (ATENCIÓN: TARDA UNOS MINUTOS!)

--@s-09-carga-inicial.sql

PROMPT CARGA DE DATOS COMPLETA.      -> OK!

PROMPT ==============================================================

PROMPT
PROMPT
PROMPT = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
PROMPT PROYECTO FINAL BD - SAMUEL Y JORGE - PRIMERA PARTE FINALIZADO !
PROMPT = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
PROMPT
