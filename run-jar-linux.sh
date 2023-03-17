#!/bin/bash
# bash script
# Usage: ./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]

echo ""
echo "./run-jar-linux.sh $1 $2 $3">> log-jar.txt
if [ $# -eq 0 -o $# -gt 2 ]; then 
  echo "[ERROR] No arguments or too many arguments given. Usage: ./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]"
  exit 1
fi

if [ $# == 1 ]; then
  if [ ! -f "$1" ]; then
    echo "[ERROR] Jar file $1 does not exist. Usage: ./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]"
    exit 1
  fi
fi

if [ $# == 2 ]; then 
  if [[ $1 != --decompile-dir=* ]] && [[ $2 != --decompile-dir=* ]]; then
    echo "[ERROR] Invalid arguments. Usage: ./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]"
    exit 1
  else
    if [[ $1 == --decompile-dir=* ]] && [ ! -f $2 ]; then
      echo "[ERROR] Jar file $2 does not exist. Usage: ./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]"
      exit 1
    fi
    if [[ $2 == --decompile-dir=* ]] && [ ! -f $1 ]; then
      echo "[ERROR] Jar file $1 does not exist. Usage: ./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]"
      exit 1
    fi
  fi
fi


./csa-l score-models import --over-write-models &>> log-jar.txt   || { echo "[ERROR] Unexpected failure, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l rules delete-all &>> log-jar.txt   || { echo "[ERROR] Unexpected failure, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l rules import &>> log-jar.txt   || { echo "[ERROR] Unexpected failure, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l $1 $2 -a 2>>log-jar.txt || { echo "[ERROR] Unexpected failure, please validate the arguments given, usage: ./run-jar-linux.sh <path> [-p] or ./run-jar-linux.sh [-p] <path>. You can also send log-jar.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l ui 2>>log-jar.txt || { echo "[ERROR] Unexpected failure, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }