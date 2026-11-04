# Mini ejercicio

Se tiene un archivo con una sola linea:
hola mundo hola hadoop

## Parte A: a mano

1. Escribe los pares que emite el Map de wordstandarddeviation para cada palabra.
2. Escribe el resultado del Reduce para las claves count, length y square.
3. Calcula mean y stddev con las formulas del README.
4. Escribe la salida que esperarias de multifilewc para este archivo.

## Parte B: en Hadoop

Crea el archivo dentro del contenedor:
mkdir -p /tmp/equipo2/ejercicio
echo "hola mundo hola hadoop" > /tmp/equipo2/ejercicio/entrada.txt

Corre wordstandarddeviation sobre esa carpeta y compara con tu resultado de la Parte A.
