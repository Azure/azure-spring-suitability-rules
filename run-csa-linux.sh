#!/bin/bash
# bash script
# Usage: ./run-csa-linux.sh <path> [-p]
if [ $# -eq 0 -o $# -gt 2 ]; then 
  echo "[ERROR] No arguments or too many arguments given. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
  exit 1
fi

if [ $# == 1 ]; then
  if [ $1 == "-p" ]; then
    echo "[ERROR] Invalid argument. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
    exit 1
  else
    if [ ! -e "$1" ]; then
      echo "[ERROR] Path $1 does not exist. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
      exit 1
    fi
  fi
fi

if [ $# == 2 ]; then 
  if [ $1 != "-p" ] && [ $2 != "-p" ]; then
    echo "[ERROR] Invalid arguments. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
    exit 1
  else
    if [ $1 == "-p" ] && [ ! -e $2 ]; then 
      echo "[ERROR] Path $2 does not exist. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
      exit 1
    fi
    if [ $2 == "-p" ] && [ ! -e $1 ]; then 
      echo "[ERROR] Path $1 does not exist. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
      exit 1
    fi
  fi
fi


./csa-l score-models import --over-write-models &>> log.txt   || { echo "[ERROR] Unexpected failure, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l rules delete-all &>> log.txt   || { echo "[ERROR] Unexpected failure, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l rules import &>> log.txt   || { echo "[ERROR] Unexpected failure, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l $1 $2 2>>log.txt || { echo "[ERROR] Unexpected failure, please validate the arguments given, usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>. You can also send log.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }
./csa-l ui 2>>log.txt || { echo "[ERROR] Unexpected failure, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting"; exit 2; }