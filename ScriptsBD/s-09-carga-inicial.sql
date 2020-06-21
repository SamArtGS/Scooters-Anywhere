-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020
SET FEEDBACK OFF
SET SERVEROUTPUT OFF
PROMPT - INSERTANDO MARCAS

@s-09-carga-inicial-marcas.sql

PROMPT - INSERTANDO STATUS

@s-09-carga-inicial-status.sql

PROMPT - INSERTANDO USUARIOS

@s-09-carga-inicial-usuario.sql

PROMPT - INSERTANDO TARJETAS PREPAGO

@s-09-carga-inicial-tarjetaprepago.sql

PROMPT - INSERTANDO TARJETAS DE CLIENTES

@s-09-carga-inicial-tarjeta-cliente.sql

PROMPT - INSERTANDO LOS TELÉFONOS DE LAS MARCAS

@s-09-carga-inicial-telefono-marca.sql

PROMPT INSERTANDO SCOOTERS

@s-09-carga-inicial-scooters.sql

alter session set nls_date_format="yyyy-mm-dd hh24:mi:ss";
PROMPT - INSERTANDO UBICACION DE SCOOTERS

@s-09-carga-inicial-ubicaciones.sql

PROMPT - INSERTANDO ZONA_SCOOTERS

@s-09-carga-inicial-zona-scooter.sql

alter session set nls_date_format="dd/mm/yyyy hh24:mi:ss";
PROMPT INSERTANDO SERVICIOS

@s-09-carga-inicial-servicio.sql

PROMPT INSERTANDO SERVICIO RENTA

@s-09-carga-inicial-servicio_renta.sql

PROMPT INSERTANDO SERVICIO VIAJE

@s-09-carga-inicial-servicio_viaje.sql

PROMPT INSERTANDO SERVICIO RECARGA

@s-09-carga-inicial-servicio_recarga.sql

PROMPT INSERTANDO RECARGA SCOOTER

@s-09-carga-inicial-recarga_scooter.sql

PROMPT INSERTANDO HISTORIAL STATUS SCOOTER

@s-09-carga-inicial-hist_scooter_status.sql

PROMPT INSERTANDO REPORTES DE FALLA

@s-09-carga-inicial-reporte_fallas.sql

PROMPT INSERTANDO IMAGENES DE LOS REPORTES

@s-09-carga-inicial-imagen_reporte.sql


PROMPT INSERTANDO REPORTES DE FALLAS


PROMPT LISTO! :)
SET FEEDBACK ON
SET SERVEROUTPUT ON