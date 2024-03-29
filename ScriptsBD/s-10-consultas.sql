-- Companía:  Scooters Anywhere
-- Project:   Modelo Proyecto Final
-- Author:    Cárdenas Jorge y Garrido Samuel 
-- Fecha:     04 de Junio del 2020


set linesize 200
SET PAGESIZE 100
PROMPT CONSULTA 1: SE DESEA CONOCER EL HISTORIAL DE SERVICIOS DE EL USUARIO CON 
PROMPT CORREO ELECTRONICO: 'cleppard4p@hexun.com', INDEPENDIENTEMENTE DEL TIPO 
PROMPT DE SERVICIO SE DEBERA MOSTRAR LA DURACION EN DIAS Y HORAS DEL MISMO
COLUMN EMAIL FORMAT A25;
COLUMN DURACION FORMAT A10;
SELECT EMAIL,
  CASE
    WHEN S.TIPO_SERVICIO = 'R' THEN 'RENTA'
    WHEN S.TIPO_SERVICIO = 'V' THEN 'VIAJE'
    WHEN S.TIPO_SERVICIO = 'B' THEN 'RECARGA' 
  END AS TIPO_SERVICIO, 
  CASE
    WHEN S.TIPO_SERVICIO = 'R' THEN TRUNC((S.FECHA_FIN - S.FECHA_INICIO)) || ' Dia(s)'
    WHEN S.TIPO_SERVICIO = 'V' THEN TRUNC((S.FECHA_FIN - S.FECHA_INICIO) * 24) || ' H'
    WHEN S.TIPO_SERVICIO = 'B' THEN TRUNC((S.FECHA_FIN - S.FECHA_INICIO)) || ' Dia(s)'
  END AS DURACION
FROM USUARIO U
NATURAL JOIN SERVICIO S
LEFT JOIN SERVICIO_RENTA SR
  ON S.SERVICIO_ID = SR.SERVICIO_ID
LEFT JOIN SERVICIO_VIAJE SV
  ON S.SERVICIO_ID = SV.SERVICIO_ID
LEFT JOIN SERVICIO_RECARGA SB -- SERVICIO BATERIA
  ON S.SERVICIO_ID = SB.SERVICIO_ID
WHERE U.EMAIL = 'cleppard4p@hexun.com';

--Minus
-- Excluir los scooters con cargas menores a 100


PROMPT CONSULTA 2: SE DESEA MOSTRAR LOS DATOS DE LOS USUARIOS A LOS QUE SE LES 
PROMPT A RECOMPENZADO POR REPORTAR UNA FALLA, PARA SER REMCOMPENZADOS LA FALLA 
PROMPT DEBE ESTAR REGISTRADO EN ESTADO DE LOS SCOOTERS
col email format a30
col nombre format a30
col ap_paterno format a20
col ap_materno format a20
select u.usuario_id, u.email, u.nombre, u. ap_paterno, u.ap_materno,
  count(u.usuario_id) as numero_fallas
from status st, hist_scooter_status hs, scooter sc, reporte_falla rf, usuario u
where st.status_id = hs.status_id
  and hs.scooter_id = sc.scooter_id
  and sc.scooter_id = rf.scooter_id
  and rf.usuario_id = u.usuario_id
  and st.clave = 'CF' -- Con fallas
  AND ROWNUM <= 30
group by u.usuario_id, u.email, u.nombre, u. ap_paterno, u.ap_materno;

PROMPT CONSULTA 3: OBTENER LAS MARCAS Y TELEFONOS DE LOS SCOOTERS 
PROMPT CUYA CAPACIDAD DE CARGA SEA SUPERIOR A LA DE CAPACIDAD DE CARGA DE 
PROMPT LOS SCOOTERS PROMEDIOS

SELECT M.NOMBRE, TM.TELEFONO, Q1.CAPACIDAD_CARGA, Q1.CAPACIDAD_PROMEDIO
FROM XX_TELEFONO_MARCA TM, XX_MARCA M,( -- Uso de Sinonimos
  SELECT MARCA_ID, MAX(CAPACIDAD_MAXIMA) AS CAPACIDAD_CARGA,
    (SELECT AVG(CAPACIDAD_MAXIMA) FROM SCOOTER) AS CAPACIDAD_PROMEDIO
  FROM SCOOTER
  GROUP BY MARCA_ID
  HAVING MAX(CAPACIDAD_MAXIMA) > (SELECT AVG(CAPACIDAD_MAXIMA) FROM SCOOTER)
)Q1
WHERE TM.MARCA_ID = M.MARCA_ID
  AND M.MARCA_ID = Q1.MARCA_ID
  AND ROWNUM <= 20 -- Limitar la salida en consola
ORDER BY Q1.MARCA_ID;



