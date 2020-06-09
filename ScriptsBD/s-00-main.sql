-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020
PROMPT ==============================================
PROMPT BIENVENIDO! - SAMUEL Y JORGE :)
PROMPT ==============================================

PROMPT GENERANDO LOS USUARIOS

@s-01-usuarios.sql

PROMPT CREACIÓN DE USUARIOS          -> OK!

connect cg_proy_admin/samjor
prompt CONECTADO A CG_PROY_ADMIN

PROMPT ==============================================

PROMPT GENERANDO LAS ENTIDADES

@s-02-entidades.SQL

PROMPT CREACIÓN DE ENTIDADES         -> OK!

PROMPT ==============================================

PROMPT GENERANDO LAS TABLAS TEMPORALES

--@s-03-tablas-temporales.sql

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

PROMPT CREACIÓN DE SINÓNIMOS.           -> OK!

PROMPT ==============================================

PROMPT GENERANDO VISTAS

--@s-08-vistas.sql

PROMPT CREACIÓN DE VISTAS.           -> OK!

PROMPT ==============================================================

PROMPT GENERANDO CARGAS INICIALES (ATENCIÓN: TARDA UNOS MINUTOS!)

--@s-09-carga-inicial.sql

PROMPT CARGA DE DATOS COMPLETA.      -> OK!

PROMPT ==============================================================

PROMPT ========================= CONSULTAS ==========================

PROMPT CONSULTA 1: SE DESEA CONOCER...

SELECT NOMBRE FROM ZONA WHERE ZONA_ID<7;

PROMPT 

PROMPT CONSULTA 2: SE DESEA CONOCER...

SELECT NOMBRE FROM ZONA WHERE ZONA_ID<7;
PROMPT 

PROMPT CONSULTA 3: SE DESEA CONOCER...

SELECT NOMBRE FROM ZONA WHERE ZONA_ID<7;
PROMPT 

PROMPT CONSULTA 4: SE DESEA CONOCER...

SELECT NOMBRE FROM ZONA WHERE ZONA_ID<7;
PROMPT 
PROMPT 
PROMPT = = = = = = = = = = = = = = = = = = = = = = = = = = 
PROMPT PROYECTO FINAL BD - SAMUEL Y JORGE FINALIZADO!
PROMPT = = = = = = = = = = = = = = = = = = = = = = = = = = 
