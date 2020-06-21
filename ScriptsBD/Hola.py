f = open('s-09-carga-inicial-ubicaciones.sql', 'w')
for i in range(1, 11):
  with open('s-09-carga-inicial-ubicaciones' + str(i) + '.sql', 'r') as file:
    for line in file:
      f.write(line)
f.close()