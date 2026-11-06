# Solución: longitud promedio de las palabras

Dentro del contenedor:

```bash
cat /tmp/salida_std/part-r-00000
awk '$1=="length"{l=$2} $1=="count"{c=$2} END{print l/c}' /tmp/salida_std/part-r-00000
awk '{s+=$NF} END{print s}' /tmp/salida_multi/part-r-00000
```

Resultados:

- `count` es 25785 y `length` es 111509, así que la longitud promedio es 111509 / 25785 = 4.32457 letras por palabra.
- La suma de `multifilewc` es 25785, igual que `count`. Los dos ejemplos cuentan las mismas palabras, solo que `multifilewc` las separa por palabra y `wordstandarddeviation` las junta en tres totales.

Cómo funciona: el map de `wordstandarddeviation` emite el largo de cada palabra y el reduce los suma, así que el promedio es la suma de largos entre la cantidad de palabras.
