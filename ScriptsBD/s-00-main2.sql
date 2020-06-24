-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

whenever sqlerror continue;
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

@s-11-tr-trigger4.sql
@s-12-tr-trigger4-prueba.sql

PROMPT - - - - - - - - - - - - - -

PROMPT
PROMPT TRIGGERS CARGADOS Y VERIFICADOS.       -> OK!
PROMPT =======================================================================
PROMPT ========================= PROCEDURES ==================================

@s-13-p-actualizar_status.sql
PROMPT
@s-14-p-actualizar_status-prueba.sql

PROMPT - - - - - - - - - - - - - - 

@s-13-p-pagar-recargas.sql
PROMPT
@s-14-p-pagar_recargas-prueba.sql

PROMPT - - - - - - - - - - - - - - 

PROMPT EJECUTE EL SCRIPT s-13-p-carga_imagen_local.sql
pause Press Enter to Continue 
PROMPT
@s-14-p-carga_imagen_local-prueba.sql

PROMPT ========================= LOBS  ======================================
@s-17-lob-imagen_reporte.sql
PROMPT
@s-18-lob-imagen_reporte-prueba.sql

PROMPT - - - - - - - - - - - - - - 

@s-13-p-crear_reporte_falla.sql
PROMPT
@s-14-p-crear_reporte_falla-prueba.sql


PROMPT PROCEDIMIENTOS CARGADAS Y VERIFICADOS.       -> OK!
PROMPT ======================================================================
PROMPT ========================= FUNCIONES ==================================
@s-15-fx-funcion1.sql
@s-15-fx-funcion2.sql
@s-15-fx-funcion3.sql

@s-16-fx-funciones-pruebas.sql
PROMPT FUNCIONES CARGADAS Y VERIFICADAS.       -> OK!
PROMPT ======================================================================
PROMPT ==================== RESULTADOS FINALES ==============================
@resultados-proyecto-final.sql