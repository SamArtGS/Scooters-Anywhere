f = open('s-09-carga-inicial-ubicaciones.sql', 'w')
for i in range(1, 11):
  with open('s-09-carga-inicial-ubicaciones' + i + '.sql', 'r') as file:
    for i in file:
      f.write(i)
f.close()