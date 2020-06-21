import random
def AsignarZona():
  scoo = {}
  for i in range(3):
    zona_id = random.randint(1, 16)
    while(scoo.get(zona_id) and scoo.get(zona_id) == 1):
      zona_id = random.randint(1, 16)
    scoo[zona_id] = 1
  return scoo

def main():
  f = open('../s-09-carga-inicial-zona_scooter.sql', 'w')
  for i in range(1, 1001):
    zonas_id = AsignarZona()
    for id in zonas_id.keys():
      f.write('INSERT INTO ZONA_SCOOTER (SCOOTER_ID, ZONA_ID) VALUES ('
        + str(i) + ","
        + str(id) + ");\n"
    )
  f.close()

main()