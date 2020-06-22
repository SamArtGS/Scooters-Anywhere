-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020


column filename format a20
select * from table (rdsadmin.rds_file_util.listdir(p_directory => 'BLOB_DIR'));