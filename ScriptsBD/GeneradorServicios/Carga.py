import random
from datetime import date
from datetime import datetime
from datetime import timedelta
import csv

tipo_servicio = 0 
nombre_servicio = ['V', 'R', 'B']
#0 -> Viaje
#1 -> Renta
#2 -> Bateria

class Scooter():

  scoo = {}
  folio = {}

  def __init__(self, fecha):
    self.fecha = fecha

  def getFolio(self, id):
    if(self.folio.get(id)):
      return self.folio.get(id)
    self.folio[id] = random.randint(0, 100000)
    return self.folio.get(id)

  def getScooter(self, fecha_fin):
    id = random.randint(0, 1000)
    while(self.scoo.get(id) and self.scoo.get(id).get('F') > self.fecha.fecha_actual):
      id = random.randint(0, 1000)
      self.fecha.fecha_actual = self.fecha.getFecha()
    self.scoo[id] = {'F' : fecha_fin}
    return id
  
  def getPrecio(self, fecha_inicio, fecha_fin):
    global tipo_servicio
    delta = fecha_fin - fecha_inicio
    if tipo_servicio == 0:
      return round((delta.seconds/3600) * 40, 2)
    elif tipo_servicio == 1:
      return round((delta.days) * 200, 2)
    else:
      return round((delta.days) * 40, 2)

  def getDias(self, fecha_inicio, fecha_fin):
    dias = fecha_fin - fecha_inicio
    return dias.days


class Usuario():

  users = {}
  direc = {}
  clabe_inter = {}

  def __init__(self, fecha):
    self.fecha = fecha
    self.cargarClabeInter()
    self.cargarDom()

  def cargarDom(self):
    with open('Dom.csv', newline='') as File:  
      reader = csv.reader(File)
      count = 0
      for row in reader:
        if count <= 500:
          self.direc[count] = row
          count = count + 1
        else:
          self.direc[random.randint(0,499)].append(row[0])

  def cargarClabeInter(self):
    with open('clabeInter.csv', newline='') as File:  
      reader = csv.reader(File)
      count = 0
      for row in reader:
        if count <= 500:
          self.clabe_inter[count] = row
          count = count + 1
        else:
          self.clabe_inter[random.randint(0,499)].append(row[0])
  
  def nombreBanco(self):
    n = random.randint(0, 14)
    if n == 0:   return 'BBVA'
    elif n == 1: return 'SANTANDER'
    elif n == 2: return 'SCOTIABANK'
    elif n == 3: return 'HSBC'
    elif n == 4: return 'CITIBANAMEX'
    elif n == 5: return 'INBURSA'
    elif n == 6: return 'BANCO DEL BAJÍO'
    elif n == 7: return 'BANORTE'
    elif n == 8: return 'BANREGIO'
    elif n == 9: return 'JP MORGAN'
    elif n == 10: return 'BANK OF AMERICA'
    elif n == 11: return 'IXE'
    elif n == 12: return 'BBVA'
    elif n == 13: return 'BBVA'
    elif n == 14: return 'BANEJERCITO'
  
  def getDom(self, id):
    n = len(self.direc[id])
    return self.direc.get(id)[random.randint(0, n - 1)]

  def getClabe(self, id):
    n = len(self.clabe_inter[id])
    return self.clabe_inter.get(id)[random.randint(0, n - 1)]

  def getUser(self):
    global tipo_servicio
    id = random.randint(0, 500)
    while(self.users.get(id) and self.users.get(id) > self.fecha.fecha_actual):
      id = random.randint(0,500)
    if tipo_servicio == 0:
      self.users[id] = self.fecha.fecha_actual + timedelta(hours = (random.random() * 7) + 0.5)
    elif tipo_servicio == 1:
      self.users[id] = self.fecha.fecha_actual + timedelta(days = (random.random() * 13) + 1)
    else:
      self.users[id] = self.fecha.fecha_actual + timedelta(days = (random.random() * 9) + 1)
    return id
  
  def getFechaFin(self, id):
    return self.users[id]

