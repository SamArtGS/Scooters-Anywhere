-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

CREATE GLOBAL TEMPORARY TABLE tabla_temporal (
  nombre varchar2(100),
  email varchar2(200)
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE tabla_temporal (
  nombre varchar2(100),
  email varchar2(200)
) ON COMMIT PRESERVE ROWS;