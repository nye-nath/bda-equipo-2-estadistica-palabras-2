#!/bin/bash
# Ejecutar DENTRO del contenedor Hadoop
rm -rf /tmp/estadistica /tmp/multifile
mkdir -p /tmp/estadistica /tmp/multifile
wget -q https://raw.githubusercontent.com/lynnlangit/learning-hadoop-and-spark/master/0b-Example-Datasets/shakespeare-davinci/romeo.txt -O /tmp/estadistica/romeo.txt
# multifilewc necesita varios archivos: partimos el texto en pedazos
split -l 1500 -d /tmp/estadistica/romeo.txt /tmp/multifile/parte_
ls -l /tmp/estadistica /tmp/multifile
