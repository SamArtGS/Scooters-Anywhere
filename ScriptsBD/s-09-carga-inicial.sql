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

PROMPT - INSERTANDO UBICACION DE SCOOTERS

@s-09-carga-inicial-ubicaciones1.sql
PROMPT - - CARGA 1 LISTA
@s-09-carga-inicial-ubicaciones2.sql
PROMPT - - CARGA 2 LISTA
@s-09-carga-inicial-ubicaciones3.sql
PROMPT - - CARGA 3 LISTA
@s-09-carga-inicial-ubicaciones4.sql
PROMPT - - CARGA 4 LISTA
@s-09-carga-inicial-ubicaciones5.sql
PROMPT - - CARGA 5 LISTA
--@s-09-carga-inicial-ubicaciones6.sql
PROMPT - - CARGA 6 LISTA
--@s-09-carga-inicial-ubicaciones7.sql
PROMPT - - CARGA 7 LISTA
--@s-09-carga-inicial-ubicaciones8.sql
PROMPT - - CARGA 8 LISTA
--@s-09-carga-inicial-ubicaciones9.sql
PROMPT - - CARGA 9 LISTA
--@s-09-carga-inicial-ubicaciones10.sql
PROMPT - - CARGA 10 LISTA

PROMPT - INSERTANDO ZONA_SCOOTERS

@s-09-carga-inicial-zona-scooter.sql

PROMPT - INSERTANDO HISTORIAL DE LOS STATUS DE LOS SCOOTERS

@s-09-carga-inicial-hist-status.sql

PROMPT INSERTANDO REPORTES DE FALLAS

PROMPT LISTO! :)
SET FEEDBACK ON
SET SERVEROUTPUT ON