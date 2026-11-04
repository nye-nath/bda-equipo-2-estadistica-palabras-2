# Proyecto MapReduce - Equipo 2: Estadística de palabras II

## Integrantes del equipo
- Nathalia
- Christopher
- Uriel

## Descripción de los ejemplos y casos de uso real

Este proyecto abarca la implementación de dos algoritmos de procesamiento distribuido mediante Hadoop MapReduce:

1. wordstandarddeviation: Calcula la desviación estándar y la media de las longitudes de las palabras procesadas en un corpus de texto. Su caso de uso real aplica en el análisis estilométrico de textos, detección de generación automática de contenido y filtrado de datos sintéticos donde la longitud de los términos sigue patrones estadísticos específicos.

2. multifilewc: Extiende el algoritmo clásico de conteo de palabras para procesar entradas distribuidas a través de múltiples archivos de forma simultánea sin necesidad de concatenar previamente los datos. Su caso de uso real incluye el procesamiento de registros de auditoría distribuidos en servidores independientes o análisis de logs divididos por fecha.

## Requisitos previos
- Contenedor con Hadoop 3.3.6 configurado y en ejecución en modo Standalone.
- Acceso a la terminal local Linux con cliente Docker instalado.

## Guía de ejecución paso a paso

### Paso 1: Preparación de archivos en el sistema local
Los comandos señalados con [LOCAL] se ejecutan en la terminal de la computadora anfitriona.

[LOCAL] Copiar el directorio de datos al contenedor de Hadoop:
docker cp datos/ hadoop-standalone:/home/hadoop/

### Paso 2: Ejecución del procesamiento distribuido
Los comandos señalados con [CONTENEDOR] se ejecutan dentro de la sesión bash del contenedor Docker.

[LOCAL] Acceso a la terminal del contenedor:
docker exec -it hadoop-standalone bash

[CONTENEDOR] Asignación de permisos al script de ejecución automatizada:
chmod +x /home/hadoop/scripts/ejecutar.sh

[CONTENEDOR] Ejecución del job MapReduce:
/home/hadoop/scripts/ejecutar.sh

### Paso 3: Extracción de resultados
[LOCAL] Copia de las salidas generadas desde el contenedor hacia el repositorio local:
docker cp hadoop-standalone:/user/hadoop/salida_stddev/part-r-00000 ./resultados/resultado_stddev.txt
docker cp hadoop-standalone:/user/hadoop/salida_multifile/part-r-00000 ./resultados/resultado_multifile.txt

## Resultado esperado
Al finalizar la ejecución, el archivo resultado_stddev.txt contendrá dos valores numéricos que representan la media y la desviación estándar de la longitud de las palabras analizadas. El archivo resultado_multifile.txt contendrá pares clave-valor listando cada término junto con la frecuencia total de apariciones acumulada entre todos los archivos procesados.

## Explicación del funcionamiento de Map y Reduce

### Ejemplo: wordstandarddeviation
- Fase Map: Cada nodo lee líneas de texto, descompone cada término y emite como clave la longitud de la palabra y como valor la cantidad 1.
- Fase Reduce: Se agregan las frecuencias por longitud, calculando la suma total de palabras, la suma de las longitudes al cuadrado y aplicando la fórmula estadística para obtener la media y la desviación estándar final del conjunto.

### Ejemplo: multifilewc
- Fase Map: El RecordReader especializado procesa bloques provenientes de múltiples fuentes independientes en paralelo. Emite la palabra como clave y el valor 1.
- Fase Reduce: Suma las frecuencias recibidas de las distintas fuentes para generar un conteo consolidado por término.

## Errores comunes y soluciones

1. Error: Output directory already exists.
   Causa: Hadoop no permite sobrescribir directorios de salida existentes en HDFS por razones de integridad.
   Solución: Eliminar el directorio de salida previo antes de cada ejecución mediante el comando `hadoop fs -rm -r -f <directorio>`.

2. Error: Could not find or load main class.
   Causa: Nombre incorrecto del ejemplo o versión de JAR no localizada.
   Solución: Especificar la ruta absoluta al ejecutable del archivo JAR `/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar`.
