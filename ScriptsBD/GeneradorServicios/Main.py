import random
import enum
import csv
import math
from datetime import date
from datetime import datetime
from datetime import timedelta
import re

fecha_actual = datetime(2020, 2, 15, 8, 00, 00, 00000)
lista_servicios = []
lista_fallas = []

class Reporte_Falla():

  datos = {}
  reporte_falla_id = 1

  def __init__(self, servicio):
    self.loadDatos()
    self.latitud = self.datos[servicio.usuario.usuario_id][0]
    self.longitud = self.datos[servicio.usuario.usuario_id][1]
    self.descripcion = self.datos[servicio.usuario.usuario_id][2]
    self.servicio = servicio


  def loadDatos(self):
    with open('Reporte.csv', newline='') as File:  
      reader = csv.reader(File)
      count = 1
      for row in reader:
        if count <= 500:
          self.datos[count] = row
          count = count + 1
        else:
          self.datos[random.randint(1,500)].append(row[0])
  
  def writeDatos(self):
    global fecha_actual
    file = open("../s-09-carga-inicial-reporte_fallas.sql", "a")
    file.write('INSERT INTO REPORTE_FALLA (REPORTE_FALLA_ID, FECHA_REPORTE, '
      +'LATITUD, LONGITUD, DESCRIPCION, USUARIO_ID, SCOOTER_ID) VALUES('
      + "SEQ_REPORTE_FALLA.NEXTVAL, "
      + "'" + fecha_actual.strftime('%d/%m/%Y %H:%M:%S')  + "', "
      + str(self.latitud) + ", "
      + str(self.longitud) + ", "
      + "'" + str(self.descripcion) + "', "
      + str(self.servicio.usuario.usuario_id) + ", "
      + str(self.servicio.scooter.scooter_id)
      + ');\n'
    )
    self.writeImagen()
    Reporte_Falla.reporte_falla_id += 1
    file.close()

  def writeImagen(self):
    file = open("../s-09-carga-inicial-imagen_reporte.sql", "a")
    for i in range(random.randint(0,4)):
      file.write('INSERT INTO IMAGEN_REPORTE (IMAGEN_REPORTE_ID, IMAGEN, '
      +'REPORTE_FALLA_ID) VALUES('
      + "SEQ_IMAGEN_REPORTE.NEXTVAL, "
      + "empty_blob(), "
      + str(Reporte_Falla.reporte_falla_id)
      + ');\n'
      )
    file.close()



class Usuario():

  users = {}

  def __init__(self):
    self.usuario_id = random.randint(1,500)
    while(Usuario.users.get(self.usuario_id) and Usuario.users.get(self.usuario_id) == 0):
      Usuario.usuario_id = random.randint(1,500)
    self.users[self.usuario_id] = 1 # Ocupado
    

  def setTipoServicio(self, tipo_servicio):
    self.tipo_servicio = tipo_servicio

class Servicio():
  
  def __init__(self, servicio_id, tipo_servicio):
    self.usuario = Usuario()
    # Atributos
    self.servicio_id = servicio_id
    self.tipo_servicio = tipo_servicio
  
  def writeServicio(self, file):
    global fecha_actual
    delta = self.fecha_fin - fecha_actual
    if(self.tipo_servicio == 'V'):
      precio = round((delta.seconds/3600) * 40, 2)
    elif self.tipo_servicio == 'R':
      precio = round((delta.days) * 200, 2)
    else:
      precio = -1
    file.write('INSERT INTO SERVICIO (SERVICIO_ID, USUARIO_ID, PRECIO, FECHA_INICIO, '
      + 'FECHA_FIN,TIPO_SERVICIO) VALUES('
      + str(self.servicio_id) + ', '
      + str(self.usuario.usuario_id) + ', '
      + str(precio) + ", "
      + "'" + fecha_actual.strftime('%d/%m/%Y %H:%M:%S')  + "', "
      + "'" + self.fecha_fin.strftime('%d/%m/%Y %H:%M:%S')  + "', "
      + "'" + self.tipo_servicio + "'"
      + ');\n'
    )

class Servicio_Viaje(Servicio):

  folio = {}

  def __init__(self, servicio_id):
    global fecha_actual
    Servicio.__init__(self, servicio_id, 'V')
    self.scooter = Scooter(Status.en_viaje)
    self.folio = self.__getFolio()
    self.fecha_inicio = fecha_actual
    self.fecha_fin = fecha_actual + timedelta(hours = (random.random() * 7) + 0.5)
    
  def __getFolio(self):
    valores = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    fol = "".join([random.choice(valores) for i in range(13)])
    while self.folio.get(fol):
      fol = "".join([random.choice(valores) for i in range(13)])
    self.folio[fol] = 1
    return fol

  def writeServicioViaje(self, file):
    global fecha_actual
    file.write('INSERT INTO SERVICIO_VIAJE (SERVICIO_ID, FOLIO, '
        + ' SCOOTER_ID) '
        + 'VALUES('
        + str(self.servicio_id) + ", "
        + "'" + self.folio  + "', "
        + str(self.scooter.scooter_id)
        + ');\n'
      )

