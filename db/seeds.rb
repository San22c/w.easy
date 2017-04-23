# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Estandar.create(tipo:'TIPOGRAFIA', descripcion:'Fuente del texto pertenece a los estilos aceptados')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'El tamaño del texto tiene que ser como minimo 12 y como maximo 16')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'No existe texto en cursiva')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'No existen mas de % textos en negrita')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'No existen mas de % textos en subrayado')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'No existen textos con sombreado')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'No existen mas de % textos en mayusculas')
Estandar.create(tipo:'TIPOGRAFIA', descripcion:'Color de fuente NEGRO')
Estandar.create(tipo:'DISEÑO', descripcion:'Color de fondo BLANCO solido')
Estandar.create(tipo:'DISEÑO', descripcion:'Cantidad de palabras en la diapositiva no supere el limite establecido')