class Fechas():

  def __init__(self):
    self.fecha_actual  = datetime(2020, 5, 15, 8, 00, 00, 00000)

  def getFecha(self):
    self.fecha_actual += timedelta(hours = random.random() * .8)
    while(self.fecha_actual.hour < 8 or self.fecha_actual.hour > 20):
      self.fecha_actual += timedelta(hours = random.random() * .8)
    return self.fecha_actual
  

def main():
  global tipo_servicio
  fecha = Fechas()
  usuario = Usuario(fecha)
  scooter = Scooter(fecha)
  f =  open("s-09-carga-inicial-servicio.sql", "w")
  f1 = open("s-09-carga-inicial-servicio_viaje.sql", "w")
  f2 = open("s-09-carga-inicial-servicio_renta.sql", "w")
  f3 = open("s-09-carga-inicial-servicio_recarga.sql", "w")
  f4 = open("s-09-carga-recarga_scooter.sql", "w")
  f.write('alter session set nls_date_format="dd-mm-yyyy hh24:mi:ss";')
  for i in range(0, 10000):
    tipo_servicio = random.randint(0,2)
    id = usuario.getUser()
    fecha_inicio = fecha.getFecha()
    fecha_fin = usuario.getFechaFin(id)
    precio = scooter.getPrecio(fecha_inicio, fecha_fin)
    f.write('INSERT INTO SERVICIO (SERVICIO_ID, USUARIO_ID, TIPO_SERVICIO,'
      +'FECHA_INICIO, FECHA_FIN, STATUS_SERVICIO_ID, PRECIO) VALUES('
      + str(i) + ', '
      + str(id).zfill(4)  + ', '
      + "'" + fecha_inicio.strftime('%d/%m/%Y %H:%M:%S')  + "', "
      + "'" + fecha_fin.strftime('%d/%m/%Y %H:%M:%S')     + "', "
      + "'" + nombre_servicio[tipo_servicio]              + "', "
      + str(precio)
      + ');\n'
    )
    if(tipo_servicio == 0):
      scooter_id = scooter.getScooter(fecha_fin)
      folio = scooter.getFolio(scooter_id)
      f1.write('INSERT INTO SERVICIO_VIAJE (SERVICIO_ID, FOLIO, SCOOTER_ID) '
        + 'VALUES('
        + str(i) + ', '
        + "'" + str(folio).zfill(6)  + "', "
        + str(scooter_id)
        + ');\n'
      )
    elif tipo_servicio == 1: # Renta
      scooter_id = scooter.getScooter(fecha_fin)
      direccion = usuario.getDom(id)
      dias = scooter.getDias(fecha_inicio, fecha_fin)
      f2.write('INSERT INTO SERVICIO_RENTA (SERVICIO_ID, DIRECCION,'
        + ' DIAS_CUSTODIA, SCOOTER_ID) '
        + 'VALUES('
        + str(i) + ", "
        + "'" + direccion + "', "
        + str(dias) + ", "
        + str(scooter_id)
        + ');\n'
      )
    else:
      f3.write('INSERT INTO SERVICIO_RECARGA (SERVICIO_ID, NOMBRE_BANCO,'
        + ' CLABE_INTERBANCARIA) '
        + 'VALUES('
        + str(i) + ", "
        + "'" + usuario.nombreBanco() + "', "
        + "'" + usuario.getClabe(id) + "'"
        + ');\n'
      )
      for j in range(0, random.randint(1,20)):
        scooter_id = scooter.getScooter(fecha_fin)
        f4.write('INSERT INTO RECARGA_SCOOTER (SERVICIO_ID, SCOOTER_ID,'
          + ' NIVEL_CARGA) '
          + 'VALUES('
          + str(i) + ", "
          + str(scooter_id) + ", "
          + str(round(random.random() * 100,2))
          + ');\n'
        )
  f.write("commit;")
  f1.write("commit;")
  f2.write("commit;")
  f3.write("commit;")
  f4.write("commit;")
  f.close()
  f1.close()
  f2.close()
  f3.close()
  f4.close()

main()