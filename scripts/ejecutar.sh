#!/bin/bash
# Ejecutar DENTRO del contenedor Hadoop
HADOOP=/opt/hadoop/bin/hadoop
JAR=hadoop-mapreduce-examples-3.3.6.jar

rm -rf /tmp/salida_std /tmp/salida_multi
cd /opt/hadoop/share/hadoop/mapreduce

echo "=== wordstandarddeviation ==="
$HADOOP jar $JAR wordstandarddeviation /tmp/estadistica /tmp/salida_std 2>&1 | tee /tmp/std.log
echo "=== multifilewc ==="
$HADOOP jar $JAR multifilewc /tmp/multifile /tmp/salida_multi

echo
echo "=== RESULTADOS ==="
echo "wordstandarddeviation (count, length, square):"
cat /tmp/salida_std/part-r-00000
grep "standard deviation" /tmp/std.log
echo "multifilewc (primeras 15 líneas):"
head -15 /tmp/salida_multi/part-r-00000
