-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Garrido Samuel y Jorge Cárdenas
-- Fecha:     04 de Junio del 2020

grant select on jrc_p1001_subastas.articulo to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.articulo_arqueologico to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.articulo_donado to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.articulo_famoso to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.cliente to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.entidad to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.factura_cliente to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.historico_status_articulo to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.pais to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.status_articulo to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.subasta to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.subasta_venta to jrc_p1101_subastas;
grant select on jrc_p1001_subastas.tarjeta_cliente to jrc_p1101_subastas;


CREATE OR REPLACE SYNONYM articulo for jrc_p1001_subastas.articulo;

CREATE OR REPLACE SYNONYM articulo_arqueologico for jrc_p1001_subastas.articulo_arqueologico;

CREATE OR REPLACE SYNONYM articulo_donado for jrc_p1001_subastas.articulo_donado;

CREATE OR REPLACE SYNONYM articulo_famoso for jrc_p1001_subastas.articulo_famoso;

CREATE OR REPLACE SYNONYM cliente for jrc_p1001_subastas.cliente;

CREATE OR REPLACE SYNONYM entidad for jrc_p1001_subastas.entidad;

CREATE OR REPLACE SYNONYM factura_cliente for jrc_p1001_subastas.factura_cliente;

CREATE OR REPLACE SYNONYM historico_status_articulo for jrc_p1001_subastas.historico_status_articulo;

CREATE OR REPLACE SYNONYM pais for jrc_p1001_subastas.pais;

CREATE OR REPLACE SYNONYM status_articulo for jrc_p1001_subastas.status_articulo;

CREATE OR REPLACE SYNONYM subasta for jrc_p1001_subastas.subasta;

CREATE OR REPLACE SYNONYM subasta_venta for jrc_p1001_subastas.subasta_venta;

CREATE OR REPLACE SYNONYM tarjeta_cliente for jrc_p1001_subastas.tarjeta_cliente;