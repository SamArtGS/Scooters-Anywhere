-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

whenever sqlerror exit rollback;
set feedback off

PROMPT =======================================================================
PROMPT ========================= CONSULTAS ===================================

@s-10-consultas.sql

PROMPT CONSULTAS TERMINADAS.       -> OK!
PROMPT =======================================================================
PROMPT ========================= TRIGGERS ====================================
@s-11-tr-trigger1.sql

PROMPT

@s-12-tr-trigger1-prueba.sql

PROMPT - - - - - - - - - - - - - - 

@s-11-tr-trigger2.sql
PROMPT
@s-12-tr-trigger2-prueba.sql

PROMPT - - - - - - - - - - - - - - 

@s-11-tr-trigger3.sql
PROMPT
@s-12-tr-trigger3-prueba.sql

PROMPT - - - - - - - - - - - - - -

--@s-11-tr-trigger4.sql
--@s-12-tr-trigger4-prueba.sql

PROMPT - - - - - - - - - - - - - -

PROMPT
PROMPT TRIGGERS CARGADOS Y VERIFICADOS.       -> OK!
PROMPT =======================================================================
PROMPT ========================= PROCEDURES ==================================



PROMPT ======================================================================
PROMPT ========================= FUNCIONES ==================================
@s-15-fx-funcion1.sql
@s-15-fx-funcion2.sql
@s-15-fx-funcion3.sql

@s-16-fx-funciones-pruebas.sql
PROMPT FUNCIONES CARGADAS Y VERIFICADAS.       -> OK!
PROMPT ======================================================================
PROMPT ========================= LOBS  ======================================

--@s-13-p-actualizar_status.sql


--@s-14-p-actualizar_status-prueba.sql