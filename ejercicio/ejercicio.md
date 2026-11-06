# Ejercicio: longitud promedio de las palabras

La salida de `wordstandarddeviation` trae la suma de las longitudes de todas las palabras (`length`) y cuántas palabras hay (`count`).

Con el contenedor de Hadoop y los resultados de `ejecutar.sh`:

1. Abre el archivo `/tmp/salida_std/part-r-00000` y localiza las líneas `count` y `length`.
2. Calcula la longitud promedio de las palabras (`length` entre `count`).
3. Comprueba que el total de palabras de `multifilewc` coincide con `count`. Suma la segunda columna de `/tmp/salida_multi/part-r-00000`.

Pista: en `awk`, `$NF` es la última columna de cada línea.