class Servicio_Renta(Servicio):

  direc = {}
  
  def __init__(self, servicio_id):
    global fecha_actual
    self.loadDireccion()
    Servicio.__init__(self, servicio_id, 'R')
    self.fecha_inicio = fecha_actual
    self.dias_custodia = random.randint(1,14)
    self.scooter = Scooter(Status.en_renta)
    self.direccion = self.direc[self.usuario.usuario_id]
    self.fecha_fin = fecha_actual + timedelta(days = self.dias_custodia)
  
  def loadDireccion(self):
    with open('Dom.csv', newline='') as File:  
      reader = csv.reader(File)
      count = 1
      for row in reader:
        if count <= 500:
          self.direc[count] = row
          count = count + 1
        else:
          self.direc[random.randint(1,500)].append(row[0])
  
  def writeServicioRenta(self, file):
    file.write('INSERT INTO SERVICIO_RENTA (SERVICIO_ID, DIRECCION, DIAS_CUSTODIA, '
      + 'SCOOTER_ID) '
      + 'VALUES('
      + str(self.servicio_id) + ", "
      + "'" + str(self.direccion[random.randint(1, len(self.direccion)) -1]) + "', "
      + str(self.dias_custodia) + ", "
      + str(self.scooter.scooter_id)
      + ');\n'
    )

class Servicio_Recarga(Servicio):
  
  clabe = {}

  def __init__(self, servicio_id):
    global fecha_actual
    self.cargarClabeInter()
    Servicio.__init__(self, servicio_id, 'B')
    self.fecha_fin = fecha_actual + timedelta(days = random.randint(1, 10))
    datos = self.clabe[self.usuario.usuario_id][
      random.randint(0, len(self.clabe[self.usuario.usuario_id]) - 1)]
    self.banco = datos[1]
    self.clabe_interbancaria = datos[0]
    self.lista_scooters = []
    for scoo in range(1, random.randint(1,20)):
      recarga_scooter = Recarga_Scooter(self)
      recarga_scooter.writeRecargaScooter()
      recarga_scooter.scooter.writeHistorico()
      self.lista_scooters.append(recarga_scooter)
  

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
  
  def cargarClabeInter(self):
    with open('clabeInter.csv', newline='') as File:  
      reader = csv.reader(File)
      count = 1
      for row in reader:
        row[0] = row[0][0:18]
        if count <= 500:
          row.append(self.nombreBanco())
          self.clabe[count] = [row]
          count = count + 1
        else:
          row.append(self.nombreBanco())
          self.clabe[random.randint(1, 500)].append(row) 

  def writeServicioRecarga(self, file):
    file.write('INSERT INTO SERVICIO_RECARGA (SERVICIO_ID, NOMBRE_BANCO, '
      + 'CLABE_INTERBANCARIA) VALUES('
      + str(self.servicio_id) + ", "
      + "'" + self.banco  + "', "
      + self.clabe_interbancaria 
      + ');\n'
    )

class Recarga_Scooter():
  
  def __init__(self, servicio):
    self.nivel_carga = random.randint(70, 100)
    self.scooter = Scooter(Status.en_carga)
    self.servicio = servicio
  
  def writeRecargaScooter(self):
    file = open("../s-09-carga-inicial-recarga-scooter.sql", "a")
    file.write('INSERT INTO RECARGA_SCOOTER (SERVICIO_ID, SCOOTER_ID, '
      +'NIVEL_CARGA) VALUES('
      + str(self.servicio.servicio_id) + ", "
      + str(self.scooter.scooter_id) + ", "
      + str(self.nivel_carga)
      + ');\n'
    )
    file.close()




class Scooter():

  scoo = {}

  def __init__(self, status):
    self.scooter_id = random.randint(1, 1000)
    while(Scooter.scoo.get(self.scooter_id) and Scooter.scoo.get(self.scooter_id) == 1):
      self.scooter_id = random.randint(1, 1000)
    Scooter.scoo[self.scooter_id] = 1 # Ocupado
    self.historico = Hist_Scooter_status(self.scooter_id, status)
    self.fecha_arreglo = 0
  
  def writeHistorico(self):
    global fecha_actual
    file = open("../s-09-carga-inicial-hist_scooter_status.sql", "a")
    file.write('INSERT INTO HIST_SCOOTER_STATUS (HIST_SCOO_STATUS_ID, '
      + 'STATUS_ID, SCOOTER_ID, FECHA_STATUS) '
      + 'VALUES('
      + 'SEQ_HIST_SCOOTER_STATUS.NEXTVAL, '
      + str(self.historico.status_id.value)  + ", "
      + str(self.scooter_id) + ", "
      + "'" + fecha_actual.strftime('%d/%m/%Y %H:%M:%S')  + "'"
      + ');\n'
    )
    file.close()

