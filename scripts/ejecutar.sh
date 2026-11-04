#!/bin/bash
set -e

BASE=/tmp/equipo2
JAR=${HADOOP_HOME:-/opt/hadoop}/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar

if [ ! -f "$JAR" ]; then
  echo "No se encontro el jar: $JAR"
  echo "Revisa la variable HADOOP_HOME y la carpeta share/hadoop/mapreduce"
  exit 1
fi

rm -rf "$BASE/salida-wordstddev" "$BASE/salida-multifilewc"

echo "== wordstandarddeviation =="
hadoop jar "$JAR" wordstandarddeviation "$BASE/datos" "$BASE/salida-wordstddev"
cat "$BASE/salida-wordstddev/part-r-00000"

echo "== multifilewc =="
hadoop jar "$JAR" multifilewc "$BASE/datos" "$BASE/salida-multifilewc"
head -n 20 "$BASE/salida-multifilewc/part-r-00000"
