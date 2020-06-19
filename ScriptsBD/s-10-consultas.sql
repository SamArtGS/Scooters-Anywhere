--@Autor: Jorge Cárdenas Cárdenas - Samuel Arturo Garrido Sanchez
--@Fecha creación: 05/06/2020
--@Descripción: Proyecto, Consultas


-- Mostrar los usuarios cuyos scooter se hayan salido de zona
select *
from usuario u, servicio s, servicio_viaje sv, servicio_renta sr, 
  scooter sc, status st
where u.usuario_id = s.usuario_id
  and s.servicio_id = sv.servicio_id
  and s.servicio_id = sr.servicio_id (+)
  and sv.scooter_id = sc.scooter_id
  and sr.scooter_id = sc.scooter_id
  and sc.status_id = st.status_id
  and st.clave = 'FZ'; --Fuera de zona


-- Mostrar el número de veces que se le ha recomepensado a un usuario por fallas
-- confirmadas en un scooter

select u.usuario_id, u.email, u.nombre, u. ap_paterno, u.ap_materno,
  count(u.usuario_id) as numero_fallas
from status st, hist_scooter_status hs, scooter sc, reporte_fallas rf, usuario u
where st.status_id = hs.status_id
  and hs.scooter_id = sc.scooter_id
  and sc.scooter_id = rf.scooter_id
  and rf.usuario_id = u.usuario_id
  and st.clave = 'CF' -- Con fallas
  group by u.usuario_id, u.email, u.nombre, u. ap_paterno, u.ap_materno;


-- El cliente que más recargas ha hecho


-- Historial de tarjeta de prepago


-- Tipo de servicio más contratado  


-- MArca de los scooters anteriores y marca de los scooters nuevos


-- Mostrar la duracion promedio de entre las fechas de recarga de un scooter