PROMPT CONSULTA 4: SE DESEA OBTENER EL NOMBRE DE LA MARCA Y ID, NUMERO DE SERIE, 
PROMPT ASI COMO LA MATRICULA Y CAPACIDAD DE CARGA DE LOS SCOOTERS DE LA MARCA 
PROMPT CON ID = 2, EXCEPTO LOS QUE HAN SIDO REEMPLAZADOS POR OTRA MARCA
SELECT NOMBRE, SCOOTER_ID, NUMERO_SERIE, MATRICULA, CAPACIDAD_MAXIMA
FROM (
  SELECT *
  FROM SCOOTER
  WHERE MARCA_ID = 2
  MINUS
  SELECT S.*
  FROM SCOOTER S, SCOOTER R
  WHERE S.SCOOTER_REEMPLAZO_ID = R.SCOOTER_ID
  AND R.MARCA_ID = 2
  UNION
  SELECT  R.*
  FROM SCOOTER S, SCOOTER R
  WHERE S.SCOOTER_ID = R.SCOOTER_REEMPLAZO_ID
  AND R.MARCA_ID = 2
)Q1, MARCA M
WHERE Q1.MARCA_ID = M.MARCA_ID;


COLUMN NOMBRE FORMAT A40
PROMPT CONSULTA 5: SE DESEA CONOCER EL PROMEDIO DE LOS DIAS DE DURACION 
PROMPT DE LA BATERIA DE CADA UNO DE LOS SCOOTERS REGISTRADOS EN LA BASE DE DATOS
PROMPT COMPARANDOLA CON LA DURACION PROMEDIO DE TODOS LOS SCOOTERS
declare
cursor cur_recargas is
  SELECT S.MARCA_ID, HSS.scooter_id, hss.fecha_status
  FROM HIST_SCOOTER_STATUS HSS
    JOIN SCOOTER S
      ON HSS.SCOOTER_ID = S.SCOOTER_ID
  WHERE HSS.STATUS_ID = (
    select status_id from status
    where clave = 'SC'
  )
  ORDER BY HSS.SCOOTER_ID, hss.fecha_status DESC;
v_fecha date;
v_count number(1,0) := 0;
v_scooter_id number(10,0) := 0;
begin
  for r in cur_recargas loop
    if v_count = 0 or v_scooter_id != r.scooter_id then
      v_count := 1;
      v_scooter_id := r.scooter_id;
    else
      insert into t_detalle_recargas(MARCA_ID, scooter_id, num_dias)
      values(r.marca_id, r.scooter_id, trunc(v_fecha - r.fecha_status));
    end if;
    v_fecha := r.fecha_status;
  end loop;
end;
/
select nombre, ROUND(avg(num_dias),2) as promedio_scooter,
  (select ROUND(avg(num_dias),2) from t_detalle_recargas) promedio_global
from t_detalle_recargas t, marca m -- Tabla temporal
where t.marca_id = m.marca_id
group by nombre
order by nombre;


PROMPT CONSULTA 6: SELECCCIONAR TODAS LAS TARJETAS DE PREPAGO SIN ASIGNAR CON UN
PROMPT IMPORTE DE 300
SELECT *
FROM TARJETAS_PREPAGO_NO_USADAS -- Uso de vistas
WHERE IMPORTE = 300;



PROMPT CONSULTA 7: MOSTRAR LOS REPORTES DE FALLAS POR MES DE LOS USUARIOS, ASI
PROMPT COMO EL NOMBRE Y CORREO DE LOS USUARIOS QUE HICIERON EL REPORTE
SELECT U.NOMBRE, U.AP_PATERNO, U.AP_MATERNO, RF.NUMERO AS NUMERO_FALLAS
FROM REP_FALLA_MES_POR_USUARIO RF -- Uso de Vistas
JOIN USUARIO U
  ON RF.USUARIO = U.USUARIO_ID;


PROMPT CONECTANDO COMO USUARIO INVITADO
CONNECT CG_PROY_INVITADO/samjor

PROMPT COSULTA 8: CONSULTAR LOS SERVICIOS DEL USUARIO CON ID = 15 Y OBTENER 
PROMPT LOS SCOOTERS ASOCIADOS A DICHOS SERVICIOS INDICANDO EXPLICITAMENTE EL 
PROMPT TIPO DE SERVICIO
SELECT S.USUARIO_ID, S.SERVICIO_ID, -- Sinonimos
  CASE
    WHEN S.TIPO_SERVICIO = 'R' THEN 'RENTA'
    WHEN S.TIPO_SERVICIO = 'V' THEN 'VIAJE'
    WHEN S.TIPO_SERVICIO = 'B' THEN 'RECARGA' 
  END AS SCOOTER_ID,
  CASE
    WHEN S.TIPO_SERVICIO = 'R' THEN SR.SCOOTER_ID
    WHEN S.TIPO_SERVICIO = 'V' THEN SV.SCOOTER_ID
    WHEN S.TIPO_SERVICIO = 'B' THEN Q1.SCOOTER_ID 
  END AS SCOOTER_ID
FROM SERVICIO S, SERVICIO_RENTA SR, SERVICIO_VIAJE SV, (
  SELECT SERVICIO_ID, SCOOTER_ID
  FROM SERVICIO_RECARGA
  NATURAL JOIN RECARGA_SCOOTER
) Q1
WHERE S.SERVICIO_ID = SR.SERVICIO_ID (+)
  AND S.SERVICIO_ID = SV.SERVICIO_ID (+)
  AND S.SERVICIO_ID = Q1.SERVICIO_ID (+)
  AND S.USUARIO_ID = 15;

PROMPT REGRESANDO COMO ADMIN
CONN CG_PROY_ADMIN/samjor
PROMPT