class Status(enum.Enum):
  apagado = 1
  en_espera = 2
  en_viaje = 3
  bateria_baja = 4
  con_fallas = 5
  en_renta = 6
  en_carga = 7

class Hist_Scooter_status():
  def __init__(self, scooter_id, status_id):
    global fecha_actual
    self.scooter_id = scooter_id
    self.status_id = status_id


def revisarFechas():
  global lista_servicios
  global fecha_actual
  global lista_fallas
  for s in lista_servicios:
    if(s.fecha_fin <= fecha_actual):
      if (s.tipo_servicio != 'B'):
        if(random.randint(0, 1000) < 50):
          s.scooter.historico = Hist_Scooter_status(s.scooter.scooter_id, Status.con_fallas)
          s.scooter.fecha_arreglo = fecha_actual + timedelta(days = random.random() * 4)
          lista_fallas.append(s)
          reporte = Reporte_Falla(s)
          reporte.writeDatos()
        else:
          s.scooter.historico = Hist_Scooter_status(s.scooter.scooter_id, Status.en_espera)
        s.scooter.writeHistorico()
        Scooter.scoo[s.scooter.scooter_id] = 0 # Liberado
        Usuario.users[s.usuario.usuario_id] = 0 # Liberado
      else:
        for sr in s.lista_scooters:
          sr.scooter.historico = Hist_Scooter_status(sr.scooter.scooter_id, Status.en_espera)
          sr.scooter.writeHistorico()
          Scooter.scoo[sr.scooter.scooter_id] = 2 # Liberado
          Usuario.users[s.usuario.usuario_id] = 0 # Liberado
      lista_servicios.remove(s)
  revisarFallas()

def revisarFallas():
  global lista_fallas
  global fecha_actual
  for s in lista_fallas:
    if(s.scooter.fecha_arreglo <= fecha_actual):
      s.scooter.fecha_arreglo = None
      s.scooter.historico = Hist_Scooter_status(s.scooter.scooter_id, Status.en_espera)
      s.scooter.writeHistorico()
      lista_fallas.remove(s)

def actualizaTiempo():
  global fecha_actual
  fecha_actual += timedelta(hours = random.random() * .8)
  while(fecha_actual.hour < 8 or fecha_actual.hour > 20):
    fecha_actual += timedelta(hours = random.random() * .8)


def generarServicio(servicio_id):
  tipo_servicio = random.randint(0,2)
  if tipo_servicio == 0:
    return Servicio_Viaje(servicio_id), 'V'
  elif tipo_servicio == 1:
    return Servicio_Renta(servicio_id), 'R'
  else:
    return Servicio_Recarga(servicio_id), 'B'

def main():
  global lista_servicios
  f =  open("../s-09-carga-inicial-servicio.sql", "w")
  f1 = open("../s-09-carga-inicial-servicio_viaje.sql", "w")
  f3 = open("../s-09-carga-inicial-servicio_renta.sql", "w")
  f4 = open("../s-09-carga-inicial-servicio_recarga.sql", "w")
  open("../s-09-carga-inicial-reporte_fallas.sql", "w").close()
  open("../s-09-carga-inicial-imagen_reporte.sql", "w").close()
  open("../s-09-carga-inicial-recarga_scooter.sql", "w").close()
  open("../s-09-carga-inicial-hist_scooter_status.sql", "w").close()
  for i in range(1,4001):
    actualizaTiempo()
    revisarFechas()
    servicio, tipo_servicio = generarServicio(i)
    lista_servicios.append(servicio)
    if(tipo_servicio == 'V'):
      servicio.writeServicio(f)
      servicio.writeServicioViaje(f1)
      servicio.scooter.writeHistorico()
    elif tipo_servicio == 'R':
      servicio.writeServicio(f)
      servicio.writeServicioRenta(f3)
      servicio.scooter.writeHistorico()
    else:
      servicio.writeServicio(f)
      servicio.writeServicioRecarga(f4)
      #servicio.scooter.writeHistorico()
  while lista_servicios:
    actualizaTiempo()
    revisarFechas()
  f.close()
  f1.close()
  f3.close()
  f4.close()

if __name__ == "__main__":
    main()
