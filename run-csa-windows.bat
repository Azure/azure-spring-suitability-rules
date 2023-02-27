:: Batch script
:: Save this file as run-csa-windows.bat
:: Usage: run-csa-windows.bat <path> [-p]
@echo off



if "%1" == "" (
  echo "[ERROR] No arguments given. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
  exit /b 1
)

if not "%3" == "" (
  echo "[ERROR] Too many arguments. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
  exit /b 1
)

if "%2" == "" (
  if "%1" == "-p" (
    echo "[ERROR] Invalid argument. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
    exit /b 1
  ) else (
    if not exist "%1" (
      echo "[ERROR] Path %1 does not exist. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
      exit /b 1
    )
  )
)

if not "%2" == "" (
  if not "%1" == "-p" (
    if not "%2" == "-p" (
      echo "[ERROR] Invalid arguments. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
      exit /b 1
    )
    if not exist "%1" (
      echo "[ERROR] Path %1 does not exist. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
      exit /b 1
    )
  ) else (
      if not exist "%2" (
        echo "[ERROR] Path %2 does not exist. Usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>"
        exit /b 1
      )
  )
)


:: ignore circumstances in which command has error but exit code is 0
csa.exe score-models import --over-write-models >> log.txt 2>>&1
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe rules delete-all >> log.txt 2>>&1
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe rules import >> log.txt 2>>&1
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe %1 %2 2>>log.txt
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%, please validate the arguments given, usage: run-csa-windows.bat <path> [-p] or run-csa-windows.bat [-p] <path>. You can also end the log.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)

csa.exe ui 2>>log.txt
IF %ERRORLEVEL% NEQ 0 ( echo "[ERROR] Unexpected failure, exit code: %errorlevel%%, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting" && exit /b 2)