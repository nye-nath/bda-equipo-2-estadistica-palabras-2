# Equipo 2: Estadística de palabras II

Ejemplos: `wordstandarddeviation` y `multifilewc`

- Integrantes: Nathalia, Christopher y Uriel
- Grupo: IDIA 222
- Materia: Manejo Masivo de Datos (EP.02.02)

---

## 1. Qué hacen los ejemplos y para qué sirven

- `wordstandarddeviation`: calcula la desviación estándar de la longitud de las palabras de un texto. Dice qué tanto se alejan las palabras de la longitud promedio.
- `multifilewc`: cuenta cuántas veces aparece cada palabra, igual que `wordcount`, pero leyendo varios archivos de una carpeta a la vez. Junta muchos archivos en pocas tareas de map, lo cual ayuda cuando hay muchos archivos chicos.

Casos reales donde servirían:

- `wordstandarddeviation`: comparar la complejidad del vocabulario de distintos textos o autores. Un texto con palabras de largo muy parecido tiene desviación baja, y uno que mezcla palabras cortas y muy largas la tiene alta.
- `multifilewc`: sacar el vocabulario de toda una carpeta de documentos, por ejemplo artículos, correos o registros de un sistema que están repartidos en muchos archivos.

---

## 2. Requisitos

- El contenedor de Docker llamado `hadoop`, con Hadoop 3.3.6 (el de la práctica de Hadoop Standalone en contenedor Debian).
- Git instalado en tu computadora.

---

## 3. Guía paso a paso

Cada bloque dice dónde se ejecuta:

- [PC]: en la terminal de tu computadora (el prompt es algo como `usuario@equipo`)
- [CONTENEDOR]: dentro del contenedor (el prompt dice `root@hadoop`)

### Paso 1: clonar el repositorio [PC]
```bash
git clone https://github.com/nye-nath/bda-equipo-2-estadistica-palabras-2.git
cd bda-equipo-2-estadistica-palabras-2
```

### Paso 2: encender el contenedor [PC]
```bash
docker start hadoop
```

### Paso 3: copiar los scripts al contenedor [PC]
```bash
docker cp datos/descargar_datos.sh hadoop:/tmp/
docker cp scripts/ejecutar.sh hadoop:/tmp/
```

### Paso 4: entrar al contenedor [PC]
```bash
docker exec -it hadoop bash
```
El prompt cambia a `root@hadoop:/#`.

### Paso 5: descargar los datos [CONTENEDOR]
```bash
bash /tmp/descargar_datos.sh
```
Esto baja el texto de Romeo y Julieta a `/tmp/estadistica/romeo.txt`. Además lo parte en 3 archivos (`parte_00`, `parte_01` y `parte_02`) dentro de `/tmp/multifile`, porque `multifilewc` necesita una carpeta con varios archivos.

### Paso 6: correr los ejemplos [CONTENEDOR]
```bash
bash /tmp/ejecutar.sh
```
El script corre `wordstandarddeviation` sobre `romeo.txt` y `multifilewc` sobre la carpeta de los 3 archivos. Al final imprime los resultados.

### Paso 7: salir y copiar los resultados
Primero salir del contenedor [CONTENEDOR]:
```bash
exit
```
Ya en tu computadora [PC]:
```bash
docker cp hadoop:/tmp/salida_std/part-r-00000 ./resultados/std_salida.txt
docker cp hadoop:/tmp/salida_multi/part-r-00000 ./resultados/multifilewc.txt
docker exec hadoop grep "standard deviation" /tmp/std.log > resultados/desviacion.txt
```

---

## 4. Resultado esperado

Con `wordstandarddeviation`, el archivo `resultados/std_salida.txt` tiene tres líneas:
```
count   25785
length  111509
square  596141
```
y `resultados/desviacion.txt` tiene:
```
The standard deviation is: 2.101853673002583
```

Con `multifilewc`, el archivo `resultados/multifilewc.txt` tiene una línea por palabra con su conteo, por ejemplo:
```
'Ay;    1
'Ay.'   4
'Heart's        4
```
Si se suman todos los conteos de ese archivo sale 25785, el mismo `count` de `wordstandarddeviation`. Se puede comprobar con:
```bash
awk '{s+=$NF} END{print s}' resultados/multifilewc.txt
```

---

## 5. Cómo funcionan Map y Reduce aquí

[Ver el diagrama de Map y Reduce](diagrama.png)

`wordstandarddeviation`:

- Map: por cada palabra del texto emite tres pares: `(length, largo de la palabra)`, `(square, largo al cuadrado)` y `(count, 1)`.
- Combine y Reduce: suman los valores de cada clave. Queda `count = 25785`, `length = 111509` y `square = 596141`.
- Después del job, el programa principal (no el reduce) lee ese archivo y calcula la media como `length / count = 4.32` y la desviación como la raíz de `square / count - media^2`, que da 2.1018...

`multifilewc`:

- Map: lee los archivos de la carpeta (los junta en pocas tareas) y por cada palabra emite `(palabra, 1)`.
- Combine y Reduce: suman los unos de cada palabra y escriben `palabra  conteo` con los 3 archivos juntos.

Las palabras se separan por espacios, así que los signos de puntuación se quedan pegados a la palabra. Por eso en `multifilewc` aparecen `Ay`, `Ay;` y `Ay.'` como palabras distintas.

---

## 6. Problemas que aparecieron

**`container is not running`**
Se arregla con `docker start hadoop` en la terminal de tu computadora.

**`hadoop: command not found`**
Hay que usar la ruta completa, `/opt/hadoop/bin/hadoop`. Ya viene así en `ejecutar.sh`.

**Los comandos de `docker` no funcionan**
Los comandos de `docker` se escriben en la terminal de tu computadora, no donde el prompt dice `root@hadoop`.

---

## 7. Mini ejercicio

Está en la carpeta `ejercicio/`: el enunciado en `ejercicio.md` y la solución en `solucion.md`.
