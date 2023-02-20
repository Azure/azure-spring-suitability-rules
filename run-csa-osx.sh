#!/bin/bash
# bash script
# Usage: ./run-csa-osx.sh <path> [-p]

if [ $# -eq 0 -o $# -gt 2 ]; then 
  echo "Invalid arguments. Usage: ./run-csa-osx.sh <path> [-p] or ./run-csa-osx.sh [-p] <path>"
  exit 1
fi

if [ $# == 1 ] && [ $1 == "-p" ]; then 
  echo "Invalid arguments. Usage: ./run-csa-osx.sh <path> [-p] or ./run-csa-osx.sht [-p] <path>"
  exit 1
fi

if [ $# == 2 ] && [ $1 != "-p" ] && [ $2 != "-p" ]; then 
  echo "Invalid arguments. Usage: ./run-csa-osx.sh <path> [-p] or ./run-csa-osx.sh [-p] <path>"
  exit 1
fi

./csa score-models import --over-write-models
./csa rules delete-all 
./csa rules import 
./csa $1 $2 2>/dev/null
if [ $? -ne 0 ]
then
  echo & echo
  echo "Invalid argument. Path Not Found. Usage: ./run-csa-osx.sh <path> [-p] or ./run-csa-osx.sh [-p] <path>"
  exit 1
fi
./csa ui 
