# Equipo 2: Estadística de palabras II

Práctica de Hadoop MapReduce sobre dos ejemplos incluidos en Hadoop 3.3.6: wordstandarddeviation y multifilewc.

## Integrantes

- Nathalia
- Christopher
- Uriel

## Descripción

- wordstandarddeviation: calcula el promedio y la desviación estándar de la longitud de las palabras de un texto.
- multifilewc: cuenta las palabras igual que wordcount, pero lee muchos archivos pequeños agrupados en pocas tareas map.

### Caso de uso

wordstandarddeviation sirve para medir qué tan variable es la longitud de las palabras en un corpus grande. Por ejemplo, para comparar el estilo de dos autores o para detectar texto generado automáticamente.

multifilewc atiende un problema conocido de Hadoop: con wordcount normal, cada archivo pequeño genera su propia tarea map. multifilewc junta varios archivos en un mismo split.

## Requisitos

- Docker instalado en la computadora.
- El contenedor Debian con Hadoop 3.3.6 funcionando llamado hadoop.
- Git.

## Contenido del repositorio

- datos/ (4 textos de entrada)
- scripts/ejecutar.sh (script que corre dentro del contenedor)
- resultados/ (salida de cada ejemplo y consola.txt)
- ejercicio/ (ejercicio.md y solucion.md)

## Paso a paso

1. Copiar datos y script al contenedor:
docker exec hadoop mkdir -p /tmp/equipo2
docker cp datos hadoop:/tmp/equipo2/
docker cp scripts/ejecutar.sh hadoop:/tmp/equipo2/ejecutar.sh

2. Ejecutar los ejemplos:
docker exec hadoop bash /tmp/equipo2/ejecutar.sh

3. Traer los resultados a la computadora:
mkdir -p resultados/wordstddev resultados/multifilewc
docker cp hadoop:/tmp/equipo2/salida-wordstddev/. resultados/wordstddev/
docker cp hadoop:/tmp/equipo2/salida-multifilewc/. resultados/multifilewc/

## Explicación de Map y Reduce

### wordstandarddeviation
- Map: por cada palabra emite (count, 1), (length, n) y (square, n^2).
- Reduce: suma cada clave y calcula el promedio y la desviación estándar final.

### multifilewc
- Map: agrupa varios archivos en un mismo split y emite (palabra, 1).
- Reduce: suma las frecuencias de cada palabra.

## Errores comunes y cómo se resolvieron

- Output directory already exists: se soluciona borrando las carpetas de salida previas antes de ejecutar.
- JAR does not exist: se verifica la ruta del JAR de ejemplos de Hadoop 3.3.6.
