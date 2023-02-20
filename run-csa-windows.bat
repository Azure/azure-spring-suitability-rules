:: Batch script
:: Save this file as run-csa-windows.bat
:: Usage: run-csa-windows.bat <path> [-p]
@echo off



if "%1" == "" (
  echo "Invalid arguments. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
  exit /b 1
)

if not "%3" == "" (
  echo "Invalid arguments. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
  exit /b 1
)

if "%2" == "" (
  if "%1" == "-p" (
    echo "Invalid arguments. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
    exit /b 1
  )
)

if not "%2" == "" (
  if not "%1" == "-p" (
    if not "%2" == "-p" (
      echo "Invalid arguments. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
      exit /b 1
    )
  ) 
)

csa.exe score-models import --over-write-models  || exit /b 1
csa.exe rules delete-all  || exit /b 1
csa.exe rules import  || exit /b 1
csa.exe %1 %2 2>nul
echo. & echo.
echo " #running command to analyze"
echo "csa.exe %1 %2"
if %errorlevel% neq 0 (
  :: show a custom error message instead of help message
  echo. & echo.
  echo "Invalid argument. Path Not Found. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
  pause
  exit /b
)

csa.exe ui