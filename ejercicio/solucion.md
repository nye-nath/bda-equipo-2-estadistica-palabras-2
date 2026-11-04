# Solución del Ejercicio Práctico

## Pasos para la resolución

1. Copiar los archivos de datos al contenedor Docker:
   docker cp datos_practica/ hadoop-standalone:/tmp/

2. Ejecutar MapReduce para el conteo de múltiples archivos:
   hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar multifilewc /tmp/datos_practica /tmp/salida_multi

3. Ejecutar MapReduce para calcular la desviación estándar:
   hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar wordstandarddeviation /tmp/datos_practica /tmp/salida_stddev

4. Leer el resultado obtenido:
   hadoop fs -cat /tmp/salida_stddev/part-r-00000

## Resultado Esperado
El comando mostrará el cálculo de la media y la desviación estándar de la longitud de las palabras analizadas en los datos de entrada.
