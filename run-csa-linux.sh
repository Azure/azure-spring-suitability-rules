#!/bin/bash
# bash script
# Usage: ./run-csa-linux.sh <path> [-p]

if [ $# -eq 0 -o $# -gt 2 ]; then 
  echo "Invalid arguments. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
  exit 1
fi

if [ $# == 1 ] && [ $1 == "-p" ]; then 
  echo "Invalid arguments. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sht [-p] <path>"
  exit 1
fi

if [ $# == 2 ] && [ $1 != "-p" ] && [ $2 != "-p" ]; then 
  echo "Invalid arguments. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
  exit 1
fi

./csa-l score-models import --over-write-models
./csa-l rules delete-all 
./csa-l rules import 
./csa-l $1 $2 2>/dev/null
if [ $? -ne 0 ]
then
  echo & echo
  echo "Invalid argument. Path Not Found. Usage: ./run-csa-linux.sh <path> [-p] or ./run-csa-linux.sh [-p] <path>"
  exit 1
fi
./csa-l ui 
